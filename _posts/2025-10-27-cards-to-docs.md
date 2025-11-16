---
layout: post
current: post
cover: assets/images/report-card.gif
navigation: True
title: Connecting Cards to Documentation
date: 2025-10-27 8:00:00
tags: [rants, woek-experience]
class: post-template
subclass: "post"
author: thomas
---

<blockquote>
"What happens if I'm hit by a bus tomorrow?"
</blockquote>

![Truck-kun](https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExMm5ud2V6Nmd2YW9kMWZ3aXJza2NsZGNhNXVtZTY1Ym9renFleWx0YyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/1yT0KoIBdn8KzQVBJX/giphy.gif)

There are few sayings that remain as true as this one. It's often said when one person or a small number of people has all the important information about a project or part of the stack, but no physical documentation exists anywhere(A silo).


It's something that was hammered into me since I was a junior. Documentation un-silos information, allowing any dev to pick up work and make progress. Documentation can be used to track progress as well, outside of a kanban system or whatever flavor your team uses.

Something recently happened that changed my approach, and I wanted to discuss it here.

## The Problem 
I had to take some sudden PTO. I couldn't check my phone or my laptop. Now, I was also the owner of a project that was nearing its deadline. I left it up to my team to finish a final piece of the project: adding some creds to connect to a client and flipping a toggle to enable some testing for an internal partner.

Before I left, I updated my documentation and shared links with my team. 

Came back after a few days--not only was the testing not complete, it wasn't even started. There was some confusion on how the creds were being used forthis integration. The seniors couldn't help much because they didn't know are well. Suddenly I found myself, once again as a silo. The card sat untouched til the day that I got back. 

Why did this happen? I shared my documentation in the teams channel. I even shared the documentation with my leader before leaving. This bothered me because the project could have been complete earlier than planned, unblocking another project. This is also not the first time something like this happened. 

During stand up, I asked, and the answer surprised me. **"What documentation?"**

Our manager had to attend an RTO onsite that week, a launch of another project, and they were human. The links I shared were buried in the Teams chat.

**So, Problem: Documentation is not readily available to others due to lack of visibility.**
![My Problem](https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExMDA2ZW40ZzZybnFoc2JzbzRneXZueDdnaHFxc2xjcGJjOTgybHA2NSZlcD12MV9naWZzX3NlYXJjaCZjdD1n/syoBxnXVugdtDkKOxw/giphy.gif)

## The "Solution" I Didn't Love

During retro, I asked our team, mostly the seniors, what the best practice was for sharing documentation.

"Put the documentation on the card" was the overall verdict.

I didn't and still don't agree with this method. What about:

- The information that isn't necessary for the work on the card but is necessary for the project as a whole?
- What about test cases?
- Requirements?
- What are our business partners doing on their end to help complete the project?

There is so much information that may be needed. This all can't live on a card.

## My Compromise

I wanted me team to be able to find the documentation that was necessary for the card, on the card. I don't want to add unnecessary documentation on the vard but still available when needed. I needed something that was unobtrusive while also very visible. So I came up with a compromise that will make my team happy and rememdy the curse of the silo.
![The Curse](https://media.giphy.com/media/v1.Y2lkPWVjZjA1ZTQ3amMxMnRyZ28yaXplZzY2cndtOGY2dzk2YTc3emFkbzNzOHV1bjhpMSZlcD12MV9naWZzX3JlbGF0ZWQmY3Q9Zw/BYdpzXoQskl9Yh6FAY/giphy.gif)

**First**, I started adding links to my documentation on the cards themselves. It was a happy compromise. If someone needed to figure something out and I wasn't available, it's right there.

**Second**, on the documentation itself, I added links to the cards for the associated work. I was basically home-brewing Obsidian's data connection web. So there can't be any questions about what they should read and what can be skipped

## Foreseen and unforeseen Benefits

Surprisingly, this style of documentation linking came with some unforeseen benefits:

| Benefit | Details |
| --- | --- |
| Understanding the cards and the projects as a whole | The work on the card and the User story/ Acceptance Criteria was much easier |
| Epics/Stories — the group of cards — are more complete | Fewer cards were added later to fill in the gaps |
| A lot less questions | I'm asked a lot less questions. When I am, usually during refinement of the cards, it is something that was missing from the documentation. |

This strategy opened up some doors for me. It made project planning and the refinement stage much more easier, allowing me to juggle multiple projects without dropping the ball. Sometimes the simplest- just linking things together- make all the difference.

Peace out! 🫶🏻
