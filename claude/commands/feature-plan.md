---
allowed-tools: FileEditor, Bash(find:*), Bash(grep:*), Bash(git:*)
description: Create detailed implementation plan for a specific feature
---

## Context

- Current codebase structure: !`find . -type f \( -name "*.py" -o -name "*.js" -o -name "*.ts" -o -name "*.go" -o -name "*.java" \) | grep -E "(src/|lib/|app/)" | head -15`
- Dependencies: !`find . -name "package.json" -o -name "requirements.txt" -o -name "go.mod" -o -name "Cargo.toml" | xargs cat 2>/dev/null | head -20`
- Test structure: !`find . -path "*/test*" -o -path "*/__tests__*" -o -name "*test*" | head -10`
- Recent feature changes: !`git log --oneline --grep="feat" -10`

## Your task

Create a detailed implementation plan for: $ARGUMENTS

Generate:

1. **Technical Breakdown**

   - File structure changes needed
   - New modules/components to create
   - Existing code that needs modification
   - Database schema changes (if applicable)

2. **Development Tasks**

   - Prioritized task list with time estimates
   - Dependencies between tasks
   - Suggested implementation order

3. **Testing Strategy**

   - Unit tests needed
   - Integration tests
   - E2E test scenarios

4. **Code Examples**

   - Key function signatures
   - API endpoints (if applicable)
   - Data models/interfaces

5. **Rollout Plan**
   - Feature flags approach
   - Gradual rollout strategy
   - Rollback procedures

Analyze the existing codebase patterns and follow established conventions.
