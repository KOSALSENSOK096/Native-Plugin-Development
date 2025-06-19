import 'dart:async';
import 'package:flutter/services.dart';

class FlutterIpPlugin {
  static const MethodChannel _channel = MethodChannel('flutter_ip_plugin');
  static String? _cachedIp;

  /// Gets the device's IP address.
  /// [useWifi] determines whether to get the WiFi IP (true) or mobile data IP (false).
  /// Returns "No internet connection" if no connection is available.
  static Future<String> getIp({bool useWifi = true}) async {
    try {
      final ip = await _channel.invokeMethod<String>('getIp', {"useWifi": useWifi});
      return ip ?? "No internet connection";
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        return "Permission denied";
      }
      return "Error: ${e.message}";
    }
  }

  /// Gets the cached IP address if available, otherwise fetches a new one.
  /// [useWifi] determines whether to get the WiFi IP (true) or mobile data IP (false).
  static Future<String> getCachedIp({bool useWifi = true}) async {
    if (_cachedIp != null) return _cachedIp!;
    _cachedIp = await getIp(useWifi: useWifi);
    return _cachedIp!;
  }

  /// Clears the cached IP address.
  static void clearCache() {
    _cachedIp = null;
  }
} 