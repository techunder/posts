# AGENTS.md - Techunder Documentation Site

This is a Hugo-based documentation site using the hugo-book theme. Content is written in Chinese (Simplified) with Markdown and KaTeX math support.

## Project Overview

- **Framework**: Hugo (static site generator)
- **Theme**: hugo-book (git submodule)
- **Language**: Chinese (zh-CN)
- **Content**: Markdown files in `content/` directory
- **Math Rendering**: KaTeX

## Build Commands

### Local Development

```bash
# Install Hugo (requires extended version for SCSS support)
# macOS: brew install hugo
# Linux: snap install hugo
# Windows: choco install hugo-extended

# Start development server with live reload
hugo server

# Start server with verbose output
hugo server -v

# Build the static site (outputs to /public)
hugo

# Build with specific environment
hugo --environment production
```

### CI/CD

GitHub Actions workflows live in `themes/hugo-book/.github/` (submodule). On push to main, CI builds and deploys automatically.

## Content Structure

```
content/
├── docs/                    # Main documentation section
│   ├── _index.md           # Section index
│   └── transformer/        # Transformer article series
│       ├── _index.md       # Section index
│       └── 1-self-attention  # Individual article (no .md extension)
├── references/             # Reference materials
│   ├── _index.md
│   ├── deep-learning.md
│   ├── math-calculus.md
│   └── math-linalg.md
└── _index.md               # Home page
```

## Content Style Guidelines

### Frontmatter

Every content file must have frontmatter:

```yaml
---
title: "Article Title"
weight: 10
draft: true   # Set to false when publishing
---
```

For section indexes, add:

```yaml
bookCollapseSection: false
```

### Article Template Structure

Articles should include a copyright header and metadata block after frontmatter:

```html
<!-- Copyright © 2026 Techunder (Guanhua Liu) | All Rights Reserved | https://techunder.tech | Email: techunder@techunder.cn -->

<div class="page-title">Article Title</div>
<div class="page-info">
   <span class="original-tag">原创</span>
  发布时间：YYYY-MM-DD | 更新时间：YYYY-MM-DD
</div>
```

### Markdown Conventions

- Use ATX-style headers (`# H1`, `## H2`, etc.)
- Use `**bold**` for emphasis, `_italic_` is not commonly used
- Code blocks with language specifiers: ` ```python `, ` ```katex ` for math
- Use `-` for unordered lists
- Use `1.` for ordered lists (even if repeating "1.")

### KaTeX Math Conventions

Mathematical expressions use KaTeX blocks:

```katex
\text{Attention}(Q, K, V) = \text{softmax}\left(\frac{Q K^T}{\sqrt{d_k}}\right) V
```

- Inline math: ` ```katex ` on same line as expression
- Display math: multi-line KaTeX blocks
- Variables: use `\text{}` for multi-letter variable names
- Common notations:
  - Dimensions: `d_{model}`, `d_k`, `d_v`
  - Matrices: `\mathbf{W}`, `\mathbf{Q}`, `\mathbf{K}`, `\mathbf{V}`
  - Softmax: `\text{softmax}`
  - Attention: `\text{Attention}`

### File Naming

- Use descriptive Chinese names with hyphens as separators
- Article files: no `.md` extension in content tree
- Reference files: include `.md` extension
- Weights control ordering: lower weight = higher priority

## Hugo Configuration

Key settings in `hugo.toml`:

```toml
baseURL = 'https://techunder.tech/'
languageCode = 'zh-CN'
title = 'Techunder'
theme = 'hugo-book'

[params]
  BookSection = 'docs'
  BookToC = true
  BookLogo = 'images/logo.png'

[markup.tableOfContents]
  startLevel = 1
  endLevel = 2
  ordered = false

[markup.goldmark.renderer]
  unsafe = true  # Allows raw HTML in Markdown
```

## Git Workflow

1. Create or edit content files in `content/docs/` or `content/references/`
2. Set `draft: true` during work, `draft: false` when ready to publish
3. Preview locally with `hugo server`
4. Commit changes - CI will build and deploy on push to main

## Notes for AI Agents

- Theme is a git submodule at `themes/hugo-book`; CI workflows are there too
- Do NOT commit `/public/`, `/resources/`, or `hugo_stats.json`
- This is a static site - no testing framework, no JS/Node build steps
- Archetype template available at `archetypes/default.md`
