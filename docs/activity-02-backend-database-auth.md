# Activity 2 – Backend, Database and Authentication Comparison

**IT3060 – Human Computer Interaction | Lab Exercise 05**

---

## 1. Introduction

FitFlow requires a robust server-side architecture capable of:

- Serving REST API requests from the Flutter frontend
- Real-time event delivery via WebSockets
- Structured storage of health data (users, workouts, nutrition, social activity)
- Secure, scalable user authentication with social login support
- Integration with a dedicated AI microservice
- Secure handling of sensitive health data in compliance with applicable data protection regulations

This activity compares backend frameworks, database options, and authentication solutions to identify the most appropriate choices for FitFlow.

---

## 2. Backend Framework Comparison

### 2.1 Candidates

1. **Node.js + NestJS** – TypeScript backend framework with modular architecture
2. **Python + FastAPI** – Async Python framework popular in AI/ML environments
3. **Go** – Compiled, statically typed language known for high concurrency

### 2.2 Comparison Table

| Criterion           | Node.js + NestJS                        | Python + FastAPI                        | Go                                      |
|---------------------|-----------------------------------------|-----------------------------------------|-----------------------------------------|
| **Performance**     | High — non-blocking event loop; handles concurrent I/O efficiently | High — async I/O via `asyncio`; excellent for API workloads | Very high — compiled binary; excellent throughput and low memory usage |
| **Development speed** | High — TypeScript ecosystem; NestJS conventions reduce boilerplate | High — minimal setup; automatic documentation; rapid prototyping | Moderate — explicit error handling and verbose code patterns slow initial development |
| **Scalability**     | Good — stateless REST design; horizontal scaling supported; cluster mode available | Good — stateless REST design; ASGI servers scale well | Excellent — goroutines handle very high concurrency natively |
| **Ecosystem**       | Very large — npm; first-class TypeScript; extensive NestJS modules | Large — PyPI; outstanding AI/ML libraries (TensorFlow, PyTorch, scikit-learn) | Growing — standard library is strong; third-party ecosystem is smaller |
| **Learning curve**  | Moderate — NestJS has a structured, Angular-like style; TypeScript knowledge required | Low to moderate — Python is widely known; FastAPI is intuitive | High — Go's concurrency model, error handling patterns, and strict typing require adjustment |
| **Real-time support** | Excellent — NestJS has built-in WebSocket gateway using Socket.IO; first-class integration | Good — WebSocket support via `websockets` or `starlette`; less opinionated than NestJS | Good — WebSocket support available via third-party libraries |
| **AI/ML integration** | Good — can call AI services via HTTP; not suitable for direct ML model execution | Excellent — native support for TensorFlow, PyTorch, Hugging Face, and scikit-learn | Moderate — can call AI APIs; limited native ML library support |
| **Maintainability** | High — strongly typed; modular architecture enforced by NestJS; clear code structure | Moderate — dynamic typing in Python can reduce long-term maintainability at scale | Moderate — simple and readable but verbose; module organization requires discipline |
| **Cost**            | Low — open source; efficient resource usage; moderate infrastructure requirements | Low — open source; may require more powerful compute for ML workloads | Low — open source; very efficient resource usage; lower infrastructure cost at scale |
| **Security**        | Good — NestJS guards, pipes, and interceptors; TypeScript reduces type-related vulnerabilities | Good — FastAPI input validation via Pydantic; Python's typing helps but is less strict | Very good — compiled and statically typed; fewer classes of runtime errors |

### 2.3 Backend Analysis

**Node.js + NestJS** provides the best overall balance for FitFlow's main backend requirements. Its TypeScript ecosystem, modular architecture, and built-in WebSocket support make it the strongest fit. The NestJS module system (modules, controllers, services, guards, interceptors) maps naturally to FitFlow's domains: authentication, users, workouts, nutrition, and social features.

**Python + FastAPI** has an outstanding advantage for AI/ML work. However, as the primary application backend, it lacks the opinionated modular structure of NestJS, and long-term maintainability at scale with a mid-sized team can be more challenging in dynamically typed Python. FastAPI is selected as the **AI microservice** framework (see Section 7), where its AI/ML ecosystem advantage is directly relevant.

**Go** is technically excellent for high-concurrency workloads but imposes a higher development overhead and a steeper learning curve. Its real-time and AI/ML integration story is less complete than the alternatives. Go would be considered if FitFlow scaled to a point where the NestJS backend became a bottleneck.

### 2.4 Backend Recommendation

**Node.js + NestJS is recommended as the main application backend for FitFlow.**

---

## 3. Database Comparison

### 3.1 FitFlow Data Model

FitFlow manages structured, relational data including:

| Entity             | Related To                              |
|--------------------|-----------------------------------------|
| Users              | Workouts, nutrition records, social posts, preferences |
| Workout Plans      | Users, exercises, schedules             |
| Exercises          | Workout plans, muscles, equipment       |
| Nutrition Records  | Users, food items, daily logs           |
| Social Posts       | Users, likes, comments                  |
| Progress Records   | Users, workouts, measurements           |
| Follows            | Users (self-referential)                |

This data model contains many-to-many and one-to-many relationships that benefit from a relational database with JOIN support, ACID transactions, and foreign key constraints.

### 3.2 Candidates

1. **PostgreSQL** – Open-source relational database
2. **MongoDB** – Document-oriented NoSQL database
3. **Firebase Firestore** – Google-managed NoSQL document database
4. **Amazon DynamoDB** – AWS-managed NoSQL key-value and document store

### 3.3 Comparison Table

| Criterion                  | PostgreSQL              | MongoDB                  | Firebase Firestore        | Amazon DynamoDB           |
|----------------------------|-------------------------|--------------------------|---------------------------|---------------------------|
| **Scalability**            | Vertical + horizontal (read replicas, Citus for sharding) | Horizontal sharding built-in | Managed auto-scaling | Serverless auto-scaling; excellent at massive scale |
| **Query performance**      | Excellent — rich SQL; indexes; query planner | Good — document queries; aggregation pipeline; less flexible for complex joins | Moderate — limited query capabilities; composite indexes required | Good for key-value access; poor for complex queries |
| **Structured health data** | Excellent — strict schema enforces data integrity | Moderate — flexible schema can lead to inconsistency | Moderate — schema-less; application must enforce structure | Moderate — flexible but requires careful key design |
| **Relationships**          | Excellent — foreign keys, JOIN operations, referential integrity | Poor — no native JOIN; denormalization required | Poor — references supported but JOINs are not | Poor — no native JOIN support |
| **Transactions**           | Excellent — full ACID compliance across multiple tables | Good — multi-document transactions added in v4.0 | Limited — transactions supported but with restrictions | Limited — transactions supported within partitions |
| **Maintenance**            | Moderate — requires DBA knowledge; schema migrations managed with tools | Moderate — schema-less reduces migration complexity but adds application-level burden | Low — fully managed by Google | Low — fully managed by AWS |
| **Cost**                   | Low — open source; self-hosted or managed (RDS, Supabase, Neon) | Open source; Atlas managed service adds cost | Pay-per-operation; can become expensive at scale | Pay-per-operation; expensive at high read/write volumes |
| **Security**               | Excellent — row-level security, role-based access, encryption at rest and in transit, extensive audit options | Good — authentication, TLS, field-level encryption (Atlas) | Good — Firebase security rules; Google-managed infrastructure | Excellent — IAM-based access, encryption at rest and in transit |

### 3.4 Database Analysis

FitFlow's data model has clear relational characteristics — users have workout plans, workout plans contain exercises, exercises have attributes, users follow other users, and social posts belong to users. These relationships are best served by a relational database that supports JOIN operations, referential integrity, and ACID transactions.

**PostgreSQL** is the mature, open-source relational database that handles these requirements exceptionally well. It supports complex queries, has an excellent query planner, and offers rich features such as JSON columns (for semi-structured data where flexibility is needed), full-text search, and row-level security.

**MongoDB** is well-suited for document-centric data without complex relationships. FitFlow's data model does not fit this well — enforcing data consistency and navigating relationships in a document store would add significant application-level complexity.

**Firebase Firestore** is convenient for rapid development but lacks the query flexibility that FitFlow's reporting and data access patterns require. It is not the best fit for complex relational health data.

**DynamoDB** is excellent for massive-scale key-value access patterns but requires very careful data modeling and does not handle FitFlow's relational query patterns without significant denormalization.

### 3.5 Database Recommendation

**PostgreSQL is recommended as the primary database for FitFlow.**

**Redis** is recommended as a supplementary caching layer for frequently accessed data such as workout plans, session-related data, and AI recommendation results. Redis is not a replacement for the primary database.

---

## 4. Authentication Comparison

### 4.1 Authentication vs. Authorization

It is important to distinguish between two related but distinct concepts:

- **Authentication** — Verifying *who* the user is. This involves confirming the identity of a user through credentials (email/password, social login, biometrics).
- **Authorization** — Determining *what* an authenticated user is allowed to do. This involves enforcing access rules based on roles or permissions (e.g., a regular user cannot access admin endpoints).

In FitFlow, Firebase Authentication handles the authentication layer, while NestJS implements authorization through guards and role-based access control.

### 4.2 Candidates

1. **Firebase Authentication** – Google-managed authentication service
2. **AWS Cognito** – Amazon-managed authentication and user directory
3. **Auth0** – Third-party identity-as-a-service provider
4. **Supabase Auth** – Open-source Firebase alternative with built-in auth

### 4.3 Comparison Table

| Criterion                    | Firebase Authentication    | AWS Cognito                 | Auth0                        | Supabase Auth                |
|------------------------------|----------------------------|-----------------------------|------------------------------|------------------------------|
| **Security**                 | Excellent — Google-managed; token-based (JWT); OAuth2; MFA support | Excellent — enterprise-grade; JWT/SAML; MFA; advanced compliance features | Excellent — industry-leading security; anomaly detection; attack protection | Good — built on GoTrue; JWT-based; MFA available |
| **Ease of implementation**   | Very easy — well-documented SDKs for Flutter, Web, and Node.js; minimal setup | Moderate — more configuration required; complex user pool setup | Easy to moderate — good documentation; flexible but more configuration options | Easy — integrated with Supabase platform; straightforward setup |
| **Scalability**              | Excellent — Google infrastructure; designed for massive scale | Excellent — AWS infrastructure; scales to millions of users | Excellent — managed SaaS; auto-scaling | Good — scales well; limited by Supabase infrastructure |
| **Social login**             | Excellent — Google, Apple, Facebook, Twitter, GitHub, Microsoft, and custom OIDC | Good — social providers supported but require more configuration | Excellent — 40+ social connections out of the box | Good — Google, GitHub, and other providers supported |
| **Authorization integration** | Good — custom claims in JWT; role-based via Firebase Admin SDK | Excellent — fine-grained IAM integration; user groups; resource server | Excellent — RBAC built in; permissions and roles managed in Auth0 dashboard | Good — Row Level Security in Supabase; role-based via metadata |
| **Developer experience**     | Excellent — first-class Flutter/Dart SDK; comprehensive documentation; Google-backed | Moderate — AWS-centric; less developer-friendly than competitors | Excellent — polished dashboard; Auth0 docs are industry-leading | Good — developer-friendly; Supabase ecosystem is cohesive |
| **Cost**                     | Free up to 50,000 MAU (Spark plan); competitive pricing above that | Pay-per-MAU; can become expensive; complex pricing model | Free up to 7,500 MAU; pricing can be high at scale | Free tier available; reasonably priced; open-source self-hosting possible |
| **Maintenance**              | Low — fully managed; SDK updates are straightforward | Moderate — AWS ecosystem dependency; migration away from Cognito is difficult | Low — fully managed; vendor lock-in is a consideration | Low — managed version; or self-hosted for more control |

### 4.4 Authentication Analysis

**Firebase Authentication** is the most appropriate choice for FitFlow given the following:

- The Flutter frontend already integrates with the Firebase ecosystem (Firebase SDKs for Flutter are first-class and officially maintained).
- Firebase Authentication is extremely straightforward to implement across Flutter (iOS, Android, Web) with the `firebase_auth` package.
- Social login support (Google, Apple, Facebook) is built-in and well-tested.
- The Google-managed infrastructure is reliable and scales automatically.
- The free tier (50,000 MAU) is generous for a mid-sized application at launch.
- Integration with the NestJS backend is well-documented — Firebase Admin SDK verifies JWT tokens on the server.

**AWS Cognito** is a strong enterprise option but introduces AWS infrastructure dependency and is more complex to configure. It is better suited for organizations already heavily invested in the AWS ecosystem.

**Auth0** is an excellent choice with polished developer experience and advanced RBAC features. However, it introduces an additional paid dependency and its pricing can escalate at scale. It is a viable alternative if fine-grained authorization management in the dashboard is a priority.

**Supabase Auth** is compelling if the team were also using Supabase as the database. Since FitFlow selects PostgreSQL independently and NestJS as the backend, Supabase Auth would add unnecessary platform coupling.

### 4.5 Authentication Recommendation

**Firebase Authentication is recommended for FitFlow.**

---

## 5. Security Considerations

### 5.1 GDPR and HIPAA Considerations

FitFlow handles sensitive personal health data. Two major regulatory frameworks are relevant:

- **GDPR (General Data Protection Regulation)** — Applies to users in the European Economic Area. Requires lawful basis for data collection, right to erasure, data minimization, transparent data usage, and appropriate technical safeguards.
- **HIPAA (Health Insurance Portability and Accountability Act)** — Applies to US healthcare providers and their business associates handling Protected Health Information (PHI). Requires administrative, physical, and technical safeguards, audit controls, and Business Associate Agreements with service providers.

**Important:** Selecting specific technologies does not automatically make FitFlow GDPR or HIPAA compliant. Compliance depends on:

- Proper system design implementing data minimization and purpose limitation
- Encryption of data at rest and in transit
- Fine-grained access control ensuring only authorized parties access health data
- Comprehensive audit logging of access to sensitive records
- Consent management and user data export/deletion capabilities
- Documented data retention and deletion policies
- Appropriate Data Processing Agreements with service providers (Google/Firebase, hosting providers)
- Organizational procedures, policies, and training

The technology stack selected for FitFlow provides the technical capabilities to implement these measures. Compliance remains an organizational and engineering responsibility.

### 5.2 Security Mechanisms

The FitFlow architecture implements the following security mechanisms:

| Mechanism                 | Implementation                                                            |
|---------------------------|---------------------------------------------------------------------------|
| Transport security        | HTTPS/TLS enforced for all client-server communication                    |
| Authentication            | Firebase Authentication — JWT-based token verification                    |
| Token validation          | NestJS guards validate Firebase JWT on every protected request            |
| Authorization             | Role-based access control (RBAC) implemented in NestJS guards             |
| Input validation          | NestJS class-validator pipes; Pydantic schemas in FastAPI                 |
| Rate limiting             | `@nestjs/throttler` applied to public and authenticated endpoints         |
| Encryption at rest        | Enabled at database and storage layer                                     |
| Secrets management        | All credentials stored in environment variables; no hard-coded secrets    |
| Audit logging             | Security-sensitive actions (login, data access, admin operations) logged  |
| Least privilege           | Database users and service accounts granted minimum necessary permissions |

### 5.3 Example Role Hierarchy

```
Administrator
   └── Can manage all users, content, and system configuration

Trainer
   └── Can create and assign workout plans to assigned users
   └── Can view assigned users' progress records

User
   └── Can manage their own profile, workouts, and nutrition data
   └── Can interact with social features
   └── Cannot access other users' private health data
```

---

## 6. Real-Time Requirements

FitFlow requires real-time communication for:

- Social activity updates (likes, comments, follows)
- Live workout progress sharing with friends or trainers
- Push notifications for goals, reminders, and social events
- Real-time updates to shared workout sessions

**WebSockets via Socket.IO** is recommended for real-time communication. NestJS has a built-in WebSocket gateway module (`@nestjs/websockets`) with first-class Socket.IO support. REST APIs continue to handle standard request/response operations (fetching data, submitting forms), while WebSockets handle event-driven real-time updates.

This hybrid approach is appropriate: REST for reliability and cacheability of standard operations, WebSockets for low-latency event streaming.

---

## 7. AI/ML Integration

FitFlow's personalized recommendation features require AI/ML capabilities. The recommended approach is a **separate AI microservice** built with **Python + FastAPI**.

**Architecture:**

```
Flutter Frontend
      │
      ▼
NestJS Backend (main API)
      │
      ▼
Python + FastAPI AI Service (internal API)
      │
      ▼
AI/ML Models (scikit-learn, TensorFlow, PyTorch, etc.)
```

**Responsibilities of the AI service:**

- Personalized workout plan generation based on user goals, fitness level, and history
- Exercise recommendations based on available equipment and muscle targeting
- Nutrition recommendations based on tracked intake vs. targets
- Progress insight generation and trend analysis
- Model inference for any ML-powered features

**Why a separate service:**

- Python has the strongest AI/ML ecosystem; separating it avoids introducing Python dependency management into the Node.js backend
- The AI service can be scaled independently from the main API
- Computational workloads (model inference) are isolated and do not affect main API responsiveness
- The AI team can work independently from the backend team
- FastAPI is chosen because it is async, performant, and generates automatic API documentation that makes integration straightforward

---

## 8. Cost and Maintainability

### 8.1 Cost Summary

| Component               | Cost Model                                     |
|-------------------------|------------------------------------------------|
| NestJS backend          | Open source; infrastructure (VPS or cloud) cost |
| PostgreSQL              | Open source; managed hosting optional (Supabase, RDS, Neon) |
| Redis                   | Open source; managed hosting available (Redis Cloud, Upstash) |
| Firebase Authentication | Free up to 50,000 MAU                          |
| Python/FastAPI AI       | Open source; GPU compute if using DL models    |
| Flutter frontend        | Open source; no additional licensing           |

Total third-party licensing cost at launch is minimal. The primary costs are infrastructure (compute, storage, bandwidth) and developer time.

### 8.2 Maintainability

- **NestJS** enforces a modular structure that is easy for new team members to navigate. Each feature domain (workouts, nutrition, social) is encapsulated in its own module.
- **PostgreSQL** with schema migration tools (Prisma Migrate or TypeORM migrations) keeps the database schema versioned and auditable.
- **Firebase Authentication** is a managed service that handles security updates, SDK compatibility, and infrastructure — reducing operational burden.
- **Python/FastAPI AI service** is isolated, meaning ML model updates and AI feature changes do not require changes to the main backend.
- **Flutter** keeps all client-side code in one place, reducing the risk of drift between platform implementations.

---

## 9. Summary of Recommendations

| Component       | Recommendation            | Key Reason                                                       |
|-----------------|---------------------------|------------------------------------------------------------------|
| Backend         | Node.js + NestJS          | Modular TypeScript API; built-in WebSocket; strong maintainability |
| Primary Database | PostgreSQL               | Relational structure; ACID compliance; rich query support        |
| Cache           | Redis                     | Fast temporary data; session caching; rate limiting              |
| Authentication  | Firebase Authentication   | Easy integration with Flutter; scalable; social login            |
| AI Service      | Python + FastAPI          | Best AI/ML ecosystem; isolated, independently scalable           |
| Real-time       | WebSockets / Socket.IO    | Low-latency event streaming; NestJS native support               |

---

*Document: Activity 2 – Backend, Database and Authentication Comparison*
*Course: IT3060 Human Computer Interaction | Lab Exercise 05*
