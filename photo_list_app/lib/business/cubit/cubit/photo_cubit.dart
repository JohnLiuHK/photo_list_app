import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:photo_list_app/data/models/photo_model.dart';
import 'package:photo_list_app/business/service/photo_service.dart';

part 'photo_state.dart';

class PhotoCubit extends Cubit<PhotoState> {
  PhotoCubit(this.photoService) : super(PhotoState());

  final PhotoService photoService;

  // Load photos, refresh - force fetching API
  Future<void> loadPhotos({bool refresh = false}) async {
    // Set loading state
    emit(
      state.copyWith(status: PhotoScreenStatus.isLoading, errorMessage: null),
    );
    try {
      final photos = await photoService.loadPhotos(refresh: refresh);
      emit(
        state.copyWith(
          status: PhotoScreenStatus.loaded,
          photos: photos,
          filteredPhotos: photos,
        ),
      );
    } catch (e) {
      if (state.photos.isNotEmpty) {
        // Show cached photos
        emit(
          state.copyWith(
            status: PhotoScreenStatus.loaded,
            errorMessage: "Failed to refresh photos",
          ),
        );
      } else {
        // Show empty list
        emit(
          state.copyWith(
            status: PhotoScreenStatus.loaded,
            photos: [],
            errorMessage: "Failed to load photos",
          ),
        );
      }
    }
  }

  // Search photos
  void search(String query) {
    final filtered = photoService.searchPhotos(
      photos: state.photos,
      query: query,
    );
    emit(state.copyWith(filteredPhotos: filtered));
  }
}
