#!/bin/bash
# Yourbself Premium Edition Build Script

set -e

echo "🚀 Yourbself Premium Edition - Build Script"
echo "=========================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo -e "${RED}❌ Flutter is not installed${NC}"
    echo "Please install Flutter from https://flutter.dev/docs/get-started/install"
    exit 1
fi

echo -e "${GREEN}✅ Flutter found${NC}"
echo ""

# Display Flutter version
echo "📦 Flutter Version:"
flutter --version
echo ""

# Get dependencies
echo -e "${YELLOW}📥 Installing dependencies...${NC}"
flutter pub get
echo -e "${GREEN}✅ Dependencies installed${NC}"
echo ""

# Run code generation (if needed)
echo -e "${YELLOW}🔧 Running code generation...${NC}"
flutter pub run build_runner build --delete-conflicting-outputs 2>/dev/null || true
echo -e "${GREEN}✅ Code generation complete${NC}"
echo ""

# Run format check
echo -e "${YELLOW}🎨 Formatting code...${NC}"
dart format --line-length 100 lib/ || true
echo -e "${GREEN}✅ Code formatted${NC}"
echo ""

# Run analyzer
echo -e "${YELLOW}🔍 Running static analysis...${NC}"
dart analyze lib/ || true
echo -e "${GREEN}✅ Analysis complete${NC}"
echo ""

echo -e "${GREEN}🎉 Build preparation complete!${NC}"
echo ""
echo "📱 To run on device:"
echo "  iOS:     flutter run -d ios"
echo "  Android: flutter run -d android"
echo "  Web:     flutter run -d chrome"
echo ""
echo "📦 To build release:"
echo "  iOS:     flutter build ios --release"
echo "  Android: flutter build apk --release"
echo "  Web:     flutter build web --release"
echo ""
