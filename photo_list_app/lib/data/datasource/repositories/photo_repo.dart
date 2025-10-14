import 'package:photo_list_app/data/datasource/models/photo_model.dart';

abstract class PhotoRepo {
  // Fetch Photos - refresh true == force fetching from API
  Future<List<Photo>> fetchPhotos({bool refresh = false});
}
