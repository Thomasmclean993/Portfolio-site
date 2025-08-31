---
layout: post
current: post
cover:  assets/images/task.gif
navigation: True
title: Task Management and My Second Brain
date: 2025-08-11 8:00:00
tags: [setup, rants]
class: post-template
subclass: 'post'
author: thomas
---

I was pairing with an intern the other day. They were a little confused about how some of my Elixir code behaved, so they started asking questions. After some back-and-forth, they hit me with a surprisingly good one: **“What’s something you didn’t expect would be a challenge as a developer?”** 

After sitting with that question for a while, I realized I had a few answers: 
- Communicating with different types of people. 
- Writing clear documentation. 
- Figuring out how often I need to query a database (and how much indexes matter). 

But there’s one challenge I almost never see talked about: **task management.** Sure, I hear about project management or time management — there are endless books and how‑tos on those. But what about the plain, everyday skill of juggling *tasks* as a developer? That one doesn’t get nearly enough airtime. 

## How Many Tasks Do I Usually Own?

I work at a company that keeps teams pretty lean while still chasing quarterly objectives. Translation: it’s rare for anyone to own just one thing at a time. A typical week for me looks like: 
- **A KPI-related project with a hard deadline** 
- **Another project aligned with a longer‑term objective** (something that eventually impacts a KPI) 
- **A technical improvement project** (monitoring, logging, performance tuning) 
- **A product manager’s “quick ask”** (usually an investigation into a potential feature or product idea) 

And that’s just projects. Each one breaks down into many smaller tasks that all need tracking — and that’s before we even bring up being on‑call. So my daily task list is in constant flux. Priorities get reshuffled, people become unavailable, and something new is always getting dropped on my plate. It’s an overlooked aspect of “wearing many hats”: to juggle it all, I need a system. A way to track what matters now, what can wait, and what needs to be handed off. 

Naturally, I went down the ![rabbit hole](https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExMW1sajBzbnFtZ3YzODE0eGp5ZDd5b3BmNG96NXh6YzAxeGY3ZGg2YyZlcD12MV9naWZzX3NlYXJjaCZjdD1n/T1GWTCSrTr2tnsvq4k/giphy.gif) My favorite learning platform? **YouTube University.** After a few late nights and way too many productivity videos, I decided to give [this recommendation](https://www.youtube.com/watch?v=m9S5I3pWz94) from Thomas Frank a try. 

## The Second Brain (via Notion) 

A **Second Brain** is basically a knowledge management system — an external place to capture, organize, and connect information so your actual brain doesn’t have to juggle 300 unrelated things at once. I spun mine up in Notion. 

Imagine a mix of: 
- A projects-and-tasks database 
- A notes section 
- A documentation hub for everything I touched -> ![this setup](assets/images/Notion.png)

At one point, my Notion workspace grew so massive that I had to contact support to help recover it. That’s when I realized: I had unintentionally created a wiki that could rival a startup’s internal knowledge base. And honestly? It wasn’t a bad thing. Notion saved me countless times when switching hats between projects. But it was also *overkill*. I didn’t need a personal encyclopedia for every little task. You’d think I learned my lesson there. I didn’t. 

## Obsidian: Notion, the Sequel

If Neovim is my Michael Jordan and Aerospace is my Scottie Pippen, then Obsidian is… let’s say Dennis Rodman. 

Not a sports fan? Fine — if Neovim is Garrus Vakarian and Aerospace is Thane Krios, then Obsidian is Mordin Solus. Still nothing? Alright: 

Neovim = Paladin, Aerospace = Monk, Obsidian = Cleric. Nothing, ![Still?](https://media.giphy.com/media/v1.Y2lkPWVjZjA1ZTQ3YXYwazMyN2hmZTBjenMxb2UzOHE1MGIxdTJpdTA3N2RuZmhmYWU4aiZlcD12MV9naWZzX3NlYXJjaCZjdD1n/gkFtBo3xl05UR9FA2Q/giphy.gif)

The point is: Obsidian completely changed how I was managing tasks. At first, I recreated my Notion workflow: task tables, sub-tasks, each task with its own linked note page. But that quickly led to a graveyard of dead links and pointless pages. Obsidian wasn’t the problem here — I was. I had rebuilt Notion inside of Obsidian. To make matters worse, I piled on plugins, automations, daily notes, reminders, and calendars until it all started to crumble under its own weight. My once-lightweight markdown app froze up like it was running on dial-up. Something had to change.

## My Current Minimalist Setup
I finally stripped everything back down. Now my system is simple, lightweight, and portable across all my machines: 
- **[Taskwarrior](https://taskwarrior.org/docs/start/)** for task management – a CLI tool that lets me keep tasks in their purest form, with a few optional fields for tracking what actually matters. 
- **[Obsidian](https://obsidian.md)** for notes – yes, I kept it, but now it’s just for actual note-taking. No bloated project databases, no endless documentation dumps. I only write down what I *need*. And that’s it. 

## Closing Thoughts
What started as me trying to wrangle my ever-shifting list of daily tasks somehow spiraled into building a full-blown digital encyclopedia… twice. But along the way, I learned something that was simple but liberating: **figuring out how to manage my tasks without them managing me.** 
