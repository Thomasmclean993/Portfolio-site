---
layout: post
current: post
cover: assets/images/report-card.gif
navigation: True
title: Bad Feedback
date: 2025-10-14 8:00:00
tags: [rants]
class: post-template
subclass: "post"
author: thomas
---

Recently, I received some feedback on a take-home assignment—and I have a feeling the reviewer didn’t expect I’d ever see it. It was written plainly, 😆. But that’s not the point of this post. I want to focus on the content of the feedback, which can be summed up as:

- I didn’t validate external values
- I used older libraries

After reviewing my project carefully, it became clear the reviewer had strong opinions about how things should be done. Their focus seemed less on questions like:

    Was the project completed successfully?
    Was it implemented correctly?
    Were there any safety concerns?

and more on style and preferred approaches.

This isn’t a post to complain about the review or the company. It’s about what I learned and how I grew from it. It's funny, because I've told everyone of my mentees this once.

## You Can "Fail" Even When the Tech Is Right

Sure, I could dwell on being rejected even though my project was technically sound.

_OR_

I could treat it as an opportunity to improve my skills—and that’s what I chose.

After some retrospection, here’s what I discovered:

- The applications I usually work on rely on libraries that are a decade old.
- I need to be more intentional about where I place important logic in my code.

## Outdated Libraries, Updated Myself

When I’m about to use a library, I can take five extra minutes to research which one is the best for the task now. Not just rely on what my work projects use.

For example, in this project, I used HTTPoison—an HTTP library in Elixir that, apparently, no one online is using anymore (I checked—crickets 🦗). There are several modern alternatives I could have reached for instead. Lesson learned: keep my toolset fresh.

## Where’s the Important Stuff?

The first bullet in my feedback said I wasn’t validating external values. That’s a big deal in backend development—but also a bit frustrating, because… I did write the validations! They were tested, referenced, and working fine. The problem? I tucked them away too deep in the codebase. The reviewer would have had to dig through three files to find them.

Validation of external input is important enough to be right up front in the logic—called clearly and named meaningfully—so anyone reading the code can spot it immediately. I lost points not because it wasn’t done, but because it wasn’t visible.

That was eye-opening.

## Some Final Thoughts

The project didn’t get me the job—but it definitely made me a better developer. The feedback helped me modernize my library choices, write clearer logic, and think about how others read my code.

Any feedback, when handled the right way, can be good feedback.

Peace out! 🫶🏻
