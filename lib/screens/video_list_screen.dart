import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/video_list_provider.dart';
import '../models/video_item.dart';

class VideoListScreen extends StatefulWidget {
  const VideoListScreen({super.key});

  @override
  State<VideoListScreen> createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  final ScrollController _scrollController = ScrollController();
  late VideoListProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = Provider.of<VideoListProvider>(context, listen: false);
    _scrollController.addListener(_onScroll);
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    await _provider.loadMore();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 500) {
      _provider.loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final itemHeight = screenHeight / 8; // Ensures 8 items per screen

    return Scaffold(
      appBar: AppBar(
        title: const Text('Video List'),
      ),
      body: Consumer<VideoListProvider>(
        builder: (context, provider, child) {
          return RefreshIndicator(
            onRefresh: provider.refresh,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: provider.items.length + (provider.hasMore ? 1 : 0),
              itemExtent: itemHeight,
              cacheExtent: itemHeight * 5, // Cache 5 items ahead
              itemBuilder: (context, index) {
                if (index >= provider.items.length) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final item = provider.items[index];
                return _VideoListItem(
                  item: item,
                  onThumbnailNeeded: () => provider.generateThumbnail(item),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _VideoListItem extends StatefulWidget {
  final VideoItem item;
  final VoidCallback onThumbnailNeeded;

  const _VideoListItem({
    required this.item,
    required this.onThumbnailNeeded,
  });

  @override
  State<_VideoListItem> createState() => _VideoListItemState();
}

class _VideoListItemState extends State<_VideoListItem> {
  @override
  void initState() {
    super.initState();
    widget.onThumbnailNeeded();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 128,
            child: widget.item.thumbnailData != null
                ? Image.memory(
                    widget.item.thumbnailData!,
                    fit: BoxFit.cover,
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.item.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  'Video ID: ${widget.item.id}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 