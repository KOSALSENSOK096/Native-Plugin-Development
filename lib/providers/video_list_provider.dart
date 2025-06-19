import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../models/video_item.dart';

class VideoListProvider with ChangeNotifier {
  static const int PAGE_SIZE = 100;
  final List<VideoItem> _items = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _currentPage = 0;

  List<VideoItem> get items => _items;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<void> loadMore() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call with delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      final startIndex = _currentPage * PAGE_SIZE;
      final endIndex = startIndex + PAGE_SIZE;
      
      // Generate dummy items for demonstration
      final newItems = List.generate(
        PAGE_SIZE,
        (index) => VideoItem(
          id: (startIndex + index).toString(),
          title: 'Video ${startIndex + index}',
          videoUrl: 'https://example.com/video${startIndex + index}.mp4',
        ),
      );

      _items.addAll(newItems);
      _currentPage++;
      
      // Stop loading more when we reach 5 million items
      if (_items.length >= 5000000) {
        _hasMore = false;
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    _items.clear();
    _currentPage = 0;
    _hasMore = true;
    notifyListeners();
    await loadMore();
  }

  Future<void> generateThumbnail(VideoItem item) async {
    if (item.thumbnailData != null) return;

    try {
      final thumbnailData = await compute(_generateThumbnailIsolate, item.videoUrl);
      if (thumbnailData != null) {
        item.thumbnailData = thumbnailData;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error generating thumbnail: $e');
    }
  }

  static Future<Uint8List?> _generateThumbnailIsolate(String videoUrl) async {
    try {
      return await VideoThumbnail.thumbnailData(
        video: videoUrl,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 128,
        quality: 75,
      );
    } catch (e) {
      debugPrint('Error in isolate: $e');
      return null;
    }
  }
} 