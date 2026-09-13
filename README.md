# FitFlow Redesign

**IT3060 – Human Computer Interaction | Lab Exercise 05**
**BSc (Hons) in Information Technology – Year 3 | Semester 2, 2026**

---

## Project Overview

FitFlow is a mid-sized health-tech fitness tracking application. This repository contains the technology evaluation, architecture design, and documentation produced as part of IT3060 Lab Exercise 05. The objective is to select and justify an appropriate technology stack and high-level architecture for the redesigned FitFlow platform.

FitFlow must support:

- iOS, Android, and Web clients from a shared codebase
- Personalized AI-driven workout and nutrition recommendations
- Real-time social sharing and activity notifications
- Secure, scalable handling of sensitive health data
- Future extensibility and third-party integrations

---

## Selected Technology Stack

| Component      | Technology                 | Primary Reason                                       |
|----------------|----------------------------|------------------------------------------------------|
| Frontend       | Flutter                    | Single codebase for iOS, Android, and Web            |
| Backend        | Node.js + NestJS           | Modular, scalable REST + WebSocket API               |
| Database       | PostgreSQL                 | Relational structure for health and user data        |
| Authentication | Firebase Authentication    | Managed, scalable, social-login-ready auth           |
| Cache          | Redis                      | Fast temporary data access and rate limiting         |
| AI Service     | Python + FastAPI           | Rich AI/ML ecosystem for recommendations             |
| Real-time      | WebSockets / Socket.IO     | Live notifications and social activity updates       |
| API Style      | REST                       | Standard request/response between services           |

---

## Repository Structure

```
fitflow-redesign/
│
├── frontend/               # Flutter application (placeholder)
│   └── README.md
│
├── backend/                # Node.js + NestJS application (placeholder)
│   └── README.md
│
├── ai-service/             # Python + FastAPI AI microservice (placeholder)
│   └── README.md
│
├── docs/                   # All Lab Exercise 05 documentation
│   ├── activity-01-frontend-comparison.md
│   ├── activity-02-backend-database-auth.md
│   ├── activity-03-decision-matrix.md
│   ├── activity-04-architecture.md
│   ├── activity-05-github-repository.md
│   ├── ADR-001-technology-stack.md
│   └── architecture/
│       ├── fitflow-architecture.md
│       └── fitflow-architecture.mmd
│
├── README.md               # This file
└── .gitignore
```

---

## Activities

| Activity | Document | Description |
|----------|----------|-------------|
| Activity 1 | [Frontend Technology Comparison](docs/activity-01-frontend-comparison.md) | Evaluates Flutter, React Native, Kotlin Multiplatform, and Swift/SwiftUI |
| Activity 2 | [Backend, Database and Authentication](docs/activity-02-backend-database-auth.md) | Evaluates NestJS, FastAPI, Go; PostgreSQL, MongoDB, Firebase, DynamoDB; Firebase Auth, Cognito, Auth0, Supabase |
| Activity 3 | [Weighted Decision Matrix](docs/activity-03-decision-matrix.md) | Weighted scoring for each technology layer |
| Activity 4 | [High-Level Architecture & ADR](docs/activity-04-architecture.md) | System architecture, data flows, security, scalability |
| ADR-001   | [Architecture Decision Record](docs/ADR-001-technology-stack.md) | Formal ADR for the selected technology stack |
| Activity 5 | [GitHub Repository Setup](docs/activity-05-github-repository.md) | Repository structure, workflow, branch protection |

---

## Architecture Overview

```
                    ┌─────────────────────────┐
                    │     Flutter Frontend     │
                    │   iOS / Android / Web    │
                    └────────────┬────────────┘
                                 │ HTTPS / REST
                                 ▼
                    ┌─────────────────────────┐
                    │     NestJS Backend       │
                    │  Auth · API · Business   │
                    └──────┬──────────┬───────┘
                           │          │
              ┌────────────┘          └──────────────┐
              ▼                                       ▼
 ┌────────────────────┐                 ┌────────────────────┐
 │    PostgreSQL       │                 │      Redis          │
 │  Primary Database   │                 │  Cache / Sessions   │
 └────────────────────┘                 └────────────────────┘
                           │ API
                           ▼
                 ┌──────────────────────┐
                 │  Python + FastAPI    │
                 │   AI Microservice    │
                 └──────────────────────┘

 ┌──────────────────────┐    ┌──────────────────────┐
 │  Firebase Auth       │    │  WebSocket/Socket.IO  │
 │  Authentication      │    │  Real-time Events     │
 └──────────────────────┘    └──────────────────────┘
```

See [Architecture Documentation](docs/activity-04-architecture.md) and the [Mermaid diagram](docs/architecture/fitflow-architecture.mmd) for full details.

---

## Team

| Field          | Value                                                |
|----------------|------------------------------------------------------|
| Student Name   | AGDC Bandara                                         |
| Student ID     | IT23730892                                           |
| Group          | 4.2                                                  |
| Date Submitted | 2026/09/13                                           |
| GitHub Repo    | https://github.com/dewdunuchathura/FitflowRedesigned |

---

## References

- Flutter Documentation: https://flutter.dev/docs
- NestJS Documentation: https://docs.nestjs.com
- PostgreSQL Documentation: https://www.postgresql.org/docs
- Firebase Authentication: https://firebase.google.com/docs/auth
- Redis Documentation: https://redis.io/docs
- FastAPI Documentation: https://fastapi.tiangolo.com
- Socket.IO Documentation: https://socket.io/docs
