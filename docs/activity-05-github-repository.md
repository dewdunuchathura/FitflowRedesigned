# Activity 5 – GitHub Repository Setup and Documentation

**IT3060 – Human Computer Interaction | Lab Exercise 05**

---

## 1. Repository Information

| Field           | Value                                                          |
|-----------------|----------------------------------------------------------------|
| Repository Name | `FitflowRedesigned`                                            |
| GitHub URL      | https://github.com/dewdunuchathura/FitflowRedesigned           |
| Visibility      | Public                                                         |
| Primary Branch  | `main`                                                         |
| Git User        | dewdunuchathura                                                |

---

## 2. Repository Structure

The repository is organized to clearly separate application components from documentation, making the project easy to navigate for team members and reviewers.

```
fitflow-redesign/
│
├── frontend/                           # Flutter frontend application
│   └── README.md                       # Flutter setup and structure guide
│
├── backend/                            # Node.js + NestJS backend
│   └── README.md                       # NestJS setup and structure guide
│
├── ai-service/                         # Python + FastAPI AI microservice
│   └── README.md                       # FastAPI setup and structure guide
│
├── docs/                               # All Lab Exercise 05 documentation
│   ├── activity-01-frontend-comparison.md    # Activity 1 — Frontend comparison
│   ├── activity-02-backend-database-auth.md  # Activity 2 — Backend, DB, Auth
│   ├── activity-03-decision-matrix.md        # Activity 3 — Weighted matrix
│   ├── activity-04-architecture.md           # Activity 4 — Architecture + flows
│   ├── activity-05-github-repository.md      # Activity 5 — This document
│   ├── ADR-001-technology-stack.md           # Architecture Decision Record
│   └── architecture/
│       ├── fitflow-architecture.md           # Architecture narrative
│       └── fitflow-architecture.mmd          # Mermaid diagram source
│
├── README.md                           # Root project README
└── .gitignore                          # Files excluded from version control
```

---

## 3. README Documentation

The root `README.md` contains:

- Project overview and objectives
- Selected technology stack summary table
- Repository structure explanation
- Links to all five activity documents and the ADR
- ASCII architecture overview diagram
- Team member placeholder table
- References

Each sub-folder (`frontend/`, `backend/`, `ai-service/`) contains its own `README.md` explaining the technology selected, the planned folder structure, setup instructions, and its role in the overall architecture.

---

## 4. Git Workflow

### 4.1 Branch Strategy

The following branch strategy is recommended for the FitFlow project:

| Branch Pattern    | Purpose                                              |
|-------------------|------------------------------------------------------|
| `main`            | Production-ready code; protected branch              |
| `develop`         | Integration branch; feature branches merge here first|
| `feature/<name>`  | Individual feature development                       |
| `fix/<name>`      | Bug fixes                                            |
| `docs/<name>`     | Documentation updates                                |
| `release/<version>` | Release preparation branches                       |

### 4.2 Commit Message Convention

Commit messages follow the **Conventional Commits** format:

```
<type>(<scope>): <short description>

[optional body]

[optional footer]
```

**Types:**

| Type     | Use case                                      |
|----------|-----------------------------------------------|
| `feat`   | New feature                                   |
| `fix`    | Bug fix                                       |
| `docs`   | Documentation changes only                   |
| `refactor` | Code restructuring without feature change   |
| `test`   | Adding or updating tests                      |
| `chore`  | Build process, dependency, or config changes  |

**Examples:**

```bash
git commit -m "feat(workouts): add personalized workout recommendation endpoint"
git commit -m "fix(auth): handle expired Firebase JWT gracefully"
git commit -m "docs(activity-03): add weighted matrix for database comparison"
```

### 4.3 Pull Request Process

1. Create a feature branch from `develop`:
   ```bash
   git checkout -b feature/nutrition-logging
   ```

2. Make changes and commit using conventional commit messages.

3. Push the branch to GitHub:
   ```bash
   git push origin feature/nutrition-logging
   ```

4. Open a pull request against the `develop` branch on GitHub.

5. Request at least one reviewer. The PR description should include:
   - What was changed and why
   - How to test the change
   - Any relevant screenshots or logs

6. After review approval and passing CI checks, merge via **squash merge** to keep history clean.

7. Delete the feature branch after merging.

### 4.4 Initial Commit

The initial repository commit should include all project scaffold files and documentation:

```bash
git init
git add .
git commit -m "docs: initial FitFlow technology analysis and architecture"
git branch -M main
git remote add origin https://github.com/dewdunuchathura/FitflowRedesigned.git
git push -u origin main
```

---

## 5. Branch Protection Settings

The `main` branch should be protected with the following rules. These settings are configured in the GitHub repository under **Settings → Branches → Branch protection rules**.

| Rule                                    | Recommended Setting |
|-----------------------------------------|---------------------|
| Require pull request before merging     | Enabled             |
| Required number of approvals            | At least 1          |
| Dismiss stale reviews when new commits pushed | Enabled        |
| Require status checks to pass          | Enabled (when CI is configured) |
| Require branches to be up to date      | Enabled             |
| Restrict force pushes to main           | Enabled             |
| Restrict deletions of main              | Enabled             |

> Note: Branch protection rules must be configured manually in the GitHub repository settings. They cannot be automatically applied through the Git CLI.

---

## 6. .gitignore

The `.gitignore` file in the repository root excludes the following categories of files from version control:

| Category               | Examples                                            |
|------------------------|-----------------------------------------------------|
| Node.js dependencies   | `node_modules/`, `dist/`, `build/`                 |
| Environment secrets    | `.env`, `.env.*` (except `.env.example`)            |
| Python artifacts       | `__pycache__/`, `.venv/`, `*.pyc`                   |
| Flutter/Dart build     | `.dart_tool/`, `.flutter-plugins`, `build/`         |
| IDE configuration      | `.idea/`, `.vscode/`, `*.iml`                       |
| OS files               | `.DS_Store`, `Thumbs.db`                            |
| Logs and coverage      | `*.log`, `coverage/`, `.nyc_output/`                |

**Important:** Credentials, API keys, and database connection strings must never be committed to version control. Use `.env` files locally and a secrets management service in production.

---

## 7. Repository Labels

The following issue and PR labels are recommended for the FitFlow repository:

| Label            | Color    | Use case                           |
|------------------|----------|------------------------------------|
| `feature`        | #0075ca  | New feature development            |
| `bug`            | #d73a4a  | Something is not working           |
| `documentation`  | #0075ca  | Documentation improvements         |
| `enhancement`    | #a2eeef  | Improvement to existing feature    |
| `ai`             | #e4e669  | Related to AI/ML service           |
| `backend`        | #f9d0c4  | Related to NestJS backend          |
| `frontend`       | #d4edda  | Related to Flutter frontend        |
| `security`       | #b60205  | Security-related issue or fix      |
| `needs-review`   | #fbca04  | Awaiting peer review               |

---

## 8. Environment Configuration

Each application component requires environment variables for configuration. Templates (`.env.example`) should be committed; actual `.env` files must never be committed.

### Backend (.env.example)

```env
# Server
PORT=3000
NODE_ENV=development

# Database
DATABASE_URL=postgresql://user:password@localhost:5432/fitflow

# Redis
REDIS_URL=redis://localhost:6379

# Firebase
FIREBASE_PROJECT_ID=your-firebase-project-id
FIREBASE_PRIVATE_KEY=your-firebase-private-key
FIREBASE_CLIENT_EMAIL=your-firebase-client-email

# AI Service
AI_SERVICE_URL=http://localhost:8000
AI_SERVICE_API_KEY=your-internal-api-key
```

### AI Service (.env.example)

```env
# Server
PORT=8000
ENVIRONMENT=development

# Internal auth
INTERNAL_API_KEY=your-internal-api-key
```

---

## 9. Collaboration Guidelines

### Code Review Expectations

- All pull requests require at least one review before merging
- Reviewers should check for: correctness, security issues, test coverage, and documentation
- Authors should respond to review comments within one working day
- Do not merge your own PRs without approval

### Documentation Updates

- Documentation changes should be submitted as separate PRs or included with the related feature PR
- All new API endpoints should be documented in the relevant module README
- Significant architectural changes should be documented in a new ADR

---

## 10. Team

| Name           | Student ID   | GitHub Username    |
|----------------|--------------|--------------------|
| AGDC Bandara   | IT23730892   | dewdunuchathura    |

---

*Document: Activity 5 – GitHub Repository Setup and Documentation*
*Course: IT3060 Human Computer Interaction | Lab Exercise 05*
