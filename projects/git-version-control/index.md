---
layout: page
title: Technical Foundations – Git & Research Computing
permalink: /projects/git-version-control/
---

# Technical Foundations Bootcamp (Weeks 1–4)
**RSH7033 — Applied Multivariate Statistics (DBA)**  
Trine University — TrineOnline / CGPS  

This four-week technical module prepares students to build, document, and deploy a fully reproducible multivariate research project using professional Git workflows.

Weeks 1–4 → Technical Preparation  
Weeks 5–8 → Final Git-Managed Research Project  

---

# WEEK 1 — Unix Environment & Git Foundations

Modern research workflows operate in Unix-like systems (Linux/macOS).

---

## Step 1: Access a Unix Terminal

macOS → Terminal  
Linux → Default shell  
Windows → Install one of:

WSL:  
https://learn.microsoft.com/en-us/windows/wsl/install  

Git Bash:  
https://git-scm.com/downloads  

Cygwin:  
https://www.cygwin.com/

---

## Step 2: Learn the Linux Command Line

Ubuntu tutorial:  
https://ubuntu.com/tutorials/command-line-for-beginners  

Linux reference:  
https://linuxcommand.org/lc3_learning_the_shell.php  

Master these commands:

- pwd  
- ls  
- cd  
- mkdir  
- rm  
- cp  
- mv  

---

## Step 3: Install Git & Setup GitHub

Install Git:  
https://git-scm.com/downloads  

Create GitHub account:  
https://github.com/

Configure Git:

    git config --global user.name "Your Name"
    git config --global user.email "your.email@trine.edu"

Setup SSH authentication:  
https://docs.github.com/en/authentication/connecting-to-github-with-ssh  

Generate SSH key:

    ssh-keygen -t ed25519 -C "your.email@trine.edu"

---

## Step 4: Git Practice

Official Git tutorial (first 10 sections):  
https://git-scm.com/docs/gittutorial  

Interactive branching practice:  
https://learngitbranching.js.org/

Complete:

- Introduction Sequence  
- Push & Pull — Git Remotes  

---

### WEEK 1 DELIVERABLE

- GitHub repository created  
- SSH configured  
- Minimum 10 commits  
- At least one branch created and merged  
- Professional README file  

---

# WEEK 2 — HTTP & HTML Foundations

Understanding web communication is essential for API and data extraction work.

---

## HTTP Basics

https://developer.mozilla.org/en-US/docs/Web/HTTP/Overview  
https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods  

Understand:

- Request vs Response  
- GET vs POST  
- Status codes  

---

## HTML Fundamentals

https://www.w3schools.com/html/html_intro.asp  
https://www.w3schools.com/html/html_elements.asp  
https://www.w3schools.com/html/html_attributes.asp  

Understand:

- Tags  
- Elements  
- Attributes  

---

### WEEK 2 DELIVERABLE

- Create `/web-foundations` folder  
- Markdown summary of HTTP basics  
- Annotated HTML example  
- Commit to GitHub  

---

# WEEK 3 — Regular Expressions

Regex is essential for structured text extraction.

---

RegexOne tutorial (first 8 lessons):  
https://regexone.com/

Practice here (Python flavor):  
https://regex101.com/

Python re documentation:  
https://docs.python.org/3/library/re.html  

---

### WEEK 3 DELIVERABLE

- At least 5 regex examples documented  
- Example input/output  
- Clear explanation of patterns  
- Committed to repository  

---

# WEEK 4 — Reproducible Research with Binder

Professional research must be executable by others.

---

Jupyter overview:  
https://jupyter.org/

Binder documentation:  
https://mybinder.readthedocs.io/en/latest/

---

## Milestone Project — Binder Deployment

You must:

1. Create a public GitHub repository  
2. Add a Jupyter notebook (.ipynb)  
3. Include datasets  
4. Create a requirements.txt file  
5. Add Binder badge to README  
6. Verify notebook runs successfully  

Example requirements.txt:

    pandas
    numpy
    matplotlib
    seaborn
    scikit-learn

Example Binder badge:

    [![Launch Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/yourusername/yourrepo/HEAD)

---

### WEEK 4 DELIVERABLE

- Public repository  
- Functional Binder link  
- Reproducible notebook  
- Clean documentation  
- Minimum 20 total commits  

---

# WEEKS 5–8 — Final Multivariate Research Project

Students apply all technical foundations to build a full research project using:

- Structured branching  
- Frequent commits  
- Version-controlled analysis  
- Documented data cleaning  
- Binder deployment  
- Final merged submission  

---

# PROFESSIONAL STANDARD BY WEEK 8

Minimum expectations:

- 30+ meaningful commits  
- Logical branch structure  
- Clear README documentation  
- Reproducible Binder environment  
- Organized folder structure  
- Professional commit messages  

Version control competency is part of the academic assessment in RSH7033.
