#!/bin/bash

# Git setup and push script for loan-agent project
# This script initializes the repository and pushes to GitHub

set -e  # Exit on error

echo "🚀 Setting up Git repository..."

# Navigate to project directory
cd "$(dirname "$0")"

# Check if git is already initialized
if [ -d ".git" ]; then
    echo "⚠️  Git repository already exists. Skipping git init..."
else
    echo "📦 Initializing git repository..."
    git init
fi

# Add all files
echo "📝 Staging all files..."
git add -A

# Show status
echo "📊 Git status:"
git status --short

# Create commit
echo "💾 Creating commit..."
git commit -m "Initial commit: Clean codebase with comprehensive documentation

- Removed 2,175+ lines of dead code
- Deleted unused API endpoints (genai_enhanced, workflows_bpmn)
- Removed unused services (RabbitMQ, A/B testing, multi-agent, chatbot)
- Cleaned up duplicate models in additional.py
- Removed broken Dockerfile and workers directory
- Updated requirements.txt (removed RabbitMQ dependencies)
- Added comprehensive README with architecture, setup, and API docs

Co-Authored-By: Claude Sonnet 5.5 <noreply@anthropic.com>" || echo "⚠️  Nothing to commit or commit failed"

# Rename branch to main
echo "🔀 Setting branch to main..."
git branch -M main

# Check if remote exists
if git remote | grep -q "origin"; then
    echo "⚠️  Remote 'origin' already exists. Removing and re-adding..."
    git remote remove origin
fi

# Add remote repository
echo "🔗 Adding remote repository..."
git remote add origin https://github.com/alancapco/loan-agent.git

# Push to GitHub
echo "⬆️  Pushing to GitHub..."
echo "If this fails due to existing repository, you may need to use --force"
git push -u origin main || {
    echo ""
    echo "❌ Push failed. This might be because the remote repository already has content."
    echo "To force push (WARNING: This will overwrite remote), run:"
    echo "   git push -u origin main --force"
    echo ""
    read -p "Do you want to force push now? (yes/no): " response
    if [ "$response" = "yes" ]; then
        echo "⚠️  Force pushing..."
        git push -u origin main --force
    else
        echo "Skipping force push. You can manually run: git push -u origin main --force"
    fi
}

echo ""
echo "✅ Done! Repository should be available at:"
echo "   https://github.com/alancapco/loan-agent"
echo ""
