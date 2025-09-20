#!/bin/bash

# Festify Vercel Deployment Script
# This script helps you prepare your project for Vercel deployment

echo "🚀 Festify Vercel Deployment Preparation"
echo "========================================"

# Check if we're in the right directory
if [ ! -f "vercel.json" ]; then
    echo "❌ Error: Please run this script from the Festify root directory"
    exit 1
fi

echo "✅ Found vercel.json in root directory"

# Check if environment variables file exists
if [ ! -f "vercel.env.example" ]; then
    echo "❌ Error: vercel.env.example not found"
    exit 1
fi

echo "✅ Found vercel.env.example"

# Check if Firebase secret file exists
if [ ! -f "server/src/secrets/Firebasesecret.json" ]; then
    echo "❌ Error: Firebase secret file not found at server/src/secrets/Firebasesecret.json"
    exit 1
fi

echo "✅ Found Firebase secret file"

# Check if server package.json has vercel-build script
if ! grep -q "vercel-build" server/package.json; then
    echo "❌ Error: vercel-build script not found in server/package.json"
    exit 1
fi

echo "✅ Found vercel-build script in server/package.json"

# Check if web package.json has build script
if ! grep -q '"build"' web/package.json; then
    echo "❌ Error: build script not found in web/package.json"
    exit 1
fi

echo "✅ Found build script in web/package.json"

echo ""
echo "🎉 Project is ready for Vercel deployment!"
echo ""
echo "Next steps:"
echo "1. Read VERCEL_DEPLOYMENT_GUIDE.md for detailed instructions"
echo "2. Set up your MongoDB Atlas database"
echo "3. Configure environment variables in Vercel"
echo "4. Deploy backend first, then frontend"
echo ""
echo "📚 For detailed instructions, see: VERCEL_DEPLOYMENT_GUIDE.md"
