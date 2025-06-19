import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ip_plugin/flutter_ip_plugin.dart';
import 'package:flutter/services.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_ip_plugin');
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      switch (methodCall.method) {
        case 'getIp':
          return '192.168.1.1';
        default:
          return null;
      }
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getIp returns IP address', () async {
    expect(await FlutterIpPlugin.getIp(), '192.168.1.1');
  });

  test('getCachedIp returns cached IP', () async {
    final firstCall = await FlutterIpPlugin.getCachedIp();
    final secondCall = await FlutterIpPlugin.getCachedIp();
    
    expect(firstCall, '192.168.1.1');
    expect(secondCall, '192.168.1.1');
  });

  test('clearCache clears cached IP', () async {
    await FlutterIpPlugin.getCachedIp();
    FlutterIpPlugin.clearCache();
    
    // This should make a new call to native code
    final newCall = await FlutterIpPlugin.getCachedIp();
    expect(newCall, '192.168.1.1');
  });
} 