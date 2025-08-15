---
layout: default
title: Tag Debug
permalink: /tags-debug/
---

<h1>All Tags in site.posts</h1>
<p>This page shows every tag GitHub Pages sees in the live Jekyll build. Click any tag to visit its tag page.</p>

<ul>
{% assign all_tags = "" | split: "" %}
{% for post in site.posts %}
  {% for t in post.tags %}
    {% assign all_tags = all_tags | push: t %}
  {% endfor %}
{% endfor %}

{% assign all_tags = all_tags | uniq | sort %}

{% for tag in all_tags %}
  <li>
    {{ tag }} → 
    <a href="{{ '/tag/' | append: tag | append: '/' | relative_url }}">
      /tag/{{ tag }}/
    </a>
  </li>
{% endfor %}
</ul>
