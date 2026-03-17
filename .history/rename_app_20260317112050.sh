#!/bin/bash

set -euo pipefail

GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

show_usage() {
    echo -e "Usage: $0 [options]"
    echo -e "\nOptions:"
    echo -e "  --app-name \"New App Name\""
    echo -e "  --package-name com.example.newapp"
    echo -e "  --help"
    echo
    echo -e "Example:"
    echo -e "  $0 --app-name \"My Amazing App\" --package-name com.mycompany.amazingapp"
    exit 1
}

replace_in_file() {
    local file="$1"
    local pattern="$2"
    local replacement="$3"

    if [ -f "$file" ]; then
        perl -0pi -e "s/$pattern/$replacement/g" "$file"
    fi
}

replace_literal_in_file() {
    local file="$1"
    local search="$2"
    local replacement="$3"

    if [ -f "$file" ]; then
        SEARCH="$search" REPLACEMENT="$replacement" perl -0pi -e 's/\Q$ENV{SEARCH}\E/$ENV{REPLACEMENT}/g' "$file"
    fi
}

update_progress() {
    CURRENT_STEP=$((CURRENT_STEP + 1))
    echo -e "${BLUE}[$CURRENT_STEP/$TOTAL_STEPS] $1${NC}"
}

sanitize_package_name() {
    echo "$1" | tr '[:upper:]' '[:lower:]' | tr ' -' '_' | tr -cd 'a-z0-9_'
}

echo -e "${BLUE}=======================================${NC}"
echo -e "${BLUE}      Flutter App Renamer Script      ${NC}"
echo -e "${BLUE}=======================================${NC}"
echo

NEW_APP_NAME=""
NEW_PACKAGE_NAME=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        --app-name)
            if [[ $# -lt 2 ]]; then
                echo -e "${RED}Error: Missing value for --app-name${NC}"
                show_usage
            fi
            NEW_APP_NAME="$2"
            shift 2
            ;;
        --package-name)
            if [[ $# -lt 2 ]]; then
                echo -e "${RED}Error: Missing value for --package-name${NC}"
                show_usage
            fi
            NEW_PACKAGE_NAME="$2"
            shift 2
            ;;
        --help)
            show_usage
            ;;
        *)
            echo -e "${RED}Error: Unknown option: $1${NC}"
            show_usage
            ;;
    esac
done

if [ -z "$NEW_APP_NAME" ] || [ -z "$NEW_PACKAGE_NAME" ]; then
    echo -e "${RED}Error: Both --app-name and --package-name are required${NC}"
    show_usage
fi

if ! [[ $NEW_PACKAGE_NAME =~ ^[a-z][a-z0-9_]*(\.[a-z0-9_]+)+[0-9a-z_]$ ]]; then
    echo -e "${RED}Error: Package name must be in valid format (e.g., com.example.app)${NC}"
    exit 1
fi

CURRENT_DIR="$(pwd)"
PUBSPEC_PATH="$CURRENT_DIR/pubspec.yaml"

if [ ! -f "$PUBSPEC_PATH" ]; then
    echo -e "${RED}Error: pubspec.yaml not found. Please run this script from the root of your Flutter project.${NC}"
    exit 1
fi

CURRENT_APP_NAME="$(grep "^name:" "$PUBSPEC_PATH" | head -n 1 | awk -F': ' '{print $2}' | tr -d ' ')"
PUBSPEC_APP_NAME="$(sanitize_package_name "$NEW_APP_NAME")"
OLD_PACKAGE_NAME=""

if [ -f "android/app/src/main/AndroidManifest.xml" ]; then
    OLD_PACKAGE_NAME="$(grep "package=" "android/app/src/main/AndroidManifest.xml" | sed 's/.*package="\(.*\)".*/\1/' || true)"
fi

echo -e "${YELLOW}Current app name identifier:${NC} $CURRENT_APP_NAME"
echo -e "${YELLOW}New app display name:${NC} $NEW_APP_NAME"
echo -e "${YELLOW}New package name:${NC} $NEW_PACKAGE_NAME"
echo -e "${YELLOW}New Dart package name:${NC} $PUBSPEC_APP_NAME"

echo
read -r -p "Do you want to proceed with renaming? This operation cannot be easily undone. (y/N): " -n 1
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}Operation canceled.${NC}"
    exit 0
fi

echo -e "${BLUE}Starting renaming process...${NC}"

TOTAL_STEPS=8
CURRENT_STEP=0

update_progress "Updating Android files"

if [ -f "android/app/src/main/res/values/strings.xml" ]; then
    replace_in_file "android/app/src/main/res/values/strings.xml" '<string name="app_name">.*?</string>' "<string name=\"app_name\">$NEW_APP_NAME</string>"
elif [ -d "android/app/src/main/res/values" ]; then
    cat > "android/app/src/main/res/values/strings.xml" <<EOF
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="app_name">$NEW_APP_NAME</string>
</resources>
EOF
fi

if [ -f "android/app/build.gradle" ]; then
    replace_in_file "android/app/build.gradle" 'applicationId ".*?"' "applicationId \"$NEW_PACKAGE_NAME\""
elif [ -f "android/app/build.gradle.kts" ]; then
    replace_in_file "android/app/build.gradle.kts" 'applicationId = ".*?"' "applicationId = \"$NEW_PACKAGE_NAME\""
    replace_in_file "android/app/build.gradle.kts" 'namespace = ".*?"' "namespace = \"$NEW_PACKAGE_NAME\""
fi

if [ -n "$OLD_PACKAGE_NAME" ] && [ -f "android/app/src/main/AndroidManifest.xml" ]; then
    replace_literal_in_file "android/app/src/main/AndroidManifest.xml" "package=\"$OLD_PACKAGE_NAME\"" "package=\"$NEW_PACKAGE_NAME\""
fi

if [ -n "$OLD_PACKAGE_NAME" ]; then
    OLD_PACKAGE_PATH="$(echo "$OLD_PACKAGE_NAME" | tr '.' '/')"
    NEW_PACKAGE_PATH="$(echo "$NEW_PACKAGE_NAME" | tr '.' '/')"

    if [ -d "android/app/src/main/kotlin/$OLD_PACKAGE_PATH" ]; then
        mkdir -p "android/app/src/main/kotlin/$NEW_PACKAGE_PATH"
        find "android/app/src/main/kotlin/$OLD_PACKAGE_PATH" -type f -name "*.kt" -exec mv {} "android/app/src/main/kotlin/$NEW_PACKAGE_PATH/" \;
        find "android/app/src/main/kotlin/$NEW_PACKAGE_PATH" -name "*.kt" -type f -exec perl -0pi -e "s/\Q$OLD_PACKAGE_NAME\E/$NEW_PACKAGE_NAME/g" {} \;
        find "android/app/src/main/kotlin/$OLD_PACKAGE_PATH" -type d -empty -delete || true
    fi
fi

update_progress "Updating iOS files"

if [ -f "ios/Runner.xcodeproj/project.pbxproj" ]; then
    replace_in_file "ios/Runner.xcodeproj/project.pbxproj" 'PRODUCT_BUNDLE_IDENTIFIER = .*?;' "PRODUCT_BUNDLE_IDENTIFIER = $NEW_PACKAGE_NAME;"
fi

if [ -f "ios/Runner/Info.plist" ]; then
    replace_in_file "ios/Runner/Info.plist" '<string>[^<]*</string>' '<string>\$(PRODUCT_NAME)</string>'
    replace_in_file "ios/Runner/Info.plist" '<key>CFBundleDisplayName</key>\s*<string>.*?</string>' "<key>CFBundleDisplayName</key>\n\t<string>$NEW_APP_NAME</string>"
    replace_in_file "ios/Runner/Info.plist" '<key>CFBundleName</key>\s*<string>.*?</string>' "<key>CFBundleName</key>\n\t<string>$NEW_APP_NAME</string>"
fi

update_progress "Updating macOS files"

if [ -f "macos/Runner.xcodeproj/project.pbxproj" ]; then
    replace_in_file "macos/Runner.xcodeproj/project.pbxproj" 'PRODUCT_BUNDLE_IDENTIFIER = .*?;' "PRODUCT_BUNDLE_IDENTIFIER = $NEW_PACKAGE_NAME;"
fi

if [ -f "macos/Runner/Info.plist" ]; then
    replace_in_file "macos/Runner/Info.plist" '<key>CFBundleDisplayName</key>\s*<string>.*?</string>' "<key>CFBundleDisplayName</key>\n\t<string>$NEW_APP_NAME</string>"
    replace_in_file "macos/Runner/Info.plist" '<key>CFBundleName</key>\s*<string>.*?</string>' "<key>CFBundleName</key>\n\t<string>$NEW_APP_NAME</string>"
fi

update_progress "Updating Windows files"

if [ -f "windows/CMakeLists.txt" ]; then
    replace_in_file "windows/CMakeLists.txt" 'project\(.*?\)' "project($PUBSPEC_APP_NAME LANGUAGES CXX)"
    replace_in_file "windows/CMakeLists.txt" 'set\(BINARY_NAME ".*?"\)' "set(BINARY_NAME \"$PUBSPEC_APP_NAME\")"
fi

if [ -f "windows/runner/Runner.rc" ]; then
    replace_in_file "windows/runner/Runner.rc" 'VALUE "FileDescription", ".*?"' "VALUE \"FileDescription\", \"$NEW_APP_NAME\""
    replace_in_file "windows/runner/Runner.rc" 'VALUE "ProductName", ".*?"' "VALUE \"ProductName\", \"$NEW_APP_NAME\""
fi

update_progress "Updating Linux files"

if [ -f "linux/CMakeLists.txt" ]; then
    replace_in_file "linux/CMakeLists.txt" 'project\(.*?\)' "project($PUBSPEC_APP_NAME LANGUAGES CXX)"
    replace_in_file "linux/CMakeLists.txt" 'set\(BINARY_NAME ".*?"\)' "set(BINARY_NAME \"$PUBSPEC_APP_NAME\")"
    replace_in_file "linux/CMakeLists.txt" 'set\(APPLICATION_ID ".*?"\)' "set(APPLICATION_ID \"$NEW_PACKAGE_NAME\")"
fi

if [ -f "linux/my_application.cc" ]; then
    replace_in_file "linux/my_application.cc" 'g_application_set_application_id \(application, ".*?"\);' "g_application_set_application_id (application, \"$NEW_PACKAGE_NAME\");"
fi

update_progress "Updating web files"

if [ -f "web/index.html" ]; then
    replace_in_file "web/index.html" '<title>.*?</title>' "<title>$NEW_APP_NAME</title>"
fi

if [ -f "web/manifest.json" ]; then
    replace_in_file "web/manifest.json" '"name": ".*?"' "\"name\": \"$NEW_APP_NAME\""
    replace_in_file "web/manifest.json" '"short_name": ".*?"' "\"short_name\": \"$NEW_APP_NAME\""
fi

update_progress "Updating pubspec.yaml"

replace_in_file "$PUBSPEC_PATH" '^name: .*?$' "name: $PUBSPEC_APP_NAME"
replace_in_file "$PUBSPEC_PATH" '^description: .*?$' "description: \"$NEW_APP_NAME - A Flutter starter application.\""

update_progress "Updating app constants and Dart imports"

while IFS= read -r constants_file; do
    if grep -q "appName" "$constants_file"; then
        replace_in_file "$constants_file" "static const String appName = '.*?'" "static const String appName = '$NEW_APP_NAME'"
        replace_in_file "$constants_file" 'static const String appName = ".*?"' "static const String appName = \"$NEW_APP_NAME\""
    fi
done < <(find ./lib -path "*/lib/*" -name "*constants*.dart" | grep -i "app" || true)

if [ -n "$CURRENT_APP_NAME" ] && [ "$CURRENT_APP_NAME" != "$PUBSPEC_APP_NAME" ]; then
    find ./lib ./test -type f -name "*.dart" -exec perl -0pi -e "s/package:\Q$CURRENT_APP_NAME\E/package:$PUBSPEC_APP_NAME/g" {} \;
fi

echo
echo -e "${GREEN}✅ App successfully renamed!${NC}"
echo -e "   - Display Name: ${YELLOW}$NEW_APP_NAME${NC}"
echo -e "   - Package/Bundle ID: ${YELLOW}$NEW_PACKAGE_NAME${NC}"
echo -e "   - Dart Package Name: ${YELLOW}$PUBSPEC_APP_NAME${NC}"
echo
echo -e "${BLUE}Next steps:${NC}"
echo -e "1. Run ${YELLOW}flutter clean${NC}"
echo -e "2. Run ${YELLOW}flutter pub get${NC}"
echo -e "3. Re-run ${YELLOW}flutter build${NC} for each platform you're targeting"
echo
echo -e "${YELLOW}Note:${NC} Review platform-specific files if your project uses custom native setup."
echo
