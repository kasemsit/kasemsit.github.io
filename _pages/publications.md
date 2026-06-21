---
layout: page
permalink: /publications/
title: publications
description: Publications grouped by category, in reverse chronological order. Names in bold indicate my authorship.
nav: true
nav_order: 1
---

<!-- _pages/publications.md -->

<!-- Bibsearch Feature -->

{% include bib_search.liquid %}

<div class="publications">

<h2 class="pub-category">International Journals</h2>
{% bibliography --query @*[category=intl_journal] %}

<h2 class="pub-category">International Conferences with Full Articles</h2>
{% bibliography --query @*[category=intl_conf] %}

<h2 class="pub-category">Short Peer-reviewed Conference Articles</h2>
{% bibliography --query @*[category=short_conf] %}

<h2 class="pub-category">National Journal</h2>
{% bibliography --query @*[category=national_journal] %}

</div>

<style>
  .publications h2.pub-category {
    color: var(--global-theme-color);
    border-bottom: 2px solid var(--global-theme-color);
    padding-bottom: 0.3rem;
    margin-top: 2.5rem;
    margin-bottom: 1rem;
    text-align: left;
    font-size: 1.5rem;
  }
</style>
