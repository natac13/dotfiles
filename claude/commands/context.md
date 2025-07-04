---
allowed-tools: FileEditor, Bash(find:*), Bash(grep:*), Bash(wc:*)
description: Build comprehensive project context for planning
---

## Context Analysis

- **Project Overview**: !`cat README.md 2>/dev/null || echo "No README found"`
- **Architecture**: !`find . -name "architecture*" -o -name "ARCHITECTURE*" | xargs cat 2>/dev/null`
- **Tech Stack**: !`find . -name "package.json" -o -name "requirements.txt" -o -name "Cargo.toml" -o -name "go.mod" | head -5`
- **Directory Structure**: !`tree -L 3 -I 'node_modules|__pycache__|.git|dist|build' . 2>/dev/null || find . -type d -not -path '*/.*' | head -20`
- **Recent Activity**: !`git log --oneline -10`
- **Open Issues/TODOs**: !`grep -r "TODO\|FIXME\|XXX" . --include="*.py" --include="*.js" --include="*.ts" --include="*.go" | head -10`
- **Code Stats**: !`find . -name "*.py" -o -name "*.js" -o -name "*.ts" | xargs wc -l | tail -1`

## Your task

Based on the project context above, provide insights for: $ARGUMENTS

Include:

- Project maturity assessment
- Technical debt areas
- Architecture strengths/weaknesses
- Recommended next steps
- Potential challenges for new features
