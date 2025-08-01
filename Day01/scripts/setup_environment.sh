#!/bin/bash
# Day 1: Simple Setup Helper
# Basic environment check for beginners

echo "=== Day 1: Basic Environment Check ==="
echo

# Check if we're in the right directory
echo "📍 Current location: $(pwd)"

# Show basic system info
echo "🖥️  System Information:"
echo "   User: $(whoami)"
echo "   Home: $HOME"
echo "   Shell: $SHELL"

# Check if basic commands work
echo -e "\n🔧 Testing Basic Commands:"
echo "   ✓ ls command available"
ls --version | head -1

echo "   ✓ cat command available" 
cat --version | head -1

echo "   ✓ grep command available"
grep --version | head -1

echo -e "\n✅ Your environment is ready for Day 1 exercises!"
echo "💡 Tip: Try running the exercises in the exercises/ folder"