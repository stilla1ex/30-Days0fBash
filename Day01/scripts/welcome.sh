#!/bin/bash
# Day 1: Simple Environment Welcome
# A gentle introduction to bash scripting concepts

echo "=== Welcome to Cybersecurity Bash Learning ==="
echo

# Show basic environment information
echo "🔍 Your Learning Environment:"
echo "Current user: $(whoami)"
echo "Home directory: $HOME"
echo "Current shell: $SHELL"
echo "Today's date: $(date '+%Y-%m-%d %H:%M:%S')"
echo

# Simple demonstration of variables
USER_NAME=$(whoami)
echo "👋 Hello $USER_NAME! Let's start learning bash for cybersecurity."
echo

# Show current directory
echo "📁 You are currently in: $(pwd)"
echo

# Simple file listing demonstration
echo "📋 Files in current directory:"
ls -la
echo

echo "🎯 Today you'll learn:"
echo "   • Basic Linux commands"
echo "   • File system navigation"
echo "   • Command syntax and structure"
echo "   • Why bash matters for cybersecurity"
echo

echo "✅ Ready to begin! Check out the exercises/ folder to start practicing."
echo "💡 Tip: Try running 'ls exercises/' to see your practice files."
