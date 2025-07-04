---
allowed-tools: Bash(git *), Bash(find:*), Bash(ls:*), Bash(cat:*), Bash(tail:*)
description: Systematically investigate bugs with contextual scope limiting
---

## Context

- Repository: !`basename $(git rev-parse --show-toplevel) 2>/dev/null || echo "Not a git repository"`
- Current directory: !`pwd`
- Active branch: !`git branch --show-current 2>/dev/null || echo "Unknown"`
- Recent commits: !`git log --oneline -5 2>/dev/null || echo "No git history"`
- Current changes: !`git status --porcelain 2>/dev/null || echo "No uncommitted changes"`
- Repository structure: !`find . -maxdepth 2 -name "package.json" -o -name "Cargo.toml" -o -name "go.mod" -o -name "requirements.txt" | head -10`

## Your Task

**Issue Description:** $ARGUMENTS

**Investigation Protocol:**

This is an **investigation and analysis phase only**. Do NOT write code fixes or suggest specific code changes yet.

Please follow this systematic approach:

1. **Scope Assessment**

   - Based on the issue description and repository structure above, identify the most likely affected areas
   - Recommend which directories/modules to focus investigation on first
   - Set boundaries to avoid unnecessary broad analysis

2. **Hypothesis Formation**

   - List 3-5 most probable root causes, ranked by likelihood
   - Explain your reasoning for each hypothesis
   - Consider recent commits as potential regression sources

3. **Investigation Roadmap**

   - Specify exact files that should be examined first
   - Recommend diagnostic commands to run
   - Suggest relevant log files or outputs to review
   - Propose step-by-step verification approach

4. **Information Gap Analysis**
   - What additional context would significantly help narrow this down?
   - What specific outputs, metrics, or tests should be gathered?
   - Are there external dependencies or services to check?

**Output Format:**

- **Scope:** [Areas to focus on]
- **Top Hypotheses:** [Ranked with reasoning]
- **Investigation Plan:** [Step-by-step approach]
- **Next Actions:** [Immediate steps to take]
- **Info Needed:** [Additional context that would help]
