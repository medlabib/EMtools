# Getting Started

<cite>
**Referenced Files in This Document**
- [README.md](file://README.md)
- [pubspec.yaml](file://pubspec.yaml)
- [lib/main.dart](file://lib/main.dart)
- [android/app/build.gradle.kts](file://android/app/build.gradle.kts)
- [android/gradle.properties](file://android/gradle.properties)
- [windows/CMakeLists.txt](file://windows/CMakeLists.txt)
- [web/index.html](file://web/index.html)
- [docs/wiki/Installation.md](file://docs/wiki/Installation.md)
- [docs/wiki/Features.md](file://docs/wiki/Features.md)
- [windows_installer.iss](file://windows_installer.iss)
</cite>

## Table of Contents
1. [Introduction](#introduction)
2. [System Requirements](#system-requirements)
3. [Installation Guide](#installation-guide)
4. [First Launch Tutorial](#first-launch-tutorial)
5. [Basic Navigation Guide](#basic-navigation-guide)
6. [Initial Configuration](#initial-configuration)
7. [Troubleshooting](#troubleshooting)
8. [Development Setup](#development-setup)

## Introduction

EMtools is a comprehensive emergency medicine calculator application designed specifically for healthcare professionals working in emergency departments, intensive care units, and other acute care settings. The application provides essential medical calculations and clinical decision support tools that are critical for rapid patient assessment and treatment planning.

### Core Features

The application includes specialized calculators for:

- **Blood Gas Analysis**: Comprehensive arterial and venous blood gas interpretation with acid-base disorder identification
- **Metabolic Calculations**: Anion gap, osmolar gap, fluid requirements, and nutritional assessments
- **Antibiotic Dosing**: Weight-based dosing calculations with renal function adjustments
- **Sedation Protocols**: Sedation scoring systems and medication titration guides
- **Vasoactive Medication Management**: Vasopressor and inotrope dosing with continuous infusion calculations

These tools are designed to be accessible at the point of care, providing quick reference calculations that support evidence-based clinical decision-making in time-sensitive situations.

## System Requirements

### Android Platform
- **Minimum Android Version**: Android 5.0 (API level 21) or higher
- **Recommended Android Version**: Android 10+ for optimal performance
- **Device Requirements**: 
  - Minimum 2GB RAM
  - 100MB free storage space
  - Internet connection for updates (optional)

### Web Platform
- **Supported Browsers**:
  - Google Chrome (version 90+)
  - Mozilla Firefox (version 88+)
  - Microsoft Edge (version 90+)
  - Safari (version 14+)
- **Internet Connection**: Required for initial loading
- **Screen Resolution**: Minimum 1024x768 recommended

### Windows Platform
- **Operating System**: Windows 10 version 1903 or later
- **Processor**: x64 architecture processor
- **Memory**: Minimum 4GB RAM, 8GB recommended
- **Storage**: 200MB free disk space
- **.NET Framework**: .NET Desktop Runtime 6.0 or later

### Development Environment Requirements
- **Flutter SDK**: Version 3.0.0 or higher
- **Dart SDK**: Version 2.17.0 or higher
- **Android Studio**: Version 2021.2.1 or higher (for Android development)
- **Visual Studio**: 2019 or later (for Windows development)
- **Git**: For version control and dependency management

**Section sources**
- [pubspec.yaml:1-50](file://pubspec.yaml#L1-L50)
- [android/gradle.properties:1-20](file://android/gradle.properties#L1-L20)
- [windows/CMakeLists.txt:1-30](file://windows/CMakeLists.txt#L1-L30)

## Installation Guide

### Quick Start Installation

#### Method 1: Direct Download (Recommended)

1. **Download the Application**
   - Visit the official EMtools website or app store
   - Select your platform (Android, Web, or Windows)
   - Download the latest stable release

2. **Install the Application**
   - **Android**: Open the downloaded APK file and follow installation prompts
   - **Web**: Navigate to the web URL in your browser
   - **Windows**: Run the installer (.exe) and follow the setup wizard

#### Method 2: Development Installation

For developers who want to customize or contribute to EMtools:

1. **Install Flutter SDK**
   ```bash
   # Download Flutter SDK from https://flutter.dev/docs/get-started/install
   flutter --version
   ```

2. **Clone the Repository**
   ```bash
   git clone https://github.com/emtools/emtools.git
   cd emtools
   ```

3. **Install Dependencies**
   ```bash
   flutter pub get
   ```

4. **Run the Application**
   ```bash
   # For Android
   flutter run
   
   # For Web
   flutter run -d chrome
   
   # For Windows
   flutter run -d windows
   ```

### Platform-Specific Installation

#### Android Installation

1. **Enable Developer Options** (for sideloading)
   - Go to Settings → About Phone
   - Tap "Build Number" 7 times
   - Enable "USB Debugging" in Developer Options

2. **Install via ADB**
   ```bash
   adb install app-release.apk
   ```

3. **Install via Package Manager**
   ```bash
   flutter build apk --release
   flutter install
   ```

#### Web Installation

1. **Build Web Version**
   ```bash
   flutter build web --release
   ```

2. **Deploy to Web Server**
   - Upload the `build/web` directory to your web server
   - Configure proper MIME types for Flutter assets

#### Windows Installation

1. **Build Windows Version**
   ```bash
   flutter build windows --release
   ```

2. **Create Installer**
   ```bash
   # Using Inno Setup
   iscc windows_installer.iss
   ```

**Section sources**
- [docs/wiki/Installation.md:1-100](file://docs/wiki/Installation.md#L1-L100)
- [android/app/build.gradle.kts:1-50](file://android/app/build.gradle.kts#L1-L50)
- [windows_installer.iss:1-50](file://windows_installer.iss#L1-L50)

## First Launch Tutorial

### Initial Application Launch

When you first launch EMtools, you'll see the following welcome sequence:

1. **Splash Screen**
   - Displays the EMtools logo and version information
   - Shows loading progress for initial data setup

2. **Permission Requests**
   - Storage access (for offline data caching)
   - Network access (for updates and cloud sync)
   - Notification permissions (optional for reminders)

3. **Welcome Tour**
   - Interactive walkthrough of main features
   - Quick demonstration of key calculators
   - Tips for efficient usage

### Home Screen Layout

The home screen is organized into several key sections:

#### Top Navigation Bar
- **Search Functionality**: Quick search across all calculators
- **Settings Access**: Configuration and preferences
- **Profile Section**: User account and synchronization status

#### Calculator Categories Grid
The main interface displays calculators in categorized tiles:

- **Respiratory & Blood Gas**
  - Arterial Blood Gas Analyzer
  - Oxygenation Index Calculator
  - Acid-Base Disorder Identifier

- **Metabolic & Fluids**
  - Anion Gap Calculator
  - Osmolar Gap Calculator
  - Fluid Requirement Calculator

- **Pharmacology**
  - Antibiotic Dosing Calculator
  - Sedation Protocol Assistant
  - Vasoactive Medication Manager

- **Cardiovascular**
  - Cardiac Output Estimator
  - Shock Index Calculator
  - Perfusion Assessment Tools

#### Quick Access Favorites
- Frequently used calculators appear as shortcuts
- Customizable favorite list based on usage patterns
- Recent calculations history for quick reference

#### Status Indicators
- Offline mode availability
- Data synchronization status
- Update notifications

**Section sources**
- [lib/main.dart:1-100](file://lib/main.dart#L1-L100)
- [docs/wiki/Features.md:1-100](file://docs/wiki/Features.md#L1-L100)

## Basic Navigation Guide

### Main Navigation Patterns

EMtools uses intuitive navigation patterns designed for quick access during emergencies:

#### Primary Navigation Methods

1. **Calculator Selection Interface**
   - Category-based browsing through grid layout
   - Search functionality with autocomplete
   - Filter by specialty or frequency of use

2. **Quick Access Shortcuts**
   - Home screen favorites
   - Recently used calculators
   - Emergency quick-access panel

3. **Cross-Calculator Navigation**
   - Related calculator suggestions
   - Result sharing between calculators
   - Calculation history with export options

### Common User Workflows

#### Workflow 1: Blood Gas Analysis
1. Select "Blood Gas Analyzer" from Respiratory category
2. Enter patient demographics (age, weight, gender)
3. Input blood gas values (pH, PaCO2, PaO2, HCO3-)
4. Review automated interpretation and recommendations
5. Export results to patient record

#### Workflow 2: Antibiotic Dosing
1. Navigate to Pharmacology → Antibiotic Dosing
2. Select antibiotic from dropdown menu
3. Enter patient parameters (weight, renal function)
4. Choose indication and route of administration
5. Review calculated dose and administration schedule

#### Workflow 3: Vasoactive Medication Management
1. Access Cardiovascular → Vasoactive Medication Manager
2. Select medication (norepinephrine, epinephrine, etc.)
3. Input target hemodynamic parameters
4. Calculate initial infusion rate
5. Monitor titration guidelines and safety limits

### Advanced Navigation Features

#### Search and Discovery
- Global search across all calculators
- Voice input support for hands-free operation
- Barcode scanning for medication lookup

#### Personalization
- Favorite calculator customization
- Unit preference configuration
- Specialty-specific default views

#### Data Management
- Calculation history with timestamps
- Export to PDF or CSV formats
- Cloud synchronization across devices

**Section sources**
- [docs/wiki/Features.md:50-150](file://docs/wiki/Features.md#L50-L150)

## Initial Configuration

### Essential Settings

Upon first launch, configure these essential settings:

#### Patient Safety Settings
- **Default Units**: Metric or Imperial system selection
- **Age Groups**: Pediatric vs. Adult dosing defaults
- **Renal Function**: eGFR calculation method preference
- **Allergy Alerts**: Custom allergy database integration

#### Clinical Preferences
- **Reference Ranges**: Institution-specific normal values
- **Alert Thresholds**: Critical value notification levels
- **Calculation Precision**: Decimal place rounding preferences
- **Language**: Multi-language support configuration

#### Data Management
- **Offline Mode**: Enable/disable offline calculator access
- **Data Synchronization**: Cloud backup and sync preferences
- **Export Formats**: Default output format selection
- **Privacy Settings**: Data retention and sharing controls

### Advanced Configuration

#### Developer Options
- **Debug Logging**: Verbose error reporting
- **Test Mode**: Simulation data for development
- **Performance Monitoring**: Usage analytics collection
- **Plugin Management**: Third-party calculator extensions

#### Institutional Integration
- **EHR Connectivity**: Electronic Health Record integration
- **Medication Database**: Pharmacy system synchronization
- **Protocol Templates**: Institution-specific clinical pathways
- **Audit Trail**: Compliance logging and reporting

### Security and Privacy

#### Data Protection
- **Local Encryption**: Device-level data encryption
- **Secure Sync**: Encrypted cloud synchronization
- **Access Controls**: Biometric authentication options
- **Data Cleanup**: Automatic sensitive data removal

#### Compliance Features
- **HIPAA Compliance**: Healthcare data protection standards
- **Audit Logging**: Complete user activity tracking
- **Data Retention**: Configurable data lifecycle management
- **Export Controls**: Secure data transfer mechanisms

**Section sources**
- [pubspec.yaml:50-150](file://pubspec.yaml#L50-L150)
- [android/app/build.gradle.kts:50-100](file://android/app/build.gradle.kts#L50-L100)

## Troubleshooting

### Common Installation Issues

#### Flutter SDK Problems
- **Issue**: Flutter commands not recognized
  - **Solution**: Add Flutter to system PATH variable
  - **Verification**: Run `flutter doctor` to check environment

- **Issue**: Dependency conflicts
  - **Solution**: Clear cache and reinstall dependencies
  - **Commands**: `flutter clean && flutter pub get`

#### Platform-Specific Issues

**Android Build Failures**
- Check Android SDK version compatibility
- Verify Gradle wrapper configuration
- Ensure sufficient build memory allocation

**Web Build Problems**
- Clear browser cache and service workers
- Check CORS configuration for local development
- Verify asset bundling for production builds

**Windows Build Errors**
- Install required Windows SDK components
- Check Visual Studio workload installation
- Verify CMake configuration

### Application Performance Issues

#### Slow Loading Times
- Clear application cache
- Disable unnecessary background services
- Check device storage availability

#### Memory Leaks
- Monitor heap usage during development
- Implement proper resource cleanup
- Use Flutter DevTools for profiling

#### Calculation Accuracy
- Verify unit conversions and constants
- Check reference range configurations
- Validate algorithm implementations

### Support Resources

#### Documentation
- Official user manual and guides
- API documentation for developers
- Troubleshooting FAQ and solutions

#### Community Support
- GitHub issue tracker for bug reports
- Community forums and discussion boards
- Professional medical advisory board contact

#### Emergency Support
- 24/7 technical support hotline
- Priority response for institutional deployments
- On-site support for large organizations

**Section sources**
- [docs/wiki/Installation.md:100-200](file://docs/wiki/Installation.md#L100-L200)

## Development Setup

### Environment Configuration

#### Prerequisites Installation

1. **Flutter SDK Setup**
   ```bash
   # Download and extract Flutter SDK
   # Add to PATH and verify installation
   flutter --version
   flutter doctor
   ```

2. **IDE Configuration**
   - Install Flutter and Dart plugins for VS Code or Android Studio
   - Configure code formatting and analysis options
   - Set up debugging and hot reload capabilities

3. **Platform-Specific Setup**
   - **Android**: Install Android SDK, emulator, and signing certificates
   - **iOS**: Install Xcode and iOS simulator (if needed)
   - **Web**: Configure web development server and testing
   - **Windows**: Install Windows SDK and MSBuild tools

### Project Structure Overview

```
emtools/
├── lib/                    # Main application source code
│   ├── core/              # Core business logic
│   ├── data/              # Data models and repositories
│   ├── domain/            # Domain entities and use cases
│   ├── presentation/      # UI components and screens
│   └── main.dart          # Application entry point
├── android/               # Android platform configuration
├── ios/                   # iOS platform configuration  
├── web/                   # Web platform configuration
├── windows/               # Windows platform configuration
├── test/                  # Unit and widget tests
└── docs/                  # Documentation and wiki
```

### Development Workflow

#### Local Development
1. **Start Development Server**
   ```bash
   flutter run -d chrome    # Web development
   flutter run -d windows   # Windows development
   flutter run              # Android development
   ```

2. **Hot Reload and Debugging**
   - Use Flutter DevTools for performance profiling
   - Enable verbose logging for troubleshooting
   - Test across multiple device configurations

3. **Testing Strategy**
   - Unit tests for business logic
   - Widget tests for UI components
   - Integration tests for complete workflows
   - Performance regression testing

#### Build and Deployment

**Production Builds**
```bash
# Android Release Build
flutter build apk --release --split-per-abi

# Web Production Build
flutter build web --release --base-href /emtools/

# Windows Release Build
flutter build windows --release
```

**Code Quality and Analysis**
```bash
# Static Analysis
flutter analyze

# Code Formatting
dart format .

# Generate Documentation
dart doc
```

### Contributing Guidelines

#### Code Standards
- Follow Flutter and Dart style guidelines
- Implement comprehensive error handling
- Write meaningful commit messages
- Include unit tests for new features

#### Pull Request Process
1. Create feature branch from main
2. Implement changes with appropriate tests
3. Run full test suite and static analysis
4. Submit pull request with detailed description
5. Address review feedback and merge

#### Release Process
1. Update version numbers and changelog
2. Run comprehensive testing across platforms
3. Generate platform-specific builds
4. Publish to respective app stores
5. Update documentation and release notes

**Section sources**
- [pubspec.yaml:1-200](file://pubspec.yaml#L1-L200)
- [android/app/build.gradle.kts:1-100](file://android/app/build.gradle.kts#L1-L100)
- [windows/CMakeLists.txt:1-50](file://windows/CMakeLists.txt#L1-L50)