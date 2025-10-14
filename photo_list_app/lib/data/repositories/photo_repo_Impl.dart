import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:photo_list_app/data/models/photo_model.dart';
import 'package:photo_list_app/data/repositories/photo_repo.dart';

class PhotoRepoImpl implements PhotoRepo {
  late final Box<Photo> _photoBox;
  final Dio _dio = Dio();

  PhotoRepoImpl() {
    _photoBox = Hive.box<Photo>('photos'); // just open the existing box
  }

  @override
  Future<List<Photo>> fetchPhotos({bool refresh = false}) async {
    // Check have cached photos or not && not refreshing
    if (_photoBox.isNotEmpty && !refresh) {
      return _photoBox.values.toList();
    }

    try {
      // Fetch from API
      final response = await _dio.get(
        'https://qchkdevhiring.blob.core.windows.net/mobile/api/photos',
      );
      final List<Photo> photos = (response.data as List)
          .map((photo) => Photo.fromJson(photo))
          .toList();

      // Sort the photos based on their taken time
      photos.sort((a, b) => a.takenAt.compareTo(b.takenAt));

      // Update cache
      await _photoBox.clear();
      await _photoBox.addAll(photos);

      return photos;
    } catch (error) {
      if (_photoBox.isNotEmpty) {
        return _photoBox.values.toList();
      }

      rethrow;
    }
  }
}
