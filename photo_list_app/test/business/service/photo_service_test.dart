import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:photo_list_app/business/service/photo_service.dart';
import 'package:photo_list_app/data/datasource/models/photo_model.dart';

class MockPhotoService extends Mock implements PhotoService {}

void main() {
  late MockPhotoService mockService;

  setUp(() {
    mockService = MockPhotoService();
  });

  test('loadPhotos returns a list of photos', () async {
    final photos = [
      Photo(
        id: '1',
        url: 'https://testing.com/1.jpg',
        location: 'Location 1',
        description: 'Description 1',
        createdBy: 'Creator 1',
        takenAt: DateTime.parse('2023-01-01'),
        createdAt: DateTime.parse('2023-01-01'),
      ),
    ];

    when(() => mockService.loadPhotos()).thenAnswer((_) async => photos);

    final result = await mockService.loadPhotos();

    expect(result.length, 1);
    expect(result.first.id, '1');
  });

  test('loadPhotos throws exception when failed', () async {
    when(() => mockService.loadPhotos()).thenThrow(Exception('Failed'));

    expect(() async => await mockService.loadPhotos(), throwsException);
  });
}
