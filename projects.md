---
layout: page
title: Projects
permalink: /projects/
---

<div class="post-feed">
  {% assign words_per_minute = site.words_per_minute | default: 200 %}
  {% for project in site.projects %}
    <article class="post-card{% unless project.cover %} no-image{% endunless %}">
        
        {% if project.cover %}
            <a class="post-card-image-link" 
               href="{% if project.external_url %}{{ project.external_url }}{% else %}{{ project.url | relative_url }}{% endif %}" 
               {% if project.external_url %}target="_blank" rel="noopener"{% endif %}>
                <div class="post-card-image" style="background-image: url('{{ project.cover | relative_url }}')"></div>
            </a>
        {% endif %}
        
        <div class="post-card-content">
            <a class="post-card-content-link" 
               href="{% if project.external_url %}{{ project.external_url }}{% else %}{{ project.url | relative_url }}{% endif %}" 
               {% if project.external_url %}target="_blank" rel="noopener"{% endif %}>
               
                <header class="post-card-header">
                    {% if project.tags %}
                        {% for tag in project.tags %}
                            <span class="post-card-tags">{{ tag | capitalize }}</span>
                        {% endfor %}
                    {% endif %}
                    
                    {% if project.status %}
                        <span class="project-status-label">{{ project.status }}</span>
                    {% endif %}
                    
                    <h2 class="post-card-title">{{ project.title }}</h2>
                </header>
                
                <section class="post-card-excerpt">
                    {% if project.excerpt %}
                        <p>{{ project.excerpt | strip_html | truncatewords: 33, "" }}</p>
                    {% else %}
                        <p>{{ project.content | strip_html | truncatewords: 33, "" }}</p>
                    {% endif %}
                </section>
            </a>
            
            <footer class="post-card-meta">
                {% for author in site.data.authors %}
                    {% if author[1].username == project.author %}
                        {% if author[1].picture %}
                        <img class="author-profile-image" src="{{ author[1].picture | relative_url }}" alt="{{ author[1].name }}" />
                        {% endif %}
                        <span class="post-card-author">
                            <a href="{{ '/author/' | append: project.author | relative_url }}">{{ author[1].name }}</a>
                        </span>
                    {% endif %}
                {% endfor %}
                
                <span class="reading-time">
                    {% assign words = project.content | strip_html | number_of_words %}
                    {% if words <= words_per_minute %}
                      1 min read
                    {% else %}
                      {{ words | divided_by:words_per_minute }} min read
                    {% endif %}
                </span>
            </footer>
        </div>
    </article>
  {% endfor %}
</div>
