# Makefile for Flutter POS Project
# A comprehensive build automation tool for Flutter development

# Variables
APP_NAME := pos
FLUTTER := flutter
DART := dart
BUILD_DIR := build
ANDROID_BUILD_DIR := android/app/build
IOS_BUILD_DIR := ios/build
WEB_BUILD_DIR := build/web

# Colors for output
BLUE := \033[0;34m
GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
NC := \033[0m # No Color

# Default target
.DEFAULT_GOAL := help

.PHONY: help
help: ## Show this help message
	@echo "$(BLUE)Flutter POS Project - Makefile Help$(NC)"
	@echo ""
	@echo "$(GREEN)Usage:$(NC)"
	@echo "  make [target]"
	@echo ""
	@echo "$(GREEN)Available Targets:$(NC)"
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*##"}; {printf "  $(YELLOW)%-30s$(NC) %s\n", $$1, $$2}'

# =============================================================================
# INSTALLATION & SETUP
# =============================================================================

.PHONY: install
install: ## Install all Flutter dependencies
	@echo "$(BLUE)Installing Flutter dependencies...$(NC)"
	$(FLUTTER) pub get
	@echo "$(GREEN)✓ Dependencies installed$(NC)"

.PHONY: setup
setup: install setup-env generate-code ## Full project setup
	@echo "$(GREEN)✓ Project setup complete$(NC)"

.PHONY: setup-env
setup-env: ## Setup environment files
	@echo "$(BLUE)Setting up environment...$(NC)"
	@if [ ! -f lib/config/environment/.env ]; then \
		echo "$(YELLOW)Creating .env file from .env.dev$(NC)"; \
		cp lib/config/environment/.env.dev lib/config/environment/.env; \
	else \
		echo "$(GREEN)✓ .env file already exists$(NC)"; \
	fi

.PHONY: setup-dev
setup-dev: ## Setup for development environment
	@echo "$(BLUE)Setting up development environment...$(NC)"
	cp lib/config/environment/.env.dev lib/config/environment/.env
	@echo "$(GREEN)✓ Development environment configured$(NC)"

.PHONY: setup-staging
setup-staging: ## Setup for staging environment
	@echo "$(BLUE)Setting up staging environment...$(NC)"
	cp lib/config/environment/.env.staging lib/config/environment/.env
	@echo "$(GREEN)✓ Staging environment configured$(NC)"

.PHONY: setup-prod
setup-prod: ## Setup for production environment
	@echo "$(BLUE)Setting up production environment...$(NC)"
	cp lib/config/environment/.env.prod lib/config/environment/.env
	@echo "$(GREEN)✓ Production environment configured$(NC)"

# =============================================================================
# CODE GENERATION
# =============================================================================

.PHONY: generate-code
generate-code: ## Generate code (build_runner, freezed, json_serializable, etc.)
	@echo "$(BLUE)Generating code with build_runner...$(NC)"
	$(DART) run build_runner build --delete-conflicting-outputs
	@echo "$(GREEN)✓ Code generation complete$(NC)"

.PHONY: generate-code-watch
generate-code-watch: ## Watch for changes and regenerate code automatically
	@echo "$(BLUE)Watching for code changes...$(NC)"
	$(DART) run build_runner watch --delete-conflicting-outputs

.PHONY: clean-generated
clean-generated: ## Clean generated code files
	@echo "$(BLUE)Cleaning generated files...$(NC)"
	$(DART) run build_runner clean
	@echo "$(GREEN)✓ Generated files cleaned$(NC)"

# =============================================================================
# DEVELOPMENT
# =============================================================================

.PHONY: run
run: ## Run the app in debug mode
	@echo "$(BLUE)Running app in debug mode...$(NC)"
	$(FLUTTER) run

.PHONY: run-dev
run-dev: setup-dev ## Run with development environment
	@echo "$(BLUE)Running app in development mode...$(NC)"
	$(FLUTTER) run

.PHONY: run-staging
run-staging: setup-staging ## Run with staging environment
	@echo "$(BLUE)Running app in staging mode...$(NC)"
	$(FLUTTER) run

.PHONY: run-prod
run-prod: setup-prod ## Run with production environment
	@echo "$(BLUE)Running app in production mode...$(NC)"
	$(FLUTTER) run --release

.PHONY: run-web
run-web: ## Run the app on web browser
	@echo "$(BLUE)Running app on web...$(NC)"
	$(FLUTTER) run -d chrome

.PHONY: run-mac
run-mac: ## Run the app on macOS
	@echo "$(BLUE)Running app on macOS...$(NC)"
	$(FLUTTER) run -d macos

.PHONY: run-android
run-android: ## Run the app on Android device/emulator
	@echo "$(BLUE)Running app on Android...$(NC)"
	$(FLUTTER) run -d android

.PHONY: run-ios
run-ios: ## Run the app on iOS device/simulator
	@echo "$(BLUE)Running app on iOS...$(NC)"
	$(FLUTTER) run -d ios

.PHONY: run-windows
run-windows: ## Run the app on Windows
	@echo "$(BLUE)Running app on Windows...$(NC)"
	$(FLUTTER) run -d windows

.PHONY: run-linux
run-linux: ## Run the app on Linux
	@echo "$(BLUE)Running app on Linux...$(NC)"
	$(FLUTTER) run -d linux

.PHONY: run-all-devices
run-all-devices: ## Run on all available devices
	@echo "$(BLUE)Running app on all devices...$(NC)"
	$(FLUTTER) run -d all

.PHONY: hot-restart
hot-restart: ## Hot restart the running app (via CLI)
	@echo "$(YELLOW)Hot restart the app from the running IDE$(NC)"

.PHONY: hot-reload
hot-reload: ## Hot reload the running app (via CLI)
	@echo "$(YELLOW)Hot reload the app from the running IDE$(NC)"

# =============================================================================
# TESTING
# =============================================================================

.PHONY: test
test: ## Run all tests
	@echo "$(BLUE)Running all tests...$(NC)"
	$(FLUTTER) test
	@echo "$(GREEN)✓ All tests passed$(NC)"

.PHONY: test-unit
test-unit: ## Run only unit tests
	@echo "$(BLUE)Running unit tests...$(NC)"
	$(FLUTTER) test --unit

.PHONY: test-widget
test-widget: ## Run only widget tests
	@echo "$(BLUE)Running widget tests...$(NC)"
	$(FLUTTER) test --widget

.PHONY: test-integration
test-integration: ## Run integration tests
	@echo "$(BLUE)Running integration tests...$(NC)"
	$(FLUTTER) test --integration

.PHONY: test-coverage
test-coverage: ## Run tests with coverage report
	@echo "$(BLUE)Running tests with coverage...$(NC)"
	$(FLUTTER) test --coverage
	@echo "$(GREEN)✓ Coverage report generated$(NC)"

.PHONY: test-coverage-html
test-coverage-html: test-coverage ## Generate HTML coverage report
	@echo "$(BLUE)Generating HTML coverage report...$(NC)"
	genhtml coverage/lcov.info -o coverage/html
	@echo "$(GREEN)✓ HTML coverage report generated at coverage/html/index.html$(NC)"

.PHONY: test-watch
test-watch: ## Watch mode for tests
	@echo "$(BLUE)Watching for test changes...$(NC)"
	$(FLUTTER) test --watch

.PHONY: update-goldens
update-goldens: ## Update golden test files
	@echo "$(BLUE)Updating golden files...$(NC)"
	$(FLUTTER) test --update-goldens
	@echo "$(GREEN)✓ Golden files updated$(NC)"

.PHONY: test-verbose
test-verbose: ## Run tests with verbose output
	@echo "$(BLUE)Running tests with verbose output...$(NC)"
	$(FLUTTER) test --verbose

# =============================================================================
# CODE QUALITY
# =============================================================================

.PHONY: analyze
analyze: ## Run Flutter analyze
	@echo "$(BLUE)Analyzing code...$(NC)"
	$(FLUTTER) analyze
	@echo "$(GREEN)✓ Code analysis complete$(NC)"

.PHONY: format
format: ## Format all Dart files
	@echo "$(BLUE)Formatting code...$(NC)"
	$(FLUTTER) format .
	@echo "$(GREEN)✓ Code formatted$(NC)"

.PHONY: format-check
format-check: ## Check if code is formatted
	@echo "$(BLUE)Checking code format...$(NC)"
	$(FLUTTER) format --set-exit-if-changed .
	@echo "$(GREEN)✓ Code is properly formatted$(NC)"

.PHONY: lint
lint: analyze ## Alias for analyze

.PHONY: fix
fix: ## Fix all auto-fixable issues
	@echo "$(BLUE)Fixing issues...$(NC)"
	$(DART) fix --apply
	@echo "$(GREEN)✓ Issues fixed$(NC)"

.PHONY: fix-dry-run
fix-dry-run: ## Show fixes without applying them
	@echo "$(BLUE)Showing potential fixes...$(NC)"
	$(DART) fix --dry-run

.PHONY: check-all
check-all: format-check analyze test ## Run all checks (format, analyze, test)
	@echo "$(GREEN)✓ All checks passed$(NC)"

# =============================================================================
# BUILD
# =============================================================================

.PHONY: build
build: ## Build for release (default: APK)
	@echo "$(BLUE)Building for release...$(NC)"
	$(FLUTTER) build apk --release
	@echo "$(GREEN)✓ Build complete$(NC)"

.PHONY: build-apk
build-apk: ## Build Android APK
	@echo "$(BLUE)Building Android APK...$(NC)"
	$(FLUTTER) build apk --release
	@echo "$(GREEN)✓ APK built at $(BUILD_DIR)/app/outputs/flutter-apk/$(NC)"

.PHONY: build-apk-debug
build-apk-debug: ## Build Android debug APK
	@echo "$(BLUE)Building Android debug APK...$(NC)"
	$(FLUTTER) build apk --debug
	@echo "$(GREEN)✓ Debug APK built$(NC)"

.PHONY: build-appbundle
build-appbundle: ## Build Android App Bundle
	@echo "$(BLUE)Building Android App Bundle...$(NC)"
	$(FLUTTER) build appbundle --release
	@echo "$(GREEN)✓ App Bundle built at $(BUILD_DIR)/app/outputs/bundle/release/$(NC)"

.PHONY: build-ios
build-ios: ## Build iOS app
	@echo "$(BLUE)Building iOS app...$(NC)"
	$(FLUTTER) build ios --release
	@echo "$(GREEN)✓ iOS app built$(NC)"

.PHONY: build-ipa
build-ipa: build-ios ## Alias for build-ios

.PHONY: build-web
build-web: ## Build for web
	@echo "$(BLUE)Building for web...$(NC)"
	$(FLUTTER) build web --release
	@echo "$(GREEN)✓ Web app built at $(WEB_BUILD_DIR)/$(NC)"

.PHONY: build-mac
build-mac: ## Build for macOS
	@echo "$(BLUE)Building for macOS...$(NC)"
	$(FLUTTER) build macos --release
	@echo "$(GREEN)✓ macOS app built$(NC)"

.PHONY: build-windows
build-windows: ## Build for Windows
	@echo "$(BLUE)Building for Windows...$(NC)"
	$(FLUTTER) build windows --release
	@echo "$(GREEN)✓ Windows app built$(NC)"

.PHONY: build-linux
build-linux: ## Build for Linux
	@echo "$(BLUE)Building for Linux...$(NC)"
	$(FLUTTER) build linux --release
	@echo "$(GREEN)✓ Linux app built$(NC)"

.PHONY: build-all
build-all: build-apk build-ios build-web build-mac ## Build for all platforms
	@echo "$(GREEN)✓ All platforms built$(NC)"

.PHONY: build-profile
build-profile: ## Build in profile mode
	@echo "$(BLUE)Building in profile mode...$(NC)"
	$(FLUTTER) build apk --profile
	@echo "$(GREEN)✓ Profile build complete$(NC)"

# =============================================================================
# GENERATORS
# =============================================================================

.PHONY: generate-feature
generate-feature: ## Generate a new feature (usage: make generate-feature FEATURE_NAME=my_feature)
	@if [ -z "$(FEATURE_NAME)" ]; then \
		echo "$(RED)Error: FEATURE_NAME is required. Usage: make generate-feature FEATURE_NAME=my_feature$(NC)"; \
		exit 1; \
	fi
	@echo "$(BLUE)Generating feature: $(FEATURE_NAME)$(NC)"
	./generate_feature.sh --name $(FEATURE_NAME)
	@echo "$(GREEN)✓ Feature $(FEATURE_NAME) generated$(NC)"

.PHONY: generate-language
generate-language: ## Generate a new language (usage: make generate-language LANGUAGE_CODE=id)
	@if [ -z "$(LANGUAGE_CODE)" ]; then \
		echo "$(RED)Error: LANGUAGE_CODE is required. Usage: make generate-language LANGUAGE_CODE=id$(NC)"; \
		exit 1; \
	fi
	@echo "$(BLUE)Generating language: $(LANGUAGE_CODE)$(NC)"
	./generate_language.sh --code $(LANGUAGE_CODE)
	@echo "$(GREEN)✓ Language $(LANGUAGE_CODE) generated$(NC)"

.PHONY: generate-icons
generate-icons: ## Generate app icons for all platforms
	@echo "$(BLUE)Generating app icons...$(NC)"
	./generate_icons.sh
	@echo "$(GREEN)✓ App icons generated$(NC)"

.PHONY: rename-app
rename-app: ## Rename app (usage: make rename-app APP_NAME="My App" PACKAGE_NAME=com.company.app)
	@if [ -z "$(APP_NAME)" ] || [ -z "$(PACKAGE_NAME)" ]; then \
		echo "$(RED)Error: APP_NAME and PACKAGE_NAME are required. Usage: make rename-app APP_NAME='My App' PACKAGE_NAME=com.company.app$(NC)"; \
		exit 1; \
	fi
	@echo "$(BLUE)Renaming app to $(APP_NAME)...$(NC)"
	./rename_app.sh --app-name "$(APP_NAME)" --package-name $(PACKAGE_NAME)
	@echo "$(GREEN)✓ App renamed$(NC)"

# =============================================================================
# DOCKER (Optional)
# =============================================================================

.PHONY: docker-build
docker-build: ## Build Docker image
	@echo "$(BLUE)Building Docker image...$(NC)"
	docker build -t $(APP_NAME):latest .
	@echo "$(GREEN)✓ Docker image built$(NC)"

.PHONY: docker-run
docker-run: ## Run Docker container
	@echo "$(BLUE)Running Docker container...$(NC)"
	docker run --rm -it -p 8080:80 $(APP_NAME):latest

.PHONY: docker-stop
docker-stop: ## Stop all Docker containers
	@echo "$(BLUE)Stopping Docker containers...$(NC)"
	docker stop $$(docker ps -q)
	@echo "$(GREEN)✓ Docker containers stopped$(NC)"

.PHONY: docker-clean
docker-clean: ## Clean Docker images and containers
	@echo "$(BLUE)Cleaning Docker...$(NC)"
	docker system prune -f
	@echo "$(GREEN)✓ Docker cleaned$(NC)"

# =============================================================================
# CLEANING
# =============================================================================

.PHONY: clean
clean: ## Clean Flutter build artifacts
	@echo "$(BLUE)Cleaning build artifacts...$(NC)"
	$(FLUTTER) clean
	@echo "$(GREEN)✓ Build artifacts cleaned$(NC)"

.PHONY: clean-all
clean-all: clean clean-generated ## Clean everything (build artifacts and generated files)
	@echo "$(GREEN)✓ All cleaned$(NC)"

.PHONY: clean-android
clean-android: ## Clean Android build
	@echo "$(BLUE)Cleaning Android build...$(NC)"
	rm -rf $(ANDROID_BUILD_DIR)
	@echo "$(GREEN)✓ Android build cleaned$(NC)"

.PHONY: clean-ios
clean-ios: ## Clean iOS build
	@echo "$(BLUE)Cleaning iOS build...$(NC)"
	rm -rf $(IOS_BUILD_DIR)
	@echo "$(GREEN)✓ iOS build cleaned$(NC)"

.PHONY: clean-pub
clean-pub: ## Clean pub cache
	@echo "$(BLUE)Cleaning pub cache...$(NC)"
	$(FLUTTER) pub cache clean
	@echo "$(GREEN)✓ Pub cache cleaned$(NC)"

# =============================================================================
# TOOLS & UTILITIES
# =============================================================================

.PHONY: doctor
doctor: ## Run Flutter doctor to check environment
	@echo "$(BLUE)Running Flutter doctor...$(NC)"
	$(FLUTTER) doctor -v

.PHONY: upgrade
upgrade: ## Upgrade Flutter and dependencies
	@echo "$(BLUE)Upgrading Flutter...$(NC)"
	$(FLUTTER) upgrade
	@echo "$(BLUE)Upgrading dependencies...$(NC)"
	$(FLUTTER) pub upgrade
	@echo "$(GREEN)✓ Flutter and dependencies upgraded$(NC)"

.PHONY: pub-get
pub-get: ## Run flutter pub get
	@echo "$(BLUE)Getting dependencies...$(NC)"
	$(FLUTTER) pub get
	@echo "$(GREEN)✓ Dependencies updated$(NC)"

.PHONY: pub-upgrade
pub-upgrade: ## Upgrade dependencies to latest versions
	@echo "$(BLUE)Upgrading dependencies...$(NC)"
	$(FLUTTER) pub upgrade
	@echo "$(GREEN)✓ Dependencies upgraded$(NC)"

.PHONY: pub-outdated
pub-outdated: ## Check for outdated dependencies
	@echo "$(BLUE)Checking for outdated dependencies...$(NC)"
	$(FLUTTER) pub outdated

.PHONY: version
version: ## Show Flutter version
	@echo "$(BLUE)Flutter Version:$(NC)"
	@$$(FLUTTER) --version

.PHONY: devices
devices: ## List all available devices
	@echo "$(BLUE)Available devices:$(NC)"
	@$$($(FLUTTER) devices)

.PHONY: pub-serve
pub-serve: ## Start dev server for packages (for package development)
	@echo "$(BLUE)Starting pub server...$(NC)"
	$(FLUTTER) pub publish --dry-run

# =============================================================================
# DEPLOYMENT
# =============================================================================

.PHONY: deploy-android
deploy-android: build-apk ## Build and prepare Android APK for deployment
	@echo "$(GREEN)✓ APK ready for deployment at $(BUILD_DIR)/app/outputs/flutter-apk/$(NC)"

.PHONY: deploy-web
deploy-web: build-web ## Build and prepare web app for deployment
	@echo "$(GREEN)✓ Web app ready for deployment at $(WEB_BUILD_DIR)/$(NC)"
	@echo "$(YELLOW)To deploy, upload the contents of $(WEB_BUILD_DIR)/ to your web server$(NC)"

.PHONY: deploy-firebase
deploy-firebase: build-web ## Deploy web app to Firebase Hosting
	@echo "$(BLUE)Deploying to Firebase Hosting...$(NC)"
	@if command -v firebase > /dev/null; then \
		firebase deploy --only hosting; \
	else \
		echo "$(RED)Firebase CLI not installed. Install with: npm install -g firebase-tools$(NC)"; \
		exit 1; \
	fi
	@echo "$(GREEN)✓ Deployed to Firebase Hosting$(NC)"

.PHONY: deploy-github-pages
deploy-github-pages: build-web ## Deploy web app to GitHub Pages
	@echo "$(BLUE)Deploying to GitHub Pages...$(NC)"
	@if [ ! -d "gh-pages" ]; then \
		git worktree add gh-pages gh-pages; \
	fi
	rm -rf gh-pages/*
	cp -r $(WEB_BUILD_DIR)/* gh-pages/
	cd gh-pages && \
	git add . && \
	git commit -m "Deploy to GitHub Pages" && \
	git push origin gh-pages
	@echo "$(GREEN)✓ Deployed to GitHub Pages$(NC)"

# =============================================================================
# GIT HELPERS
# =============================================================================

.PHONY: git-status
git-status: ## Show git status
	@echo "$(BLUE)Git Status:$(NC)"
	git status

.PHONY: git-log
git-log: ## Show recent git commits
	@echo "$(BLUE)Recent Commits:$(NC)"
	git log --oneline -10

.PHONY: git-diff
git-diff: ## Show git diff
	@echo "$(BLUE)Git Diff:$(NC)"
	git diff

.PHONY: git-add-all
git-add-all: ## Add all changes to git
	@echo "$(BLUE)Adding all changes to git...$(NC)"
	git add .

.PHONY: git-commit
git-commit: ## Commit changes with message (usage: make git-commit MESSAGE="Your message")
	@if [ -z "$(MESSAGE)" ]; then \
		echo "$(RED)Error: MESSAGE is required. Usage: make git-commit MESSAGE='Your commit message'$(NC)"; \
		exit 1; \
	fi
	@echo "$(BLUE)Committing changes...$(NC)"
	git commit -m "$(MESSAGE)"
	@echo "$(GREEN)✓ Changes committed$(NC)"

.PHONY: git-push
git-push: ## Push changes to remote
	@echo "$(BLUE)Pushing to remote...$(NC)"
	git push
	@echo "$(GREEN)✓ Pushed to remote$(NC)"

.PHONY: git-pull
git-pull: ## Pull changes from remote
	@echo "$(BLUE)Pulling from remote...$(NC)"
	git pull
	@echo "$(GREEN)✓ Pulled from remote$(NC)"

.PHONY: git-branch
git-branch: ## Show all branches
	@echo "$(BLUE)Git Branches:$(NC)"
	git branch -a

.PHONY: git-checkout
git-checkout: ## Checkout branch (usage: make git-checkout BRANCH=main)
	@if [ -z "$(BRANCH)" ]; then \
		echo "$(RED)Error: BRANCH is required. Usage: make git-checkout BRANCH=main$(NC)"; \
		exit 1; \
	fi
	@echo "$(BLUE)Checking out branch $(BRANCH)...$(NC)"
	git checkout $(BRANCH)
	@echo "$(GREEN)✓ Switched to $(BRANCH)$(NC)"

# =============================================================================
# MONITORING & DEBUGGING
# =============================================================================

.PHONY: logs
logs: ## Show Flutter logs
	@echo "$(BLUE)Showing Flutter logs...$(NC)"
	$(FLUTTER) logs

.PHONY: attach
attach: ## Attach to running Flutter app
	@echo "$(BLUE)Attaching to running app...$(NC)"
	$(FLUTTER) attach

.PHONY: trace
trace: ## Trace performance of running app
	@echo "$(BLUE)Tracing app performance...$(NC)"
	$(FLUTTER) trace

.PHONY: drive
drive: ## Run Flutter Driver tests
	@echo "$(BLUE)Running Flutter Driver tests...$(NC)"
	$(FLUTTER) drive --target=test_driver/app.dart

.PHONY: screenshot
screenshot: ## Take a screenshot from connected device
	@echo "$(BLUE)Taking screenshot...$(NC)"
	$(FLUTTER) screenshot
	@echo "$(GREEN)✓ Screenshot saved$(NC)"

# =============================================================================
# CI/CD HELPERS
# =============================================================================

.PHONY: ci-build
ci-build: install generate-code analyze test ## CI build pipeline
	@echo "$(GREEN)✓ CI build successful$(NC)"

.PHONY: ci-test
ci-test: install generate-code test ## CI test pipeline
	@echo "$(GREEN)✓ CI tests successful$(NC)"

.PHONY: ci-quality
ci-quality: install generate-code analyze format-check ## CI quality check
	@echo "$(GREEN)✓ CI quality checks passed$(NC)"

# =============================================================================
# WORKFLOW
# =============================================================================

.PHONY: workflow-feature-start
workflow-feature-start: ## Start new feature workflow (usage: make workflow-feature-start FEATURE=my_feature)
	@if [ -z "$(FEATURE)" ]; then \
		echo "$(RED)Error: FEATURE is required. Usage: make workflow-feature-start FEATURE=my_feature$(NC)"; \
		exit 1; \
	fi
	@echo "$(BLUE)Starting feature workflow for: $(FEATURE)$(NC)"
	git checkout -b feature/$(FEATURE)
	@echo "$(GREEN)✓ Branch feature/$(FEATURE) created and checked out$(NC)"

.PHONY: workflow-feature-complete
workflow-feature-complete: ## Complete feature workflow (usage: make workflow-feature-complete FEATURE=my_feature)
	@if [ -z "$(FEATURE)" ]; then \
		echo "$(RED)Error: FEATURE is required. Usage: make workflow-feature-complete FEATURE=my_feature MESSAGE='Completed feature'$(NC)"; \
		exit 1; \
	fi
	@echo "$(BLUE)Completing feature workflow for: $(FEATURE)$(NC)"
	git checkout main
	git pull origin main
	git branch -d feature/$(FEATURE)
	@echo "$(GREEN)✓ Feature $(FEATURE) workflow complete$(NC)"

.PHONY: workflow-hotfix-start
workflow-hotfix-start: ## Start hotfix workflow (usage: make workflow-hotfix-start HOTFIX=fix_login)
	@if [ -z "$(HOTFIX)" ]; then \
		echo "$(RED)Error: HOTFIX is required. Usage: make workflow-hotfix-start HOTFIX=fix_login$(NC)"; \
		exit 1; \
	fi
	@echo "$(BLUE)Starting hotfix workflow for: $(HOTFIX)$(NC)"
	git checkout -b hotfix/$(HOTFIX)
	@echo "$(GREEN)✓ Branch hotfix/$(HOTFIX) created and checked out$(NC)"

# =============================================================================
# INFO
# =============================================================================

.PHONY: info
info: ## Show project information
	@echo "$(BLUE)Project Information:$(NC)"
	@echo "Project: $(APP_NAME)"
	@echo "Flutter Version: $$($(FLUTTER) --version)"
	@echo "Dart Version: $$($(DART) --version)"
	@echo "Git Branch: $$(git branch --show-current)"
	@echo "Git Remote: $$(git remote get-url origin)"

.PHONY: stats
stats: ## Show project statistics
	@echo "$(BLUE)Project Statistics:$(NC)"
	@echo "Total Dart files: $$(find lib -name '*.dart' | wc -l)"
	@echo "Total lines of code: $$(find lib -name '*.dart' -exec cat {} \; | wc -l)"
	@echo "Total test files: $$(find test -name '*.dart' | wc -l)"
