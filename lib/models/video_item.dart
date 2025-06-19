import 'dart:typed_data';

class VideoItem {
  final String id;
  final String title;
  final String videoUrl;
  final String? thumbnailCacheKey;
  Uint8List? thumbnailData;

  VideoItem({
    required this.id,
    required this.title,
    required this.videoUrl,
    this.thumbnailCacheKey,
    this.thumbnailData,
  });

  factory VideoItem.fromJson(Map<String, dynamic> json) {
    return VideoItem(
      id: json['id'] as String,
      title: json['title'] as String,
      videoUrl: json['videoUrl'] as String,
      thumbnailCacheKey: json['thumbnailCacheKey'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'videoUrl': videoUrl,
      'thumbnailCacheKey': thumbnailCacheKey,
    };
  }
} 