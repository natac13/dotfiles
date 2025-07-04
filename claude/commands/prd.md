---
allowed-tools: FileEditor, Bash(find:*), Bash(grep:*)
description: Generate a comprehensive Product Requirements Document
---

## Context

- Project structure: !`find . -type f -name "*.md" -o -name "package.json" -o -name "*.py" -o -name "*.js" -o -name "*.ts" | head -20`
- Existing documentation: !`find . -name "README*" -o -name "CHANGELOG*" -o -name "docs" -type d | head -10`
- Current git branch: !`git branch --show-current`
- Recent commits: !`git log --oneline -5`

## Your task

Create a comprehensive PRD for: $ARGUMENTS

The PRD should include:

1. **Executive Summary** - Brief overview and business justification
2. **Problem Statement** - What problem are we solving and for whom?
3. **Goals & Success Metrics** - Measurable objectives and KPIs
4. **User Stories & Use Cases** - Detailed scenarios and user flows
5. **Functional Requirements** - Core features and capabilities
6. **Technical Requirements** - Performance, security, and infrastructure needs
7. **Implementation Timeline** - Phases and milestones
8. **Risk Assessment** - Potential blockers and mitigation strategies
9. **Resource Requirements** - Team, tools, and budget needs

Consider the existing codebase context and ensure the PRD aligns with current architecture and constraints.

Save the PRD as `docs/prd-{feature-name}-{date}.md` with proper formatting and linking to related files.
