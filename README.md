# Native Plugin Development 🔌

<div align="center">

![Flutter Version](https://img.shields.io/badge/Flutter-%3E%3D3.0.0-blue.svg)
![Dart Version](https://img.shields.io/badge/Dart-%3E%3D3.0.0-blue.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)
[![GitHub stars](https://img.shields.io/github/stars/KOSALSENSOK096/Native-Plugin-Development?style=social)](https://github.com/KOSALSENSOK096/Native-Plugin-Development/stargazers)

A powerful Flutter plugin for retrieving device IP addresses with native implementation for both iOS and Android platforms.

[Features](#features) •
[Installation](#installation) •
[Usage](#usage) •
[Documentation](#documentation) •
[Contributing](#contributing)

</div>

## ✨ Features

🌟 **Cross-Platform Support**
- Native implementation for iOS and Android
- Consistent API across platforms
- Optimized performance

🔍 **IP Address Detection**
- WiFi IP address retrieval
- Mobile data IP address retrieval
- Automatic network interface detection

🚀 **Performance**
- Built-in caching mechanism
- Minimal memory footprint
- Fast response times

🛡️ **Reliability**
- Comprehensive error handling
- Fallback mechanisms
- Type-safe API

## 📦 Installation

1. Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_ip_plugin:
    git:
      url: https://github.com/KOSALSENSOK096/Native-Plugin-Development.git
      ref: main  # Specify a branch or tag
```

2. Install packages:

```bash
flutter pub get
```

3. Import the package:

```dart
import 'package:flutter_ip_plugin/flutter_ip_plugin.dart';
```

## 🎯 Usage

### Basic Usage

```dart
// Get WiFi IP address
try {
  String wifiIp = await FlutterIpPlugin.getIp(useWifi: true);
  print('WiFi IP: $wifiIp');
} catch (e) {
  print('Error getting WiFi IP: $e');
}

// Get mobile data IP address
try {
  String mobileIp = await FlutterIpPlugin.getIp(useWifi: false);
  print('Mobile IP: $mobileIp');
} catch (e) {
  print('Error getting mobile IP: $e');
}
```

### Using Cache

```dart
// Get cached IP (faster subsequent calls)
String cachedIp = await FlutterIpPlugin.getCachedIp();

// Clear cache when needed
FlutterIpPlugin.clearCache();
```

## 📚 Documentation

### Error Handling

The plugin provides detailed error messages:

| Error Message | Description | Solution |
|--------------|-------------|----------|
| "No internet connection" | No active network connection | Check device connectivity |
| "Permission denied" | Missing required permissions | Add permissions to manifest/plist |
| "Error: [message]" | Other technical errors | Check error message details |

### Required Permissions

#### Android
Add these permissions to your `AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE"/>
<uses-permission android:name="android.permission.INTERNET"/>
```

#### iOS
Add this to your `Info.plist`:

```xml
<key>NSLocalNetworkUsageDescription</key>
<string>This app needs access to network to get IP address</string>
```

## 🔧 Configuration

### Android Specific

The plugin automatically handles:
- WiFi state detection
- Network interface enumeration
- IP address formatting

### iOS Specific

The plugin manages:
- Network interface scanning
- Address family filtering
- Interface name mapping

## 🧪 Testing

Run the included tests:

```bash
flutter test
```

Test coverage includes:
- IP address retrieval
- Caching mechanism
- Error scenarios
- Platform-specific behavior

## 🤝 Contributing

We welcome contributions! Here's how you can help:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**KOSAL SENSOK**
- GitHub: [@KOSALSENSOK096](https://github.com/KOSALSENSOK096)

## 🙏 Acknowledgments

- Flutter Team for the amazing framework
- Contributors who helped improve this plugin
- The open-source community

---

<div align="center">
Made with ❤️ by KOSAL SENSOK
</div>

# flutter_ip_plugin_new

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.