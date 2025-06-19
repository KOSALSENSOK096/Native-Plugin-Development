import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/video_list_screen.dart';
import 'providers/video_list_provider.dart';
import 'flutter_ip_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VideoListProvider(),
      child: MaterialApp(
        title: 'Video List Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MainScreen(),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String _ipAddress = 'Loading...';

  @override
  void initState() {
    super.initState();
    _loadIpAddress();
  }

  Future<void> _loadIpAddress() async {
    final ip = await FlutterIpPlugin.getIp();
    if (mounted) {
      setState(() {
        _ipAddress = ip;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Video List Demo'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Row(
              children: [
                const Text('Device IP: '),
                Text(_ipAddress),
                const Spacer(),
                TextButton(
                  onPressed: _loadIpAddress,
                  child: const Text('Refresh IP'),
                ),
              ],
            ),
          ),
          const Expanded(
            child: VideoListScreen(),
          ),
        ],
      ),
    );
  }
}
