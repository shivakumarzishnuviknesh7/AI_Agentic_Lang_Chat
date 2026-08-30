
# AI Agentic Lang Chat

AI Agentic Lang Chat is a SwiftUI-based mobile application for an AI-assisted smart factory and warehouse management system.

The app is designed to help warehouse employees access daily orders, inventory information, employee profile data, and an AI assistant through a simple mobile interface.

The mobile application is developed in SwiftUI and is designed to communicate with a separate AWS serverless backend through Amazon API Gateway.

> **Status:** Active development. Core UI screens and application structure are implemented, while cloud API integration and production authentication are being added progressively.

---
## Cloud Backend

The mobile application is supported by a separate AWS serverless backend repository:

**AI Smart Cloud** — [shivakumarzishnuviknesh7/AI_Smart_Cloud](https://github.com/shivakumarzishnuviknesh7/AI_Smart_Cloud)

The backend is built with:

- AWS Lambda
- Amazon API Gateway
- Amazon RDS for PostgreSQL
- AWS Secrets Manager
- Terraform
- Python
- n8n automation

Backend responsibilities include:

- Inventory and warehouse data
- Customer orders
- Employee profile data
- Supplier management
- Low-stock detection
- Purchase-order creation
- Automated replenishment workflows
- Read/write API endpoints for the SwiftUI application

### End-to-End Architecture

```text
                    SwiftUI iOS App
                          │
                          ▼
                 Amazon API Gateway
                          │
              ┌───────────┴───────────┐
              │                       │
              ▼                       ▼
         Read Lambda             Write Lambda
              │                       │
              └───────────┬───────────┘
                          │
                          ▼
               Amazon RDS PostgreSQL
                          │
                          ▼
              Inventory / Orders
              Suppliers / Employees


                  n8n Automation
                          │
                          ▼
                Low-stock detection
                          │
                          ▼
               Purchase-order workflow
```

## Application Overview

The application currently contains three main functional areas:

- AI Chat
- Today's Orders
- Employee Profile

Users first authenticate through a login screen and then access the application through a tab-based interface.

```text
Login
  │
  ▼
MainTabView
  │
  ├── Chat
  │
  ├── Today's Orders
  │
  └── Profile
````

---

# Current UI Architecture

The current SwiftUI application is organized using a feature-based structure.

```text
AI_Smart/
│
├── chat/
│   ├── Models/
│   ├── ViewModels/
│   └── Views/
│
├── orders/
│   ├── Models/
│   │   └── Order.swift
│   │
│   ├── ViewModels/
│   │   └── OrdersViewModel.swift
│   │
│   └── Views/
│       └── TodayOrdersView.swift
│
├── profile/
│   ├── Models/
│   ├── ViewModels/
│   └── Views/
│
├── AI_SmartApp.swift
├── ContentView.swift
├── MainTabView.swift
└── Assets.xcassets
```

The project follows a lightweight MVVM-style organization to keep UI, state, and data models separated.

---

# Main Screens

## Login

The app starts with a login screen.

Current development authentication uses a temporary local login mechanism.

Example development credentials:

```text
User ID: admin
Passcode: 1234
```

This is only for development.

Production authentication will be replaced with a secure backend-based authentication flow.

---

## Main Tab Navigation

After login, the user enters the main tab interface.

The current tabs are:

```text
Chat
Today
Profile
```

Implemented through SwiftUI `TabView`.

---

# AI Chat

The Chat screen provides an AI assistant interface for warehouse employees.

The goal is to allow users to ask natural-language questions such as:

```text
What products are required today?

Which products are currently low in stock?

Which high-priority orders are at risk?

What inventory shortages should I handle first?

Which products are already being reordered?
```

The chat interface currently includes:

* User messages
* Assistant messages
* Message bubbles
* Loading state
* Error handling
* Multi-line text input
* Send button
* Automatic scrolling

The AI integration is designed around the OpenAI API.

---

# Orders

The Today's Orders tab displays the warehouse's daily order information.

The UI currently supports:

* Total orders
* Total units ordered
* Stock shortages
* Units required
* Customer information
* Product information
* Ordered quantity
* Available stock
* Priority
* Shortage calculation

Example:

```text
Product B

Ordered: 50
Available: 20

Shortage: 30 units
```

The current UI uses local development data.

The next stage is to replace this data with responses from the AWS backend.

---

# Profile

The Profile tab stores employee-related information.

Current profile fields include:

```text
Name
Employee ID
Warehouse ID
Work Status
```

Example:

```text
Name:
Zishnu Viknesh

Employee ID:
EMP-1024

Warehouse ID:
WH-HAN-01

Work Status:
ON_SHIFT
```

Supported work statuses:

```text
ON_SHIFT
ON_BREAK
OFF_SHIFT
```

The profile feature is organized using:

```text
Model
ViewModel
View
```

---

# SwiftUI Architecture

The current application uses a simple MVVM-style structure.

```text
View
  │
  ▼
ViewModel
  │
  ▼
Model
```

Example:

```text
TodayOrdersView
      │
      ▼
OrdersViewModel
      │
      ▼
Order
```

This keeps UI rendering separated from application state and business data.

---

# Backend Integration

The mobile application is designed to communicate with a separate AWS backend.

Cloud repository:

```text
AI_Smart_Cloud
```

The backend architecture is:

```text
SwiftUI
   │
   ▼
Amazon API Gateway
   │
   ├── Read Lambda
   │
   └── Write Lambda
          │
          ▼
   Amazon RDS PostgreSQL
```

The mobile app will not directly connect to PostgreSQL.

All backend communication goes through API Gateway.

---

# Planned Read API Integration

The SwiftUI app will consume endpoints such as:

```text
GET /orders

GET /inventory

GET /inventory/low-stock

GET /profile/{employeeId}

GET /products/{productId}/supplier

GET /purchase-orders/open
```

Example:

```text
TodayOrdersView
      │
      ▼
GET /orders
      │
      ▼
API Gateway
      │
      ▼
Read Lambda
      │
      ▼
PostgreSQL
```

---

# Planned Write API Integration

The app will also support backend write operations such as:

```text
POST /orders

PUT /inventory/{inventoryId}

PUT /profile/{employeeId}/status
```

Example:

```text
ProfileView
    │
    ▼
Change Work Status
    │
    ▼
PUT /profile/EMP-1024/status
    │
    ▼
API Gateway
    │
    ▼
Write Lambda
```

---

# AI + Backend Design

The AI assistant and deterministic backend logic have different responsibilities.

Deterministic operations such as:

```text
quantity_available <= reorder_level
```

are handled by backend/database logic.

AI is intended for:

* Natural-language interaction
* Operational summaries
* Prioritization
* Explanation
* Recommendations
* User assistance

This keeps critical inventory decisions deterministic while still providing an intelligent interface for employees.

---

# Cloud Automation

The backend also includes an n8n automation design for inventory replenishment.

The mobile application can eventually show the result of this automation, including:

```text
Low-stock products

Preferred supplier

Existing purchase order

Purchase-order status

Expected delivery
```

This allows the SwiftUI app to become the employee-facing interface for the broader warehouse automation platform.

---

# Technology Stack

| Layer              | Technology              |
| ------------------ | ----------------------- |
| Mobile             | Swift                   |
| UI                 | SwiftUI                 |
| Architecture       | MVVM-style              |
| AI                 | OpenAI API              |
| Backend API        | Amazon API Gateway      |
| Serverless Backend | AWS Lambda              |
| Database           | PostgreSQL / Amazon RDS |
| Infrastructure     | Terraform               |
| Automation         | n8n                     |
| Version Control    | Git / GitHub            |

---

# Current Development Status

## Implemented

* SwiftUI project structure
* Login screen
* Tab-based navigation
* AI Chat UI
* Chat message model
* Chat ViewModel
* Orders model
* Orders ViewModel
* Today's Orders screen
* Profile model
* Profile ViewModel
* Profile screen
* Local development data
* OpenAI chat service structure

## In Progress

* AWS API integration
* Replace local order data with backend data
* Replace local employee data with backend data
* Production authentication
* Secure OpenAI API handling
* Error-state improvements
* Loading-state improvements

## Planned

* Live inventory integration
* Purchase-order status
* Supplier information
* n8n workflow visibility
* Authentication and authorization
* Push notifications
* Production logging
* Unit tests
* UI tests
* CI/CD

---

# Development Roadmap

```text
1. Complete SwiftUI screen architecture
2. Connect Orders screen to AWS API
3. Connect Profile screen to AWS API
4. Add production authentication
5. Connect AI chat with operational backend data
6. Display low-stock and reorder information
7. Add purchase-order visibility
8. Add loading and retry states
9. Add unit and UI testing
10. Add CI/CD
```

---

# Project Vision

The long-term goal is to provide warehouse employees with one mobile interface for:

```text
Daily Orders
Inventory
Stock Shortages
Employee Information
Purchase Orders
AI Assistance
```

The final system combines:

```text
SwiftUI Mobile App
        │
        ▼
AI Assistant + AWS Backend
        │
        ▼
Warehouse Operations
        │
        ├── Customer Orders
        ├── Inventory
        ├── Suppliers
        ├── Purchase Orders
        └── Automation
```

The project demonstrates mobile development, cloud architecture, serverless APIs, relational database design, Infrastructure as Code, workflow automation, and AI-assisted user interaction in one end-to-end system.

---

## License

This project is licensed under the MIT License.


