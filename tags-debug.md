---
layout: default
title: Tag Debug
permalink: /tags-debug/
---

<h1>Posts and Their Tags</h1>
<p>This page lists each post in the deployed site with all the tags Jekyll sees. Click a tag link to go directly to its tag page.</p>

<ul>
{% for post in site.posts %}
  <li>
    <strong>{{ post.title }}</strong>  
    <em>({{ post.date | date: "%Y-%m-%d" }})</em>
    {% if post.tags %}
      <ul>
        {% for t in post.tags %}
          <li>
            {{ t }} → 
            <a href="{{ '/tag/' | append: t | append: '/' | relative_url }}">
              /tag/{{ t }}/
            </a>
          </li>
        {% endfor %}
      </ul>
    {% else %}
      <span style="color:red;">No tags</span>
    {% endif %}
  </li>
{% endfor %}
</ul>
