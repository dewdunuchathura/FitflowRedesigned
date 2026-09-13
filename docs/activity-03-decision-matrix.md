# Activity 3 – Weighted Technology Decision Matrix

**IT3060 – Human Computer Interaction | Lab Exercise 05**

---

## 1. Introduction

This activity presents a weighted scoring matrix for each technology layer of the FitFlow system. Each candidate is scored against a set of criteria relevant to FitFlow's requirements. Criteria are assigned weights that reflect their relative importance to the project. Final weighted scores determine the recommended technology for each layer.

### Scoring Scale

| Score | Meaning      |
|-------|--------------|
| 5     | Excellent     |
| 4     | Good          |
| 3     | Average       |
| 2     | Poor          |
| 1     | Very poor     |

### Formula

```
Weighted Score = Σ (Rating × Weight)
Maximum possible score = 5.00
```

All weights within each matrix sum to 100%.

---

## 2. Frontend Technology Matrix

### 2.1 Criteria and Weights

| Criterion              | Weight | Justification                                                           |
|------------------------|--------|-------------------------------------------------------------------------|
| Cross-platform support | 20%    | FitFlow must support iOS, Android, and Web — this is the primary requirement |
| Web compatibility      | 15%    | Web is an explicit target alongside mobile platforms                    |
| Performance            | 15%    | Smooth UI is essential for workout tracking and real-time features      |
| Development speed      | 15%    | Mid-sized team must deliver features efficiently                        |
| Code reusability       | 15%    | Shared code reduces maintenance burden across platforms                 |
| Ecosystem support      | 10%    | Libraries and community affect long-term productivity                   |
| Maintenance cost       | 5%     | Lower maintenance cost improves long-term sustainability                |
| AI/ML integration      | 5%     | Frontend consumes AI services via API; direct ML is secondary           |

**Total: 100%**

### 2.2 Ratings

| Criterion              | Weight | Flutter | React Native | Kotlin Multiplatform | Swift/SwiftUI |
|------------------------|--------|---------|--------------|----------------------|---------------|
| Cross-platform support | 20%    | **5**   | 4            | 3                    | 1             |
| Web compatibility      | 15%    | **4**   | 3            | 1                    | 1             |
| Performance            | 15%    | 4       | 3            | **5**                | **5**         |
| Development speed      | 15%    | **5**   | 4            | 3                    | 3             |
| Code reusability       | 15%    | **5**   | 4            | 3                    | 1             |
| Ecosystem support      | 10%    | 4       | **5**        | 3                    | 4             |
| Maintenance cost       | 5%     | **4**   | 3            | 3                    | 2             |
| AI/ML integration      | 5%     | 4       | 4            | 4                    | 3             |

### 2.3 Weighted Scores

| Criterion              | Weight | Flutter        | React Native   | Kotlin MP      | Swift/SwiftUI  |
|------------------------|--------|----------------|----------------|----------------|----------------|
| Cross-platform support | 20%    | 5 × 0.20 = 1.00| 4 × 0.20 = 0.80| 3 × 0.20 = 0.60| 1 × 0.20 = 0.20|
| Web compatibility      | 15%    | 4 × 0.15 = 0.60| 3 × 0.15 = 0.45| 1 × 0.15 = 0.15| 1 × 0.15 = 0.15|
| Performance            | 15%    | 4 × 0.15 = 0.60| 3 × 0.15 = 0.45| 5 × 0.15 = 0.75| 5 × 0.15 = 0.75|
| Development speed      | 15%    | 5 × 0.15 = 0.75| 4 × 0.15 = 0.60| 3 × 0.15 = 0.45| 3 × 0.15 = 0.45|
| Code reusability       | 15%    | 5 × 0.15 = 0.75| 4 × 0.15 = 0.60| 3 × 0.15 = 0.45| 1 × 0.15 = 0.15|
| Ecosystem support      | 10%    | 4 × 0.10 = 0.40| 5 × 0.10 = 0.50| 3 × 0.10 = 0.30| 4 × 0.10 = 0.40|
| Maintenance cost       | 5%     | 4 × 0.05 = 0.20| 3 × 0.05 = 0.15| 3 × 0.05 = 0.15| 2 × 0.05 = 0.10|
| AI/ML integration      | 5%     | 4 × 0.05 = 0.20| 4 × 0.05 = 0.20| 4 × 0.05 = 0.20| 3 × 0.05 = 0.15|
| **Total**              | 100%   | **4.50**       | **3.75**       | **3.05**       | **2.35**       |

### 2.4 Frontend Result

| Rank | Technology           | Weighted Score |
|------|----------------------|---------------|
| 1    | **Flutter**          | **4.50**      |
| 2    | React Native         | 3.75          |
| 3    | Kotlin Multiplatform | 3.05          |
| 4    | Swift/SwiftUI        | 2.35          |

**Frontend recommendation: Flutter (score 4.50)**

Flutter's strong scores on cross-platform support (the highest-weighted criterion), code reusability, and development speed produce a clear margin over the alternatives. React Native is the second-ranked choice and is a viable mobile-only option, but its Web compatibility limitation and lower reusability score reduce its total. Swift/SwiftUI scores last due to its inability to target Android or Web.

---

## 3. Backend Technology Matrix

### 3.1 Criteria and Weights

| Criterion          | Weight | Justification                                                       |
|--------------------|--------|---------------------------------------------------------------------|
| Performance        | 15%    | API responsiveness affects user experience                          |
| Scalability        | 15%    | FitFlow expects user growth; backend must scale                     |
| Development speed  | 15%    | Feature delivery velocity matters for a mid-sized team              |
| Maintainability    | 15%    | Long-term code quality is critical for a growing application        |
| Real-time support  | 10%    | WebSocket/Socket.IO integration is a core requirement               |
| Ecosystem          | 10%    | Library availability reduces development effort                     |
| AI/ML integration  | 10%    | Main backend connects to AI service; direct ML is secondary         |
| Security           | 10%    | Health data requires robust authentication and input validation     |

**Total: 100%**

### 3.2 Ratings

| Criterion          | Weight | Node.js + NestJS | Python + FastAPI | Go   |
|--------------------|--------|------------------|------------------|------|
| Performance        | 15%    | 4                | 4                | **5**|
| Scalability        | 15%    | 4                | 4                | **5**|
| Development speed  | 15%    | 4                | **5**            | 3    |
| Maintainability    | 15%    | **5**            | 3                | 4    |
| Real-time support  | 10%    | **5**            | 3                | 3    |
| Ecosystem          | 10%    | 4                | 4                | 3    |
| AI/ML integration  | 10%    | 3                | **5**            | 2    |
| Security           | 10%    | 4                | 4                | **5**|

### 3.3 Weighted Scores

| Criterion          | Weight | Node.js + NestJS   | Python + FastAPI   | Go                 |
|--------------------|--------|--------------------|--------------------|--------------------|
| Performance        | 15%    | 4 × 0.15 = 0.60   | 4 × 0.15 = 0.60   | 5 × 0.15 = 0.75   |
| Scalability        | 15%    | 4 × 0.15 = 0.60   | 4 × 0.15 = 0.60   | 5 × 0.15 = 0.75   |
| Development speed  | 15%    | 4 × 0.15 = 0.60   | 5 × 0.15 = 0.75   | 3 × 0.15 = 0.45   |
| Maintainability    | 15%    | 5 × 0.15 = 0.75   | 3 × 0.15 = 0.45   | 4 × 0.15 = 0.60   |
| Real-time support  | 10%    | 5 × 0.10 = 0.50   | 3 × 0.10 = 0.30   | 3 × 0.10 = 0.30   |
| Ecosystem          | 10%    | 4 × 0.10 = 0.40   | 4 × 0.10 = 0.40   | 3 × 0.10 = 0.30   |
| AI/ML integration  | 10%    | 3 × 0.10 = 0.30   | 5 × 0.10 = 0.50   | 2 × 0.10 = 0.20   |
| Security           | 10%    | 4 × 0.10 = 0.40   | 4 × 0.10 = 0.40   | 5 × 0.10 = 0.50   |
| **Total**          | 100%   | **4.15**           | **4.00**           | **3.85**           |

### 3.4 Backend Result

| Rank | Technology        | Weighted Score |
|------|-------------------|---------------|
| 1    | **Node.js + NestJS** | **4.15**  |
| 2    | Python + FastAPI  | 4.00          |
| 3    | Go                | 3.85          |

**Main backend recommendation: Node.js + NestJS (score 4.15)**

NestJS scores highest due to its excellent maintainability (enforced modular architecture in TypeScript) and first-class real-time support via the built-in WebSocket gateway. These are weighted criteria that reflect FitFlow's long-term team productivity and real-time feature requirements.

Python + FastAPI scores highest on AI/ML integration (5) and development speed (5), giving it an overall score of 4.00. However, its lower maintainability score (3) reflects the challenges of maintaining a large dynamically typed Python application over time with a mid-sized team. FastAPI's AI/ML strengths are not wasted — it is selected as the **dedicated AI microservice**, where those strengths are directly applicable and its lower maintainability concern is mitigated by the narrower scope of the service.

Go is the fastest and most concurrent option but scores lowest for development speed and AI/ML integration, making it less suitable as the primary backend for FitFlow at this stage.

---

## 4. Database Technology Matrix

### 4.1 Criteria and Weights

| Criterion              | Weight | Justification                                                         |
|------------------------|--------|-----------------------------------------------------------------------|
| Relationship support   | 20%    | FitFlow data model has many-to-many and one-to-many relationships     |
| Data consistency (ACID)| 20%    | Health data requires transactional integrity                          |
| Query performance      | 15%    | Complex queries for workout, nutrition, and social data               |
| Scalability            | 15%    | User base growth requires scalable storage                            |
| Health data suitability| 15%    | Structured schema reduces errors in sensitive health records          |
| Security               | 10%    | Row-level security and encryption for health data                     |
| Cost                   | 5%     | Open-source or reasonably priced managed options preferred            |

**Total: 100%**

### 4.2 Ratings

| Criterion              | Weight | PostgreSQL | MongoDB | Firebase Firestore | DynamoDB |
|------------------------|--------|------------|---------|--------------------|----------|
| Relationship support   | 20%    | **5**      | 2       | 2                  | 2        |
| Data consistency (ACID)| 20%    | **5**      | 4       | 3                  | 3        |
| Query performance      | 15%    | **5**      | 4       | 3                  | 3        |
| Scalability            | 15%    | 4          | **5**   | **5**              | **5**    |
| Health data suitability| 15%    | **5**      | 3       | 3                  | 3        |
| Security               | 10%    | **5**      | 4       | 4                  | **5**    |
| Cost                   | 5%     | **5**      | 4       | 3                  | 3        |

### 4.3 Weighted Scores

| Criterion              | Weight | PostgreSQL       | MongoDB          | Firebase         | DynamoDB         |
|------------------------|--------|------------------|------------------|------------------|------------------|
| Relationship support   | 20%    | 5 × 0.20 = 1.00 | 2 × 0.20 = 0.40 | 2 × 0.20 = 0.40 | 2 × 0.20 = 0.40 |
| Data consistency (ACID)| 20%    | 5 × 0.20 = 1.00 | 4 × 0.20 = 0.80 | 3 × 0.20 = 0.60 | 3 × 0.20 = 0.60 |
| Query performance      | 15%    | 5 × 0.15 = 0.75 | 4 × 0.15 = 0.60 | 3 × 0.15 = 0.45 | 3 × 0.15 = 0.45 |
| Scalability            | 15%    | 4 × 0.15 = 0.60 | 5 × 0.15 = 0.75 | 5 × 0.15 = 0.75 | 5 × 0.15 = 0.75 |
| Health data suitability| 15%    | 5 × 0.15 = 0.75 | 3 × 0.15 = 0.45 | 3 × 0.15 = 0.45 | 3 × 0.15 = 0.45 |
| Security               | 10%    | 5 × 0.10 = 0.50 | 4 × 0.10 = 0.40 | 4 × 0.10 = 0.40 | 5 × 0.10 = 0.50 |
| Cost                   | 5%     | 5 × 0.05 = 0.25 | 4 × 0.05 = 0.20 | 3 × 0.05 = 0.15 | 3 × 0.05 = 0.15 |
| **Total**              | 100%   | **4.85**         | **3.60**         | **3.20**         | **3.30**         |

### 4.4 Database Result

| Rank | Technology         | Weighted Score |
|------|--------------------|---------------|
| 1    | **PostgreSQL**     | **4.85**      |
| 2    | MongoDB            | 3.60          |
| 3    | DynamoDB           | 3.30          |
| 4    | Firebase Firestore | 3.20          |

**Database recommendation: PostgreSQL (score 4.85)**

PostgreSQL achieves the highest score by a clear margin, scoring maximum ratings on relationship support, data consistency, query performance, health data suitability, and security. The two highest-weighted criteria — relationship support and ACID compliance — are where PostgreSQL excels and where the NoSQL alternatives score significantly lower. FitFlow's relational data model makes this a decisive advantage.

---

## 5. Authentication Technology Matrix

### 5.1 Criteria and Weights

| Criterion                  | Weight | Justification                                                       |
|----------------------------|--------|---------------------------------------------------------------------|
| Security                   | 20%    | Authentication protects all user health data                        |
| Ease of integration        | 20%    | Must integrate with Flutter (iOS/Android/Web) and NestJS backend    |
| Scalability                | 15%    | Must handle growing user base without performance degradation        |
| Social login support       | 15%    | Google, Apple, Facebook login is expected by modern fitness app users|
| Authorization integration  | 10%    | Must support role-based access control for users, trainers, admins  |
| Developer experience       | 10%    | Clear documentation and tooling support productivity                |
| Cost                       | 10%    | Free tier must support early-stage user volume                      |

**Total: 100%**

### 5.2 Ratings

| Criterion                  | Weight | Firebase Auth | AWS Cognito | Auth0 | Supabase Auth |
|----------------------------|--------|---------------|-------------|-------|---------------|
| Security                   | 20%    | **5**         | **5**       | **5** | 4             |
| Ease of integration        | 20%    | **5**         | 3           | 4     | 4             |
| Scalability                | 15%    | **5**         | **5**       | **5** | 4             |
| Social login support       | 15%    | **5**         | 4           | **5** | 4             |
| Authorization integration  | 10%    | 4             | **5**       | **5** | 4             |
| Developer experience       | 10%    | **5**         | 3           | **5** | 4             |
| Cost                       | 10%    | **5**         | 3           | 3     | 4             |

### 5.3 Weighted Scores

| Criterion                  | Weight | Firebase Auth     | AWS Cognito       | Auth0             | Supabase Auth     |
|----------------------------|--------|-------------------|-------------------|-------------------|-------------------|
| Security                   | 20%    | 5 × 0.20 = 1.00  | 5 × 0.20 = 1.00  | 5 × 0.20 = 1.00  | 4 × 0.20 = 0.80  |
| Ease of integration        | 20%    | 5 × 0.20 = 1.00  | 3 × 0.20 = 0.60  | 4 × 0.20 = 0.80  | 4 × 0.20 = 0.80  |
| Scalability                | 15%    | 5 × 0.15 = 0.75  | 5 × 0.15 = 0.75  | 5 × 0.15 = 0.75  | 4 × 0.15 = 0.60  |
| Social login support       | 15%    | 5 × 0.15 = 0.75  | 4 × 0.15 = 0.60  | 5 × 0.15 = 0.75  | 4 × 0.15 = 0.60  |
| Authorization integration  | 10%    | 4 × 0.10 = 0.40  | 5 × 0.10 = 0.50  | 5 × 0.10 = 0.50  | 4 × 0.10 = 0.40  |
| Developer experience       | 10%    | 5 × 0.10 = 0.50  | 3 × 0.10 = 0.30  | 5 × 0.10 = 0.50  | 4 × 0.10 = 0.40  |
| Cost                       | 10%    | 5 × 0.10 = 0.50  | 3 × 0.10 = 0.30  | 3 × 0.10 = 0.30  | 4 × 0.10 = 0.40  |
| **Total**                  | 100%   | **4.90**          | **4.05**          | **4.60**          | **4.00**          |

### 5.4 Authentication Result

| Rank | Technology              | Weighted Score |
|------|-------------------------|---------------|
| 1    | **Firebase Authentication** | **4.90** |
| 2    | Auth0                   | 4.60          |
| 3    | AWS Cognito             | 4.05          |
| 4    | Supabase Auth           | 4.00          |

**Authentication recommendation: Firebase Authentication (score 4.90)**

Firebase Authentication achieves the highest score, driven by maximum ratings on security, ease of integration, scalability, social login, and developer experience. The ease of integration criterion is particularly significant — `firebase_auth` is an officially maintained Flutter plugin, making integration with FitFlow's Flutter frontend straightforward across iOS, Android, and Web. The free tier (50,000 MAU) is also the most generous, reducing early operational cost.

Auth0 is a close second at 4.60 and would be a good alternative if more complex RBAC management from a dashboard were a priority. Its lower cost score reflects its more aggressive per-user pricing at scale.

---

## 6. Final Technology Stack

The following table summarizes all technology selections and their matrix scores.

| Layer          | Selected Technology     | Score  | Reason                                                 |
|----------------|-------------------------|--------|--------------------------------------------------------|
| Frontend       | Flutter                 | 4.50/5 | Only option with first-class iOS + Android + Web       |
| Main Backend   | Node.js + NestJS        | 4.15/5 | Modular TypeScript API; built-in WebSocket; maintainable |
| Database       | PostgreSQL              | 4.85/5 | Relational structure; ACID compliance; structured health data |
| Authentication | Firebase Authentication | 4.90/5 | Easy Flutter integration; social login; free tier      |
| Cache          | Redis                   | —      | Supplementary caching layer; no direct matrix comparison needed |
| AI Service     | Python + FastAPI        | —      | Dedicated microservice selected for AI/ML ecosystem (FastAPI scored 4.00 as main backend, selected here for AI role) |
| Real-time      | WebSockets / Socket.IO  | —      | Integrated into NestJS gateway; no direct matrix comparison |

### Note on FastAPI Selection

Python + FastAPI scored 4.00 in the main backend matrix, second to NestJS (4.15). FastAPI was not selected as the main backend because:

1. Its lower maintainability score (3/5) reflects challenges of managing a large dynamically typed Python application at scale with a mid-sized team.
2. NestJS's opinionated modular structure provides better long-term code organization.
3. NestJS's built-in WebSocket gateway scores significantly higher for real-time support (5 vs 3).

However, FastAPI's maximum score for AI/ML integration (5/5) makes it the ideal choice for the **dedicated AI microservice**. In this role, the maintainability concern is mitigated by the smaller, more focused scope of the service, and the AI/ML ecosystem advantage is fully utilized.

This creates a logically defensible architecture where each technology is used in the role where it performs best.

---

*Document: Activity 3 – Weighted Technology Decision Matrix*
*Course: IT3060 Human Computer Interaction | Lab Exercise 05*
