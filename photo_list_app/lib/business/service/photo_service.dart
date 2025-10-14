import 'package:photo_list_app/data/datasource/models/photo_model.dart';
import 'package:photo_list_app/data/datasource/repositories/photo_repo.dart';

class PhotoService {
  final PhotoRepo repo;

  PhotoService(this.repo);

  Future<List<Photo>> loadPhotos({bool refresh = false}) async {
    return repo.fetchPhotos(refresh: refresh);
  }

  List<Photo> searchPhotos({
    required List<Photo> photos,
    required String query,
  }) {
    // Empty check
    if (photos.isEmpty || query.isEmpty) {
      return photos;
    }

    final queryLower = query.toLowerCase();

    return photos.where((photo) {
      return photo.location.toLowerCase().contains(queryLower) ||
          photo.description.toLowerCase().contains(queryLower) ||
          photo.createdBy.toLowerCase().contains(queryLower) ||
          photo.takenAt.toString().toLowerCase().contains(queryLower);
    }).toList();
  }
}
