# 🚀 Code Review API

**Rails 8.1.1 API backend for an AI-powered code review tool** – built with modern practices to showcase full-stack development skills.

## ✨ Features

- **🔐 JWT Authentication** – Secure token-based auth using Devise-JWT
- **📦 RESTful API** – Clean, versioned endpoints (`/api/v1/`)
- **🐘 PostgreSQL** – Production-ready database
- **🧪 Testing Ready** – RSpec, FactoryBot configured
- **🎨 Code Quality** – RuboCop, Brakeman for security & style
- **⚡ Rails 8.1.1** – Latest features with API-only mode

## 🛠 Tech Stack

- **Backend**: Ruby 3.4.8, Rails 8.1.1
- **Database**: PostgreSQL
- **Auth**: Devise + Devise-JWT
- **Testing**: RSpec, FactoryBot
- **Code Quality**: RuboCop, Brakeman, Bundler Audit
- **API**: RESTful, JSON responses

## 🚦 Quick Start

```bash
# 1. Clone and setup
git clone https://github.com/YOUR_USERNAME/code-review-api.git
cd code-review-api
bundle install

# 2. Database setup
rails db:create
rails db:migrate

# 3. Run the server
rails server

API Example
# Create a code submission
curl -X POST http://localhost:3000/api/v1/code_submissions.json \
  -H "Content-Type: application/json" \
  -d '{"code_submission": {"content": "def test; end", "language": "ruby"}}'

Development
# Run tests
rspec

# Code quality checks
rubocop
brakeman
