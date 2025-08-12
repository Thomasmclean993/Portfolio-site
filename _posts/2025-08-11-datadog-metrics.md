---
layout: post
current: post
cover:  assets/images/endless-code.jpg
navigation: True
title: How I Added Custom Datadog Metrics using an Unsupported Language. 
date: 2025-08-11 09:00:00
tags: [work-experience, tech-stack]
class: post-template
subclass: 'post'
author: thomas
---
First, let me address the elephant in the room: OpenTelemetry. Yes, I’m aware of the protocol, and my team could have used it. But due to some limiting factors, it wasn’t an option for us.

We tried it before and ran into issues. This was before I owned the project, so I don’t know all the specifics.
Our DevOps team advised against it due to constraints within our organization’s Datadog setup.
So, we needed an alternative—and I built one.

## Context
My team was told that our existing monitoring tools would no longer be supported due to expiring contracts and a company-wide push to use Datadog instead of Grafana/Sentry. Honestly, I didn’t mind; I like Datadog a lot. I’ve used it in contract work and personal projects. But our team capacity was limited. We’d just lost both of our SMEs for monitoring/observability, we had a high-priority project that was already behind, and the clock was ticking on our expiring tools.

My manager asked, “Can you do this?”

Fresh off a large cross-team project I’d led, I was ready for something that would help my team and require a bit of creativity. This project had it all:

A looming deadline.
A clear high-level problem, but no technical requirements.
The need for metrics to appear in Datadog, but no official support for Elixir, and OpenTelemetry wasn’t an option.
I was in. Let’s do this.

## What is DogStatsD?
After some research, I discovered that Datadog provides a way to receive custom application metrics: DogStatsD.

<details> <summary>DogStatsD Overview</summary>
DogStatsD is Datadog’s custom implementation of the StatsD protocol, designed to collect and aggregate application metrics. It works by having your application send metrics over UDP to a local Datadog Agent, which then forwards them to Datadog’s backend for visualization and alerting.<br /> 
<br />
The beauty of DogStatsD is its simplicity and performance: UDP is fast and non-blocking, so your application can fire off metrics without waiting for a response. Plus, DogStatsD supports advanced features like tags, service checks, and events, making it a powerful tool for custom monitoring—even if your language isn’t officially supported.
<hr>

</details>
So, communicating with Datadog was possible—I just needed to give our application the ability to do so. My solution started to take shape:

Connect to the Datadog agent.
Create an adaptor to translate metrics into the format Datadog expects.
Add metric calls to our business logic.
Connecting to Datadog Using Statix
I decided to use the Statix library, which allows you to write directly to a Datadog StatsD server. The default host and port can be found in the library documentation.

First, start up the connection in application.ex:

```elixir

# application.ex
def start(_type, _args) do
  :ok = MyApplication.Metrics.DatadogAdaptor.connect()
  ...
end
```
And configure Statix in config.ex:

```elixir

# config.ex
config :statix,
  prefix: "sample",
  host: "YOUR_DATADOG_HOST",
  port: YOUR_DATADOG_PORT
```

To use the library, simply call use in your adaptor module:
 
```elixir
# DatadogAdaptor.ex
defmodule Metrics.DatadogAdaptor do
  use Statix, runtime_config: true
end
```
---

## The Implementation
This is the fun part—where I actually get to code, not just follow instructions.

I decided to use the Adapter Design Pattern. This was our team’s first adapter, but it set a precedent for future projects. (I may write a post just about adapters later.) In short, it’s a middleman layer that allows the application to interact with an otherwise incompatible interface. It also creates a single point for logic, making future changes modular and manageable.

Datadog Tags and Phoenix Plugs
If you’re not familiar with Datadog’s dashboard, I love how simple the filters and pages are. Datadog uses tags to filter dashboards, monitoring, APM, etc.—a very streamlined approach. For our application, we had agreed-upon required tags for each metric (I called these “global tags”), plus process-specific tags unique to each request.

Luckily, Phoenix (Elixir’s most famous framework) has something called a [Plug]. Plugs are a middleware-like layer that lets you add logic to your application’s request pipeline.

<details> <summary>Plug and Pipeline</summary> Plugs are a great place to add logic that’s necessary for the service of the application but isn’t business logic—like monitoring. We keep plugs organized using the pipeline macro. <hr> </details>

```elixir

# MyApp_web.Router.ex

pipeline :monitoring do
  plug(MyApp.Plug.SetMetricTags)
  #...
end

scope "/prior_auth" do
  post("/investigation", InsuranceInvestigationController, :create)
end
```
Since my logic isn’t business logic and needs to affect every request for this endpoint, I created a plug that I can add to the pipeline:

```elixir

defmodule MyApp.Plug.SetMetricTags do
  import Plug.Conn

  def init(options), do: options

  def call(conn, _options) do
    router = conn.private.phoenix_router
    request_path = conn.request_path
    method = conn.method

    %{plug: controller, plug_opts: controller_function} =
      Phoenix.Router.route_info(router, method, request_path, "")

    metric_tags = [
      "controller:#{to_string(controller)}",
      "is_test_message:#{conn.assigns[:is_test_message] || false}",
      "route:#{request_path}"
    ]

    Process.put(:metric_tags, metric_tags)
    assign(conn, :metric_tags, metric_tags)
  end
end
```
---

This adds the list of metric_tags to the process dictionary, making them globally available throughout the application. We’ll add request-specific tags when we create the metric itself.

### Metric Adapter and Request-Specific Tags
Finally, the adapter. The objectives here:

- Create the metric name.
- Retrieve the global tags from the SetMetricTags plug.
- Add process-specific tags and combine them with the global tags.

Since this was a first for me, my main focus was readability and clarity. Most of the devs on my team hadn’t done something like this before, so it was on me to make it clear for everyone—senior, mid, and junior alike.

First, let’s pull the global metrics. Datadog requires them to be a list/array of strings.

<details> <summary>Breakdown of the Elixir Code Below</summary> If you’re not familiar, this may look confusing. 
  Elixir allows two things:<br /> 
  |-> <b>Function Header Pattern Matching:</b> You can destructure a function’s parameters directly in the header, as long as they match the expected type. <br /> 
  |-> <b>Overloading:</b> You can define multiple functions with the same name but different parameters, creating different implementations. 
<hr>
</details>

```elixir

# MyApp.Metrics.MetricsAdaptor

defp collect_module_tags([_ | _] = module_tags) do
  Enum.map(
    module_tags,
    fn {key, value} -> "#{key}:#{value}" end
  )
end

defp collect_module_tags([]), do: []

defp collect_module_tags(module_tags) do
  raise "Tags passed into Metrics.increment directly from the module should be a list. Attempted tags: #{module_tags}"
end
```
This logic combines the request-specific tags and the global tags into a single list. Next, I sanitize the metric names for uniformity:

```elixir

# MyApp.Metrics.MetricsAdaptor

@spec sanitize_metric_name(term()) :: String.t()
def sanitize_metric_name(metric) when is_binary(metric) do
  String.replace(metric, " ", "_")
end

def sanitize_metric_name(metric) do
  metric
  |> inspect # Returns a binary metric name
  |> sanitize_metric_name
end
```
---
#### Result:

Metric Name Sanitization: Convert external request → Convert_external_request
Tag List: [is_test_message: true, controller: "/benefit_investigation"] → ["is_test_message:true", "controller:/benefit_investigation"]
With the tags combined and metric names sanitized, we’re ready to send metrics to the Datadog agent.

```elixir

# Datadog.Tags.ex

def fetch do
  case Process.get(:metric_tags) do
    nil -> """
    Failed to retrieve the :metric_tags from Process Dictionary.
    """
    metric_tags -> # Catch-all
      if is_list(metric_tags), do: metric_tags, else: List.wrap(metric_tags)
  end
end

# MyApp.Metrics.MetricsAdaptor

use Statix, runtime_config: true

@doc "Increment/2 increases/adds a metric to Datadog by 1"
@spec increment(String.t(), list()) :: :ok
def increment(metric, tags \\ []) do
  datadog_tags = Tags.fetch() ++ collect_module_tags(tags)
  Statix.increment(metric, 1, tags: datadog_tags)
end
```
---
Now, I just need to call the increment/2 function in my business logic and—boom!—the metric appears in Datadog. I can’t show our business logic, but when I’m done with my side project (which uses a similar implementation), I’ll add screenshots below.

Example of the finished product in Datadog:

![Datadog Metrics]({{ site.relative_url }}../assets/images/datadog-metrics.png)

## What Would I Change? (And an Idea)
I’m not a fan of calling Metric.increment directly within business logic. I know, we’re starting to wade into Elixir/Functional’s “no side effects” territory! Allow me a quick soapbox moment: side effects are only a problem when they’re hidden and untraceable. By keeping them minimal and well-documented, it’s manageable.

That said, I had an idea: a decorator-like implementation that watches for certain logic and then triggers the Metric.increment call. There’s a lot to figure out, but maybe a library or something similar could combine aspect-oriented programming, OpenTelemetry, and some kind of event watcher. I think it could be really useful.
