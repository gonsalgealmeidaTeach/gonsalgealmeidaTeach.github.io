---
layout: page
title: Technical Foundations – Git & Research Computing
permalink: /projects/git-version-control/
---

<h1>Technical Foundations Bootcamp (Weeks 1–4)</h1>

<p><strong>RSH7033 — Applied Multivariate Statistics (DBA)</strong><br>
Trine University — TrineOnline / CGPS</p>

<p>
This four-week technical module prepares students to build, document, and deploy
a fully reproducible multivariate research project using professional Git workflows.
</p>

<p>
Weeks 1–4 → Technical Preparation<br>
Weeks 5–8 → Final Git-Managed Research Project
</p>

<hr>

<h1>WEEK 1 — Unix Environment & Git Foundations</h1>

<p>Modern research workflows operate in Unix-like systems (Linux/macOS).</p>

<hr>

<h2>Step 1: Access a Unix Terminal</h2>

<ul>
<li>macOS → Terminal</li>
<li>Linux → Default shell</li>
<li>Windows → Install one of:
  <ul>
    <li><a href="https://learn.microsoft.com/en-us/windows/wsl/install" target="_blank">WSL</a></li>
    <li><a href="https://git-scm.com/downloads" target="_blank">Git Bash</a></li>
    <li><a href="https://www.cygwin.com/" target="_blank">Cygwin</a></li>
  </ul>
</li>
</ul>

<hr>

<h2>Step 2: Learn the Linux Command Line</h2>

<ul>
<li><a href="https://ubuntu.com/tutorials/command-line-for-beginners" target="_blank">Ubuntu Tutorial</a></li>
<li><a href="https://linuxcommand.org/lc3_learning_the_shell.php" target="_blank">Linux Command Reference</a></li>
</ul>

<p>Master these commands:</p>

<ul>
<li>pwd</li>
<li>ls</li>
<li>cd</li>
<li>mkdir</li>
<li>rm</li>
<li>cp</li>
<li>mv</li>
</ul>

<hr>

<h2>Step 3: Install Git & Setup GitHub</h2>

<ul>
<li><a href="https://git-scm.com/downloads" target="_blank">Install Git</a></li>
<li><a href="https://github.com/" target="_blank">Create GitHub Account</a></li>
<li><a href="https://docs.github.com/en/authentication/connecting-to-github-with-ssh" target="_blank">Setup SSH Authentication</a></li>
</ul>

<pre><code>git config --global user.name "Your Name"
git config --global user.email "your.email@trine.edu"
ssh-keygen -t ed25519 -C "your.email@trine.edu"</code></pre>

<hr>

<h2>Step 4: Git Practice</h2>

<ul>
<li><a href="https://git-scm.com/docs/gittutorial" target="_blank">Official Git Tutorial</a></li>
<li><a href="https://learngitbranching.js.org/" target="_blank">Interactive Branching Practice</a></li>
</ul>

<p>Complete:</p>

<ul>
<li>Introduction Sequence</li>
<li>Push &amp; Pull — Git Remotes</li>
</ul>

<hr>

<h3>WEEK 1 DELIVERABLE</h3>

<ul>
<li>GitHub repository created</li>
<li>SSH configured</li>
<li>Minimum 10 commits</li>
<li>At least one branch created and merged</li>
<li>Professional README file</li>
</ul>

<hr>

<h1>WEEK 2 — HTTP &amp; HTML Foundations</h1>

<p>Understanding web communication is essential for API and data extraction work.</p>

<h2>HTTP Basics</h2>

<ul>
<li><a href="https://developer.mozilla.org/en-US/docs/Web/HTTP/Overview" target="_blank">HTTP Overview</a></li>
<li><a href="https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods" target="_blank">HTTP Methods</a></li>
</ul>

<p>Understand:</p>

<ul>
<li>Request vs Response</li>
<li>GET vs POST</li>
<li>Status codes</li>
</ul>

<h2>HTML Fundamentals</h2>

<ul>
<li><a href="https://www.w3schools.com/html/html_intro.asp" target="_blank">HTML Introduction</a></li>
<li><a href="https://www.w3schools.com/html/html_elements.asp" target="_blank">HTML Elements</a></li>
<li><a href="https://www.w3schools.com/html/html_attributes.asp" target="_blank">HTML Attributes</a></li>
</ul>

<hr>

<h3>WEEK 2 DELIVERABLE</h3>

<ul>
<li>Create <code>/web-foundations</code> folder</li>
<li>Markdown summary of HTTP basics</li>
<li>Annotated HTML example</li>
<li>Commit to GitHub</li>
</ul>

<hr>

<h1>WEEK 3 — Regular Expressions</h1>

<p>Regex is essential for structured text extraction.</p>

<ul>
<li><a href="https://regexone.com/" target="_blank">RegexOne Tutorial</a></li>
<li><a href="https://regex101.com/" target="_blank">Regex Practice (Python Flavor)</a></li>
<li><a href="https://docs.python.org/3/library/re.html" target="_blank">Python re Documentation</a></li>
</ul>

<hr>

<h3>WEEK 3 DELIVERABLE</h3>

<ul>
<li>At least 5 regex examples documented</li>
<li>Example input/output</li>
<li>Clear explanation of patterns</li>
<li>Committed to repository</li>
</ul>

<hr>

<h1>WEEK 4 — Reproducible Research with Binder</h1>

<p>Professional research must be executable by others.</p>

<ul>
<li><a href="https://jupyter.org/" target="_blank">Jupyter Overview</a></li>
<li><a href="https://mybinder.readthedocs.io/en/latest/" target="_blank">Binder Documentation</a></li>
</ul>

<h2>Milestone Project — Binder Deployment</h2>

<ol>
<li>Create a public GitHub repository</li>
<li>Add a Jupyter notebook (.ipynb)</li>
<li>Include datasets</li>
<li>Create a requirements.txt file</li>
<li>Add Binder badge to README</li>
<li>Verify notebook runs successfully</li>
</ol>

<p>Example requirements.txt:</p>

<pre><code>pandas
numpy
matplotlib
seaborn
scikit-learn</code></pre>

<p>Example Binder badge:</p>

<pre><code>[![Launch Binder](https://mybinder.org/badge_logo.svg)]
(https://mybinder.org/v2/gh/yourusername/yourrepo/HEAD)</code></pre>

<hr>

<h3>WEEK 4 DELIVERABLE</h3>

<ul>
<li>Public repository</li>
<li>Functional Binder link</li>
<li>Reproducible notebook</li>
<li>Clean documentation</li>
<li>Minimum 20 total commits</li>
</ul>

<hr>

<h1>WEEKS 5–8 — Final Multivariate Research Project</h1>

<p>Students apply all technical foundations to build a full research project using:</p>

<ul>
<li>Structured branching</li>
<li>Frequent commits</li>
<li>Version-controlled analysis</li>
<li>Documented data cleaning</li>
<li>Binder deployment</li>
<li>Final merged submission</li>
</ul>

<hr>

<h1>PROFESSIONAL STANDARD BY WEEK 8</h1>

<ul>
<li>30+ meaningful commits</li>
<li>Logical branch structure</li>
<li>Clear README documentation</li>
<li>Reproducible Binder environment</li>
<li>Organized folder structure</li>
<li>Professional commit messages</li>
</ul>

<p><strong>Version control competency is part of the academic assessment in RSH7033.</strong></p>

<hr>

<p>
<a href="/projects/RSH7033/">← Back to RSH7033 Course Hub</a>
</p>
