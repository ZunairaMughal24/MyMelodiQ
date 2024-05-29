class MediaFile {
  final String id;
  final String title;
  final String filePath;
  final MediaType type; // enum: audio, video

  MediaFile({required this.id, required this.title, required this.filePath, required this.type});
}

enum MediaType { audio, video }
