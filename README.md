# Native Plugin Development 🔌

<div align="center">

![Flutter Version](https://img.shields.io/badge/Flutter-%3E%3D3.0.0-blue.svg)
![Dart Version](https://img.shields.io/badge/Dart-%3E%3D3.0.0-blue.svg)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-orange.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)
[![GitHub stars](https://img.shields.io/github/stars/KOSALSENSOK096/Native-Plugin-Development?style=social)](https://github.com/KOSALSENSOK096/Native-Plugin-Development/stargazers)

<p align="center">
  <img src="https://raw.githubusercontent.com/KOSALSENSOK096/Native-Plugin-Development/main/assets/plugin_logo.png" alt="Plugin Logo" width="200"/>
</p>

A powerful Flutter plugin for retrieving device IP addresses with native implementation for both iOS and Android platforms.

[Features](#-features) •
[Getting Started](#-getting-started) •
[Installation](#-installation) •
[Usage](#-usage) •
[Examples](#-examples) •
[API Reference](#-api-reference) •
[Contributing](#-contributing)

---

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
- IPv4 and IPv6 support

🚀 **Performance**
- Built-in caching mechanism
- Minimal memory footprint
- Fast response times
- Background thread processing

🛡️ **Reliability**
- Comprehensive error handling
- Fallback mechanisms
- Type-safe API
- Extensive testing

## 🚀 Getting Started

### Prerequisites

- Flutter SDK ≥ 3.0.0
- Dart SDK ≥ 3.0.0
- iOS: Xcode ≥ 12.0
- Android: Android Studio with Kotlin support

### Development Environment Setup

1. **Flutter Setup**
   ```bash
   flutter doctor -v
   ```
   Ensure all checkmarks are green

2. **Platform Setup**
   - iOS: Install Xcode and CocoaPods
   - Android: Install Android Studio and SDK

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

### Advanced Usage

```dart
// Using cache with custom configuration
class NetworkManager {
  final FlutterIpPlugin _ipPlugin = FlutterIpPlugin();
  
  Future<String> getOptimizedIpAddress() async {
    try {
      // Try cached IP first
      String ip = await FlutterIpPlugin.getCachedIp();
      
      // Refresh cache if needed
      if (shouldRefreshCache()) {
        FlutterIpPlugin.clearCache();
        ip = await FlutterIpPlugin.getIp();
      }
      
      return ip;
    } catch (e) {
      return 'Error: $e';
    }
  }
}
```

## 📱 Examples

### Example 1: Basic IP Retrieval

```dart
import 'package:flutter/material.dart';
import 'package:flutter_ip_plugin/flutter_ip_plugin.dart';

class IpDisplayWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: FlutterIpPlugin.getIp(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text('Your IP: ${snapshot.data}');
        }
        return CircularProgressIndicator();
      },
    );
  }
}
```

### Example 2: Network Type Detection

```dart
class NetworkTypeWidget extends StatelessWidget {
  Future<String> getNetworkInfo() async {
    final wifiIp = await FlutterIpPlugin.getIp(useWifi: true);
    final mobileIp = await FlutterIpPlugin.getIp(useWifi: false);
    
    return '''
    WiFi IP: $wifiIp
    Mobile IP: $mobileIp
    ''';
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getNetworkInfo(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!);
        }
        return CircularProgressIndicator();
      },
    );
  }
}
```

## 📚 Documentation

### Error Handling

The plugin provides detailed error messages:

| Error Message | Description | Solution | Example |
|--------------|-------------|----------|---------|
| "No internet connection" | No active network connection | Check device connectivity | Enable WiFi or mobile data |
| "Permission denied" | Missing required permissions | Add permissions to manifest/plist | Add network permissions |
| "Error: [message]" | Other technical errors | Check error message details | Check system logs |
| "Invalid interface" | Network interface not found | Verify network interface availability | Check network settings |

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
- Permission management
- Background thread processing

### iOS Specific

The plugin manages:
- Network interface scanning
- Address family filtering
- Interface name mapping
- Privacy permissions
- Memory management

## 🧪 Testing

### Unit Tests
```bash
flutter test
```

### Integration Tests
```bash
flutter test integration_test
```

Test coverage includes:
- IP address retrieval
- Caching mechanism
- Error scenarios
- Platform-specific behavior
- Network state changes
- Memory management
- Performance benchmarks

## 🔍 Debugging

### Common Issues and Solutions

1. **Permission Errors**
   ```dart
   // Add error handling
   try {
     final ip = await FlutterIpPlugin.getIp();
   } catch (e) {
     if (e.toString().contains('PERMISSION_DENIED')) {
       // Handle permission error
     }
   }
   ```

2. **Network Interface Issues**
   ```dart
   // Check interface availability
   final ip = await FlutterIpPlugin.getIp(useWifi: true);
   if (ip == 'No IP found') {
     // Handle interface unavailable
   }
   ```

## 🤝 Contributing

We welcome contributions! Here's how you can help:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Development Setup

1. Clone the repository
2. Install dependencies
3. Run tests
4. Make your changes
5. Submit a pull request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**KOSAL SENSOK**
- GitHub: [@KOSALSENSOK096](https://github.com/KOSALSENSOK096)
- LinkedIn: [KOSAL SENSOK](https://www.linkedin.com/in/kosalsensok)
- Email: kosalsensok096@gmail.com

## 🙏 Acknowledgments

- Flutter Team for the amazing framework
- Contributors who helped improve this plugin
- The open-source community

## 📈 Project Status

- ✅ Initial Release
- ✅ Basic Functionality
- ✅ Error Handling
- ✅ Documentation
- 🚧 Advanced Features (In Progress)
- 🚧 Performance Optimization (In Progress)
- 📋 More Platform Support (Planned)

## 📞 Support

Need help? Here's how to reach us:

- Create an [Issue](https://github.com/KOSALSENSOK096/Native-Plugin-Development/issues)
- Email: kosalsensok096@gmail.com
- Join our [Discord Community](https://discord.gg/your-discord)

---

<div align="center">
Made with ❤️ by KOSAL SENSOK

⭐️ Star this project if you find it helpful!
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