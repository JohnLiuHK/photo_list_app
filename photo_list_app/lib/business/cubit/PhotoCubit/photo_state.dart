part of 'photo_cubit.dart';

enum PhotoScreenStatus { isLoading, loaded, initial }

class PhotoState extends Equatable {
  final PhotoScreenStatus status;
  final List<Photo> photos;
  final List<Photo> filteredPhotos;
  final String? errorMessage;

  const PhotoState({
    this.status = PhotoScreenStatus.initial,
    this.photos = const [],
    this.filteredPhotos = const [],
    this.errorMessage,
  });

  PhotoState copyWith({
    PhotoScreenStatus? status,
    List<Photo>? photos,
    List<Photo>? filteredPhotos,
    String? errorMessage,
  }) {
    return PhotoState(
      status: status ?? this.status,
      photos: photos ?? this.photos,
      filteredPhotos: filteredPhotos ?? this.filteredPhotos,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props {
    return [status, photos, filteredPhotos];
  }
}
