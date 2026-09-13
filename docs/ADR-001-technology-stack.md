# ADR-001: FitFlow Technology Stack Selection

**IT3060 – Human Computer Interaction | Lab Exercise 05**

---

## Title

FitFlow Technology Stack Selection

## Status

**Accepted**

## Date

2026/09/13

## Author

AGDC Bandara — GitHub: [dewdunuchathura](https://github.com/dewdunuchathura)

---

## Context

FitFlow is a mid-sized health-tech fitness tracking application that requires:

- **Cross-platform support:** iOS, Android, and Web clients, ideally from a shared codebase to reduce development and maintenance cost
- **High performance:** Smooth UI for workout tracking, real-time interactions, and data-intensive features
- **Personalized AI-driven features:** Workout plan generation, exercise recommendations, and nutrition insights powered by machine learning
- **Real-time communication:** Social activity updates, live workout sharing, and notifications
- **Secure health-data handling:** Sensitive personal health data must be stored and transmitted securely; applicable regulations (GDPR, HIPAA) impose data protection requirements
- **Scalability:** The system must accommodate user growth without architectural rework
- **Maintainability:** A mid-sized development team must sustain and extend the system over multiple development cycles
- **Reasonable development cost:** Open-source tooling and managed services should minimize licensing costs

The team evaluated four frontend frameworks, three backend frameworks, four databases, and four authentication solutions to identify the most appropriate stack.

---

## Decision

The following technology stack is adopted for FitFlow:

| Layer              | Technology                    |
|--------------------|-------------------------------|
| Frontend           | **Flutter** (Dart)            |
| Main Backend       | **Node.js + NestJS** (TypeScript) |
| Primary Database   | **PostgreSQL**                |
| Authentication     | **Firebase Authentication**   |
| Cache              | **Redis**                     |
| AI Microservice    | **Python + FastAPI**          |
| Real-time          | **WebSockets / Socket.IO**    |
| API Style          | **REST**                      |

---

## Rationale

### Flutter (Frontend)

Flutter is the only evaluated frontend framework that provides first-class, official support for iOS, Android, and Web from a single Dart codebase. Its AOT compilation to native ARM code delivers high performance without a JavaScript bridge. The `firebase_flutter` plugin ecosystem provides seamless Firebase Authentication integration. Flutter's weighted decision matrix score of **4.50/5.00** placed it clearly above React Native (3.75), Kotlin Multiplatform (3.05), and Swift/SwiftUI (2.35).

### Node.js + NestJS (Main Backend)

NestJS provides a structured, modular TypeScript framework that maps directly to FitFlow's feature domains (authentication, users, workouts, nutrition, social). Its built-in WebSocket gateway (via Socket.IO) satisfies the real-time requirement without additional infrastructure. TypeScript's static typing supports long-term maintainability. NestJS scored **4.15/5.00** in the backend matrix, above FastAPI (4.00) and Go (3.85). NestJS's superior maintainability and real-time support ratings drove the selection.

### PostgreSQL (Primary Database)

FitFlow's data model contains clearly relational entities — users, workout plans, exercises, nutrition records, and social relationships — with many-to-many and one-to-many associations. PostgreSQL's full ACID compliance, rich JOIN support, and row-level security make it the most appropriate choice. PostgreSQL scored **4.85/5.00**, substantially above MongoDB (3.60), DynamoDB (3.30), and Firebase Firestore (3.20).

### Firebase Authentication

Firebase Authentication was selected for its ease of integration with the Flutter frontend (officially maintained `firebase_auth` package), its support for social login providers (Google, Apple, Facebook), and its free tier (50,000 MAU). Every API request from Flutter carries a Firebase JWT, which NestJS verifies using the Firebase Admin SDK. Firebase Auth scored **4.90/5.00** in the authentication matrix, above Auth0 (4.60), AWS Cognito (4.05), and Supabase Auth (4.00).

### Redis (Cache)

Redis is included as a supplementary caching layer to reduce database load and latency for frequently accessed data (workout plans, nutrition summaries, AI recommendation results). Redis also provides rate limiting counters and supports WebSocket horizontal scaling via the Socket.IO Redis adapter. Redis is not used as a primary data store.

### Python + FastAPI (AI Microservice)

Python's AI/ML ecosystem (TensorFlow, PyTorch, scikit-learn, Hugging Face) is unmatched for implementing recommendation and inference features. FastAPI provides high-performance async REST endpoints with automatic OpenAPI documentation, making integration with the NestJS backend straightforward. FastAPI scored 4.00/5.00 in the main backend matrix — second to NestJS — but was selected as the **dedicated AI microservice** where its AI/ML ecosystem advantage (rating: 5/5) is directly utilized and the scope is sufficiently narrow that the maintainability trade-off is acceptable.

### WebSockets / Socket.IO (Real-time)

NestJS's `@nestjs/websockets` module with Socket.IO provides the real-time event layer. WebSockets are used for social activity updates, live workout notifications, and other event-driven interactions. REST remains the protocol for standard request/response operations. This hybrid approach is appropriate — REST for reliability and cacheability, WebSockets for low-latency events.

---

## Consequences

### Positive Consequences

- **Single frontend codebase:** Flutter enables iOS, Android, and Web development from one project, reducing team overhead and code drift.
- **Structured modular backend:** NestJS module system enforces clean code organization and makes onboarding new developers straightforward.
- **Relational data integrity:** PostgreSQL's ACID guarantees protect sensitive health records from inconsistent states.
- **Managed authentication:** Firebase Authentication reduces the operational burden of maintaining authentication infrastructure.
- **Independent AI scaling:** The FastAPI AI microservice can be scaled, updated, and modified independently from the main backend.
- **Real-time capability:** Socket.IO is production-proven for the scale FitFlow is expected to reach.

### Negative Consequences / Trade-offs

- **Dart learning curve:** Developers unfamiliar with Dart require an onboarding period.
- **Multiple service operational complexity:** Managing NestJS, FastAPI, PostgreSQL, Redis, and Firebase introduces multiple moving parts in the production environment.
- **Firebase vendor dependency:** Firebase Authentication creates a dependency on Google infrastructure. Migration away from Firebase would require changes to both the Flutter client and the NestJS token verification logic.
- **NestJS complexity:** NestJS's opinionated structure is beneficial at scale but may feel heavyweight for very small features or prototyping.

---

## Alternatives Considered

| Category       | Alternative              | Reason Not Selected                                               |
|----------------|--------------------------|-------------------------------------------------------------------|
| Frontend       | React Native             | Web support requires third-party React Native Web; less integrated |
| Frontend       | Kotlin Multiplatform     | UI must be written separately per platform; Web support is experimental |
| Frontend       | Swift/SwiftUI            | iOS/macOS only; no Android or Web support                         |
| Main Backend   | Python + FastAPI         | Lower maintainability score; weaker native WebSocket gateway      |
| Main Backend   | Go                       | High development friction; limited AI/ML integration; smaller ecosystem |
| Database       | MongoDB                  | Poor JOIN support; document model does not fit FitFlow's relational data |
| Database       | Firebase Firestore       | Limited query capabilities; schema-less risks data inconsistency  |
| Database       | Amazon DynamoDB          | Complex key design; poor for complex relational queries            |
| Authentication | Auth0                    | Higher cost at scale; Firebase integration for Flutter is more native |
| Authentication | AWS Cognito              | AWS-centric; complex configuration; weaker Flutter SDK experience  |
| Authentication | Supabase Auth            | Supabase DB not selected; auth coupling would add unnecessary dependency |

---

## Related Documents

- [Activity 1 – Frontend Technology Comparison](activity-01-frontend-comparison.md)
- [Activity 2 – Backend, Database and Authentication](activity-02-backend-database-auth.md)
- [Activity 3 – Weighted Technology Decision Matrix](activity-03-decision-matrix.md)
- [Activity 4 – High-Level System Architecture](activity-04-architecture.md)

---

*ADR-001: FitFlow Technology Stack Selection*
*Course: IT3060 Human Computer Interaction | Lab Exercise 05*
