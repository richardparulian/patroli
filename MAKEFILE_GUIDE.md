# Makefile Guide for Flutter POS Project

## Overview

Comprehensive Makefile with 90+ targets for automating Flutter development workflows.

## Quick Start

```bash
# Show all available commands
make help

# Install dependencies and setup project
make setup

# Run the app
make run

# Run tests
make test

# Build APK
make build-apk
```

## Installation & Setup

```bash
make install              # Install Flutter dependencies
make setup               # Full project setup
make setup-env           # Setup environment files
make setup-dev           # Setup development environment
make setup-staging       # Setup staging environment
make setup-prod          # Setup production environment
```

## Code Generation

```bash
make generate-code         # Generate code (build_runner)
make generate-code-watch  # Watch mode for code generation
make clean-generated      # Clean generated files
```

## Development

```bash
make run                 # Run app in debug mode
make run-dev            # Run with dev environment
make run-staging        # Run with staging environment
make run-prod           # Run with prod environment
make run-web            # Run on web browser
make run-android        # Run on Android
make run-ios            # Run on iOS
make run-mac            # Run on macOS
make run-windows        # Run on Windows
make run-linux          # Run on Linux
make run-all-devices    # Run on all devices
```

## Testing

```bash
make test               # Run all tests
make test-unit         # Run unit tests
make test-widget        # Run widget tests
make test-integration   # Run integration tests
make test-coverage     # Run with coverage report
make test-coverage-html # Generate HTML coverage
make test-watch        # Watch mode for tests
make update-goldens    # Update golden files
```

## Code Quality

```bash
make analyze            # Run Flutter analyze
make format            # Format all Dart files
make format-check       # Check if code is formatted
make lint              # Alias for analyze
make fix               # Fix auto-fixable issues
make fix-dry-run       # Show fixes without applying
make check-all         # Run all checks (format, analyze, test)
```

## Building

```bash
make build             # Build for release (APK)
make build-apk         # Build Android APK
make build-apk-debug   # Build debug APK
make build-appbundle   # Build Android App Bundle
make build-ios         # Build iOS app
make build-ipa         # Alias for build-ios
make build-web         # Build for web
make build-mac         # Build for macOS
make build-windows     # Build for Windows
make build-linux       # Build for Linux
make build-all         # Build for all platforms
make build-profile     # Build in profile mode
```

## Generators

```bash
make generate-feature FEATURE_NAME=my_feature    # Generate new feature
make generate-language LANGUAGE_CODE=id         # Generate new language
make generate-icons                          # Generate app icons
make rename-app APP_NAME="My App" PACKAGE_NAME=com.company.app  # Rename app
```

## Docker (Optional)

```bash
make docker-build      # Build Docker image
make docker-run       # Run Docker container
make docker-stop      # Stop all containers
make docker-clean     # Clean Docker
```

## Cleaning

```bash
make clean            # Clean build artifacts
make clean-all        # Clean everything
make clean-android    # Clean Android build
make clean-ios        # Clean iOS build
make clean-pub        # Clean pub cache
```

## Tools & Utilities

```bash
make doctor           # Run Flutter doctor
make upgrade          # Upgrade Flutter and dependencies
make pub-get          # Run flutter pub get
make pub-upgrade      # Upgrade dependencies
make pub-outdated     # Check outdated dependencies
make version          # Show Flutter version
make devices         # List available devices
```

## Deployment

```bash
make deploy-android        # Prepare Android APK for deployment
make deploy-web          # Prepare web app for deployment
make deploy-firebase      # Deploy to Firebase Hosting
make deploy-github-pages  # Deploy to GitHub Pages
```

## Git Helpers

```bash
make git-status      # Show git status
make git-log         # Show recent commits
make git-diff        # Show git diff
make git-add-all     # Add all changes
make git-commit MESSAGE="Your message"  # Commit changes
make git-push        # Push to remote
make git-pull        # Pull from remote
make git-branch      # Show all branches
make git-checkout BRANCH=main  # Checkout branch
```

## Workflows

### Start Feature
```bash
make workflow-feature-start FEATURE=user_profile
# ... do work ...
make git-commit MESSAGE="Add user profile feature"
make git-push
# ... create pull request
```

### Complete Feature
```bash
make workflow-feature-complete FEATURE=user_profile MESSAGE="Completed user profile"
```

### Hotfix
```bash
make workflow-hotfix-start HOTFIX=fix_login_bug
# ... fix bug ...
make git-commit MESSAGE="Fix login bug"
make git-push
```

## CI/CD

```bash
make ci-build       # CI build pipeline (install, generate, analyze, test)
make ci-test        # CI test pipeline
make ci-quality     # CI quality check
```

## Monitoring & Debugging

```bash
make logs         # Show Flutter logs
make attach       # Attach to running app
make trace        # Trace performance
make drive        # Run Flutter Driver tests
make screenshot    # Take screenshot
```

## Project Information

```bash
make info          # Show project information
make stats        # Show project statistics
```

## Environment Variables

The Makefile uses these variables (can be overridden):

```bash
APP_NAME=pos        # Application name
FLUTTER=flutter   # Flutter command
DART=dart         # Dart command
```

## Color Coding

The Makefile uses colored output:
- 🔵 Blue: Information messages
- 🟢 Green: Success messages
- 🟡 Yellow: Warning messages
- 🔴 Red: Error messages

## Examples

### Daily Development Workflow
```bash
# Morning setup
make setup-dev
make generate-code-watch &

# Development
make run-dev

# When adding new code
make format
make analyze
make test

# End of day
make test
make git-add-all
make git-commit MESSAGE="Daily progress"
make git-push
```

### Feature Development Workflow
```bash
# Start new feature
make workflow-feature-start FEATURE=shopping_cart

# Generate feature structure
make generate-feature FEATURE_NAME=shopping_cart

# Development
make run-dev

# Testing
make test
make test-coverage

# Quality check
make check-all

# Build and deploy
make build-apk
make deploy-android
```

### Release Workflow
```bash
# Prepare for release
make setup-prod
make clean-all
make check-all

# Build for all platforms
make build-all

# Deploy
make deploy-android
make deploy-web
```

## Tips

1. **Use Tab Completion**: Use `make help` to see all commands
2. **Chain Commands**: Combine commands with `&&` or `;`
3. **Watch Mode**: Use `make generate-code-watch` during development
4. **Environment Switching**: Use `make setup-dev/staging/prod` to switch environments
5. **Before Push**: Always run `make check-all` before pushing

## Troubleshooting

### Make: Command not found
```bash
# Install Make (macOS)
brew install make

# Install Make (Linux)
sudo apt-get install build-essential
```

### Flutter command not found
```bash
# Add Flutter to PATH
export PATH="$PATH:/path/to/flutter/bin"
```

### Permission denied
```bash
# Make Makefile executable
chmod +x Makefile
```

## Related Documentation

- [Architecture Guide](docs/ARCHITECTURE_GUIDE.md)
- [API Implementation Guide](API_IMPLEMENTATION_GUIDE.md)
- [Environment Setup](ENVIRONMENT_SETUP.md)
- [DTOs Guide](lib/features/auth/data/dtos/README.md)

## Contributing

When adding new targets to Makefile:
1. Follow existing naming conventions
2. Add `.PHONY` declaration
3. Include descriptive help message with `##`
4. Use colored output for user feedback
5. Test thoroughly before committing
