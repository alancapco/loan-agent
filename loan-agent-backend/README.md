# Loan Agent Backend

A modern, AI-powered loan collection system backend built with FastAPI, featuring GenAI integration for intelligent case management, automated script generation, and compliance monitoring.

## 🏗️ System Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                         Client Layer                             │
│  (Web UI, Mobile Apps, External Systems)                        │
└────────────────────────┬────────────────────────────────────────┘
                         │ HTTPS/REST API
┌────────────────────────▼────────────────────────────────────────┐
│                      FastAPI Backend                             │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │              API Layer (v1)                               │  │
│  │  • Auth  • Cases  • GenAI  • Rules  • Workflows          │  │
│  │  • Analytics  • Documents  • Deployment                  │  │
│  └───────────────────────┬──────────────────────────────────┘  │
│                          │                                       │
│  ┌───────────────────────▼──────────────────────────────────┐  │
│  │              Business Logic Layer                         │  │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │  │
│  │  │  GenAI       │  │  Workflow    │  │  Rules       │  │  │
│  │  │  Services    │  │  Engine      │  │  Engine      │  │  │
│  │  │              │  │              │  │  (DMN)       │  │  │
│  │  └──────────────┘  └──────────────┘  └──────────────┘  │  │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │  │
│  │  │  Trust Gate  │  │  Document    │  │  Camunda     │  │  │
│  │  │  Validator   │  │  Generator   │  │  Client      │  │  │
│  │  └──────────────┘  └──────────────┘  └──────────────┘  │  │
│  └───────────────────────┬──────────────────────────────────┘  │
│                          │                                       │
│  ┌───────────────────────▼──────────────────────────────────┐  │
│  │              Data Access Layer                            │  │
│  │  • SQLAlchemy ORM  • Async PostgreSQL  • Alembic         │  │
│  └──────────────────────────────────────────────────────────┘  │
└────────────────────────┬────────────────────────────────────────┘
                         │
        ┌────────────────┼────────────────┬─────────────┐
        │                │                │             │
┌───────▼──────┐  ┌─────▼─────┐  ┌──────▼──────┐  ┌──▼─────────┐
│  PostgreSQL  │  │   Redis   │  │  ChromaDB   │  │  OpenAI/   │
│  (Primary    │  │  (Cache)  │  │  (Vector    │  │  Anthropic │
│   Database)  │  │           │  │   Store)    │  │  (LLM API) │
└──────────────┘  └───────────┘  └─────────────┘  └────────────┘
```

## 🎯 Key Features

### Core Capabilities
- **Case Management** - Complete lifecycle management of loan collection cases
- **User Authentication** - JWT-based secure authentication with role-based access control
- **Workflow Engine** - Custom workflow engine for orchestrating collection processes
- **Business Rules Engine** - DMN-based rules engine for compliance and decision automation

### AI/GenAI Features
- **AI Case Summarization** - Automatic generation of intelligent case summaries
- **Script Generation** - AI-powered collection script generation with compliance checking
- **Intent Analysis** - Natural language understanding for customer communication analysis
- **Willingness Scoring** - ML-based prediction of customer payment willingness
- **RAG (Retrieval Augmented Generation)** - Knowledge base integration for contextual AI responses
- **Trust Gate** - Quality validation layer for AI-generated content

### Integration & Automation
- **Camunda BPM** - Integration with Camunda for external workflow orchestration
- **DMN Rules Engine** - Decision Model and Notation for business rules
- **Document Generation** - Automated generation of collection documents
- **Vector Store** - ChromaDB integration for semantic search and RAG

### Analytics & Compliance
- **Performance Analytics** - Real-time dashboards and metrics
- **Compliance Monitoring** - Automated compliance violation detection
- **Audit Logging** - Complete audit trail for GenAI operations

## 🛠️ Technology Stack

### Backend Framework
- **FastAPI** - Modern, high-performance Python web framework
- **Python 3.11+** - Latest Python features and performance improvements
- **Uvicorn** - Lightning-fast ASGI server

### Database & Storage
- **PostgreSQL** - Primary relational database
- **SQLAlchemy 2.0** - Async ORM with modern async/await support
- **Alembic** - Database migration management
- **Redis** - Caching and session management

### AI/ML Integration
- **OpenAI API** - GPT-4 for text generation and analysis
- **Anthropic Claude** - Alternative LLM provider
- **ChromaDB** - Vector database for embeddings and semantic search
- **LangChain** - LLM orchestration and RAG implementation

### Security & Authentication
- **JWT (python-jose)** - JSON Web Tokens for authentication
- **Passlib + Bcrypt** - Secure password hashing
- **CORS Middleware** - Cross-origin resource sharing support

## 📋 Prerequisites

- **Python** 3.11 or higher
- **PostgreSQL** 14 or higher
- **Redis** 6 or higher (optional, for caching)
- **Git** for version control
- **OpenAI API Key** or **Anthropic API Key** (for GenAI features)

## 🚀 Installation & Setup

### 1. Clone the Repository

```bash
git clone https://github.com/alancapco/loan-agent.git
cd loan-agent/loan-agent-backend
```

### 2. Create Virtual Environment

```bash
# Create virtual environment
python -m venv venv

# Activate virtual environment
# On macOS/Linux:
source venv/bin/activate

# On Windows:
venv\Scripts\activate
```

### 3. Install Dependencies

```bash
pip install --upgrade pip
pip install -r requirements.txt
```

### 4. Environment Configuration

```bash
# Copy the example environment file
cp .env.example .env

# Edit .env with your configuration
nano .env  # or use your preferred editor
```

### 5. Configure Environment Variables

Edit `.env` file with your settings:

```bash
# Application
APP_NAME=Loan Agent Backend
DEBUG=True

# Database (Required)
DATABASE_URL=postgresql+asyncpg://user:password@localhost:5432/loan_agent

# Redis (Optional - for caching)
REDIS_URL=redis://localhost:6379/0

# JWT Security (Required)
SECRET_KEY=your-secret-key-change-in-production
ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30

# CORS (Required for frontend)
CORS_ORIGINS=http://localhost:3000,http://localhost:3001

# GenAI - OpenAI (Choose one provider)
OPENAI_API_KEY=sk-your-openai-key
OPENAI_BASE_URL=https://api.openai.com/v1
OPENAI_MODEL=gpt-4
OPENAI_EMBEDDING_MODEL=text-embedding-3-large

# GenAI - Anthropic (Alternative provider)
ANTHROPIC_API_KEY=your-anthropic-key
ANTHROPIC_MODEL=claude-3-5-sonnet-20241022

# Default LLM Provider
DEFAULT_LLM_PROVIDER=openai  # or 'anthropic'

# External Services (Optional)
CAMUNDA_URL=http://localhost:8080/engine-rest
CHROMADB_URL=http://localhost:8000
```

### 6. Database Setup

```bash
# Create PostgreSQL database
createdb loan_agent

# Or using psql
psql -U postgres
CREATE DATABASE loan_agent;
\q

# Run database migrations
alembic upgrade head
```

### 7. Seed Initial Data (Optional)

```bash
# Create test users and sample data
python scripts/seed_data.py
```

Default users created:
- **Admin**: `admin` / `admin123`
- **Collector**: `collector1` / `admin123`

### 8. Start the Application

```bash
# Development mode with auto-reload
uvicorn app.main:app --reload --port 8000

# Production mode
gunicorn app.main:app -w 4 -k uvicorn.workers.UvicornWorker --bind 0.0.0.0:8000
```

The API will be available at: **http://localhost:8000**

### 9. Access API Documentation

- **Swagger UI**: http://localhost:8000/docs
- **ReDoc**: http://localhost:8000/redoc
- **OpenAPI JSON**: http://localhost:8000/openapi.json

## 📁 Project Structure

```
loan-agent-backend/
├── app/
│   ├── api/
│   │   └── v1/                      # API version 1 endpoints
│   │       ├── __init__.py
│   │       ├── auth.py              # Authentication endpoints
│   │       ├── cases.py             # Case management endpoints
│   │       ├── genai.py             # GenAI endpoints
│   │       ├── rules.py             # Business rules endpoints
│   │       ├── workflows.py         # Workflow management endpoints
│   │       ├── analytics.py         # Analytics and reporting endpoints
│   │       ├── documents.py         # Document generation endpoints
│   │       └── deployment.py        # Deployment endpoints
│   │
│   ├── core/                        # Core functionality
│   │   ├── __init__.py
│   │   ├── config.py                # Configuration management
│   │   ├── database.py              # Database configuration
│   │   └── security.py              # Authentication & security
│   │
│   ├── models/                      # Database models (SQLAlchemy)
│   │   ├── __init__.py
│   │   ├── base.py                  # Base models (User, Case, etc.)
│   │   ├── case.py                  # Case-specific models
│   │   ├── user.py                  # User models
│   │   └── workflow.py              # Workflow models
│   │
│   ├── schemas/                     # Pydantic schemas (validation)
│   │   └── __init__.py              # Request/Response schemas
│   │
│   ├── services/                    # Business logic layer
│   │   ├── genai/                   # GenAI services
│   │   │   ├── __init__.py
│   │   │   ├── llm_client.py        # LLM client wrapper
│   │   │   ├── summarizer.py        # Case summarization
│   │   │   ├── script_generator.py  # Script generation
│   │   │   ├── intent_analyzer.py   # Intent analysis
│   │   │   ├── willingness_scorer.py # Willingness scoring
│   │   │   ├── compliance_checker.py # Compliance checking
│   │   │   ├── rag_service.py       # RAG implementation
│   │   │   └── vector_store.py      # Vector database client
│   │   │
│   │   ├── workflows/               # Workflow engine
│   │   │   └── engine.py            # Custom workflow engine
│   │   │
│   │   ├── camunda/                 # Camunda integration
│   │   │   ├── __init__.py
│   │   │   ├── client.py            # Camunda REST client
│   │   │   └── zeebe_client.py      # Zeebe client
│   │   │
│   │   ├── camunda_dmn/             # DMN rules engine
│   │   │   ├── __init__.py
│   │   │   ├── rules_engine.py      # Rules engine implementation
│   │   │   ├── rules_service.py     # Rules service
│   │   │   ├── client.py            # DMN client
│   │   │   └── nl_to_drl_generator.py # Natural language to DRL
│   │   │
│   │   ├── documents/               # Document generation
│   │   │   └── generator.py         # Document generator
│   │   │
│   │   ├── trust_gate.py            # Trust Gate validation
│   │   └── camunda_deployment.py    # Camunda deployment service
│   │
│   ├── workflows/                   # Workflow definitions
│   │   └── definitions/
│   │       └── collection_workflows.py # Collection workflow definitions
│   │
│   ├── rules/                       # Business rules
│   │   ├── __init__.py
│   │   └── collection_rules.py      # Collection rules definitions
│   │
│   ├── db/                          # Database configuration
│   │   └── session.py               # Database session management
│   │
│   └── main.py                      # Application entry point
│
├── alembic/                         # Database migrations
│   ├── versions/                    # Migration files
│   └── env.py                       # Alembic configuration
│
├── scripts/                         # Utility scripts
│   ├── seed_data.py                 # Database seeding
│   └── embed_knowledge_base.py      # Vector embedding generation
│
├── tests/                           # Test suite
│   ├── __init__.py
│   ├── conftest.py                  # Test configuration
│   ├── test_api.py                  # API tests
│   └── test_rules.py                # Rules engine tests
│
├── .env.example                     # Example environment file
├── .gitignore                       # Git ignore rules
├── alembic.ini                      # Alembic configuration
├── requirements.txt                 # Python dependencies
└── README.md                        # This file
```

## 🔄 Data Flow

### 1. GenAI Case Summarization Flow

```
┌─────────────┐
│   Client    │
└──────┬──────┘
       │ POST /api/v1/genai/summarize
       ▼
┌─────────────────┐
│  API Endpoint   │ (genai.py)
└────────┬────────┘
         │
         ▼
┌──────────────────┐
│ Summarizer       │ (summarizer.py)
│ Service          │
└────────┬─────────┘
         │
         ├─► Fetch case from PostgreSQL
         │
         ├─► Generate summary via LLM API
         │   (OpenAI/Anthropic)
         │
         ├─► Validate via Trust Gate
         │
         └─► Store audit log in PostgreSQL
              │
              ▼
         ┌─────────────┐
         │   Response  │
         │  (Summary)  │
         └─────────────┘
```

### 2. Workflow Execution Flow

```
┌─────────────┐
│   Client    │
└──────┬──────┘
       │ POST /api/v1/workflows/start
       ▼
┌─────────────────┐
│  API Endpoint   │ (workflows.py)
└────────┬────────┘
         │
         ▼
┌──────────────────┐
│ Workflow Engine  │ (engine.py)
└────────┬─────────┘
         │
         ├─► Create workflow instance
         │
         ├─► Execute task sequence
         │   │
         │   ├─► User Task
         │   ├─► Service Task
         │   ├─► Decision Gateway
         │   └─► Script Task
         │
         ├─► Update task status in PostgreSQL
         │
         └─► Trigger next task or complete
              │
              ▼
         ┌─────────────┐
         │  Workflow   │
         │  Instance   │
         └─────────────┘
```

### 3. Rules Engine Decision Flow

```
┌─────────────┐
│   Client    │
└──────┬──────┘
       │ POST /api/v1/rules/evaluate
       ▼
┌─────────────────┐
│  API Endpoint   │ (rules.py)
└────────┬────────┘
         │
         ▼
┌──────────────────┐
│ Rules Engine     │ (rules_engine.py)
└────────┬─────────┘
         │
         ├─► Fetch active rules from PostgreSQL
         │
         ├─► Evaluate rules against case data
         │   │
         │   ├─► Compliance rules
         │   ├─► Assignment rules
         │   ├─► Strategy rules
         │   └─► Priority rules
         │
         ├─► Apply rule actions
         │
         └─► Return decision result
              │
              ▼
         ┌─────────────┐
         │   Decision  │
         │   Result    │
         └─────────────┘
```

## 📚 API Documentation

### Authentication

#### Login
```http
POST /api/v1/auth/login
Content-Type: application/json

{
  "username": "admin",
  "password": "admin123"
}

Response: {
  "access_token": "eyJhbGc...",
  "token_type": "bearer",
  "user": { ... }
}
```

#### Get Current User
```http
GET /api/v1/auth/me
Authorization: Bearer <token>

Response: {
  "id": "uuid",
  "username": "admin",
  "email": "admin@example.com",
  "role": "admin"
}
```

### Case Management

#### List Cases
```http
GET /api/v1/cases?status=new&limit=10&offset=0
Authorization: Bearer <token>

Response: {
  "total": 100,
  "cases": [...]
}
```

#### Get Case Details
```http
GET /api/v1/cases/{case_id}
Authorization: Bearer <token>

Response: {
  "id": "uuid",
  "case_id": "CASE123",
  "customer_id": "CUST456",
  "overdue_amount": 5000.00,
  "status": "new",
  ...
}
```

#### Create Case
```http
POST /api/v1/cases
Authorization: Bearer <token>
Content-Type: application/json

{
  "customer_id": "CUST456",
  "loan_id": "LOAN789",
  "overdue_amount": 5000.00,
  "overdue_days": 45,
  "priority": 7
}
```

#### Assign Case
```http
POST /api/v1/cases/{case_id}/assign
Authorization: Bearer <token>
Content-Type: application/json

{
  "collector_id": "uuid"
}
```

### GenAI Services

#### Summarize Case
```http
POST /api/v1/genai/summarize
Authorization: Bearer <token>
Content-Type: application/json

{
  "case_id": "uuid"
}

Response: {
  "summary": "Customer has been overdue for 45 days...",
  "confidence": 0.92,
  "processing_time_ms": 1234
}
```

#### Generate Collection Script
```http
POST /api/v1/genai/generate-script
Authorization: Bearer <token>
Content-Type: application/json

{
  "case_id": "uuid",
  "scenario": "first_contact",
  "tone": "professional"
}

Response: {
  "script": "Good morning, this is [Name] calling from...",
  "confidence": 0.88,
  "compliance_checked": true,
  "compliance_issues": []
}
```

#### Analyze Customer Intent
```http
POST /api/v1/genai/analyze-intent
Authorization: Bearer <token>
Content-Type: application/json

{
  "transcript": "I really want to pay but I lost my job..."
}

Response: {
  "intent": "willing_to_pay",
  "sentiment": "negative",
  "confidence": 0.85,
  "key_phrases": ["want to pay", "lost my job"]
}
```

#### Score Willingness to Pay
```http
POST /api/v1/genai/score-willingness
Authorization: Bearer <token>
Content-Type: application/json

{
  "case_id": "uuid"
}

Response: {
  "willingness_score": 7.5,
  "factors": [...],
  "confidence": 0.78,
  "recommendation": "Offer payment plan"
}
```

### Rules Management

#### List Rules
```http
GET /api/v1/rules?rule_type=compliance&is_active=true
Authorization: Bearer <token>
```

#### Evaluate Rules
```http
POST /api/v1/rules/evaluate
Authorization: Bearer <token>
Content-Type: application/json

{
  "case_data": {
    "overdue_days": 45,
    "overdue_amount": 5000,
    "contact_count": 3
  }
}
```

### Workflows

#### Start Workflow
```http
POST /api/v1/workflows/start
Authorization: Bearer <token>
Content-Type: application/json

{
  "workflow_key": "standard_collection",
  "business_key": "CASE123",
  "variables": {
    "priority": 7,
    "overdue_amount": 5000
  }
}
```

#### Get Workflow Instance
```http
GET /api/v1/workflows/instances/{instance_id}
Authorization: Bearer <token>
```

#### Complete Task
```http
POST /api/v1/workflows/tasks/{instance_id}/{task_id}/complete
Authorization: Bearer <token>
Content-Type: application/json

{
  "variables": {
    "contacted": true,
    "outcome": "payment_promised"
  }
}
```

### Analytics

#### Dashboard Statistics
```http
GET /api/v1/analytics/dashboard-stats
Authorization: Bearer <token>

Response: {
  "cases": {
    "total": 1000,
    "active": 450,
    "resolved": 550
  },
  "financial": {
    "total_overdue_amount": 5000000.00,
    "recovered_amount": 2100000.00,
    "recovery_rate": 0.42
  },
  "genai": {
    "total_calls": 2500,
    "avg_confidence": 0.85
  }
}
```

#### Performance Metrics
```http
GET /api/v1/analytics/performance
Authorization: Bearer <token>
```

#### Compliance Metrics
```http
GET /api/v1/analytics/compliance-metrics
Authorization: Bearer <token>
```

## 🔧 Components

### Core Components

#### **FastAPI Application** (`app/main.py`)
- Application entry point
- Router registration
- CORS middleware configuration
- Lifespan event handlers for startup/shutdown

#### **Configuration** (`app/core/config.py`)
- Environment variable management
- Pydantic settings validation
- Multi-provider LLM configuration

#### **Security** (`app/core/security.py`)
- JWT token generation and validation
- Password hashing with bcrypt
- User authentication middleware

### Data Layer

#### **Database Models** (`app/models/`)
- **Base Models**: User, Customer, Case, ContactHistory, Rule, GenAIAudit, ScriptTemplate, ComplianceViolation, TaskQueue
- **Workflow Models**: WorkflowInstance, WorkflowTask
- SQLAlchemy ORM with async support
- Relationship management and cascading

#### **Database Session** (`app/db/session.py`)
- Async database connection management
- Session dependency injection
- Connection pooling

### Business Logic Layer

#### **GenAI Services** (`app/services/genai/`)

**LLM Client** (`llm_client.py`)
- Multi-provider LLM support (OpenAI, Anthropic)
- Unified interface for different LLM APIs
- Error handling and retry logic

**Summarizer** (`summarizer.py`)
- Case data extraction and formatting
- LLM-based summary generation
- Confidence scoring

**Script Generator** (`script_generator.py`)
- Context-aware script generation
- Scenario and tone customization
- RAG integration for knowledge retrieval
- Automatic compliance checking

**Intent Analyzer** (`intent_analyzer.py`)
- Natural language understanding
- Sentiment analysis
- Key phrase extraction

**Willingness Scorer** (`willingness_scorer.py`)
- Historical behavior analysis
- Payment likelihood prediction
- Action recommendation

**Compliance Checker** (`compliance_checker.py`)
- Rule-based compliance validation
- Keyword detection
- Severity classification

**RAG Service** (`rag_service.py`)
- Knowledge base retrieval
- Semantic search
- Context augmentation

**Vector Store** (`vector_store.py`)
- ChromaDB integration
- Embedding generation and storage
- Similarity search

#### **Workflow Engine** (`app/services/workflows/engine.py`)
- Custom workflow orchestration
- Task execution and routing
- State management
- Event-driven architecture

#### **Rules Engine** (`app/services/camunda_dmn/`)
- DMN (Decision Model and Notation) support
- Rule evaluation engine
- Priority-based rule execution
- Dynamic rule management

#### **Trust Gate** (`app/services/trust_gate.py`)
- AI output validation
- Quality scoring
- Risk assessment
- Human review routing

#### **Document Generator** (`app/services/documents/generator.py`)
- Template-based document generation
- Dynamic content rendering
- Multiple format support

#### **Camunda Integration** (`app/services/camunda/`)
- Camunda BPM REST client
- Process deployment
- Task management
- Zeebe client for cloud workflows

## 🧪 Development

### Database Migrations

```bash
# Create a new migration after model changes
alembic revision --autogenerate -m "description of changes"

# Apply all pending migrations
alembic upgrade head

# Rollback last migration
alembic downgrade -1

# Show migration history
alembic history

# Show current version
alembic current
```

### Code Quality

```bash
# Format code with Black
black app/ tests/

# Sort imports with isort
isort app/ tests/

# Lint with Flake8
flake8 app/ tests/

# Type checking with MyPy
mypy app/
```

### Testing

```bash
# Run all tests
pytest

# Run with coverage report
pytest --cov=app --cov-report=html tests/

# Run specific test file
pytest tests/test_api.py

# Run tests in verbose mode
pytest -v

# Run tests with output
pytest -s
```

### Create Test Data

```bash
# Seed database with test data
python scripts/seed_data.py

# Create knowledge base embeddings
python scripts/embed_knowledge_base.py
```

## 🚢 Deployment

### Production Considerations

1. **Environment Variables**
   - Use strong `SECRET_KEY` (generate with `openssl rand -hex 32`)
   - Set `DEBUG=False`
   - Use production database URLs
   - Configure proper CORS origins

2. **Database**
   - Use connection pooling
   - Set up regular backups
   - Configure read replicas for scaling

3. **Security**
   - Enable HTTPS/TLS
   - Set up rate limiting
   - Configure firewall rules
   - Use secrets management (AWS Secrets Manager, HashiCorp Vault)

4. **Monitoring**
   - Set up application logging
   - Configure error tracking (Sentry)
   - Monitor API performance
   - Set up health checks

5. **Scaling**
   - Use Gunicorn with multiple workers
   - Set up load balancer
   - Configure horizontal pod autoscaling (Kubernetes)
   - Use Redis for session management

### Docker Deployment (Optional)

```bash
# Build Docker image
docker build -t loan-agent-backend .

# Run container
docker run -d -p 8000:8000 \
  --env-file .env \
  --name loan-agent-backend \
  loan-agent-backend

# Or use docker-compose
docker-compose up -d
```

### Production Server

```bash
# Install production dependencies
pip install -r requirements.txt

# Run with Gunicorn
gunicorn app.main:app \
  -w 4 \
  -k uvicorn.workers.UvicornWorker \
  --bind 0.0.0.0:8000 \
  --access-logfile - \
  --error-logfile - \
  --log-level info
```

## 🔍 Troubleshooting

### Database Connection Issues
```bash
# Check PostgreSQL is running
pg_isready -h localhost -p 5432

# Test connection
psql -U postgres -d loan_agent -c "SELECT 1;"

# Verify DATABASE_URL in .env
echo $DATABASE_URL
```

### Migration Issues
```bash
# Reset migrations (WARNING: drops all data)
alembic downgrade base
alembic upgrade head

# Check migration status
alembic current
alembic history
```

### GenAI API Issues
```bash
# Test OpenAI connection
curl https://api.openai.com/v1/models \
  -H "Authorization: Bearer $OPENAI_API_KEY"

# Check API key in .env
echo $OPENAI_API_KEY | cut -c1-10
```

## 📝 License

Proprietary - Capco © 2024

## 🤝 Contributing

This is a proprietary project. For internal contributors:

1. Create a feature branch from `main`
2. Make your changes with clear commit messages
3. Run tests and ensure all pass
4. Create a pull request with description
5. Request code review

## 📧 Support

For issues or questions, contact the development team or create an issue in the repository.

---

**Repository**: https://github.com/alancapco/loan-agent.git

**Last Updated**: January 2024
