import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:photo_list_app/business/cubit/cubit/photo_cubit.dart';
import 'package:photo_list_app/data/models/photo_model.dart';
import 'package:photo_list_app/presentation/screen/photo_list_screen.dart';

class MockPhotoCubit extends Mock implements PhotoCubit {}

class FakePhotoState extends Fake implements PhotoState {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakePhotoState());
  });

  testWidgets('shows loading indicator when state is loading', (tester) async {
    final mockCubit = MockPhotoCubit();

    // Mock state, stream and loadPhotos
    when(
      () => mockCubit.state,
    ).thenReturn(const PhotoState(status: PhotoScreenStatus.isLoading));
    when(() => mockCubit.stream).thenAnswer(
      (_) =>
          Stream.value(const PhotoState(status: PhotoScreenStatus.isLoading)),
    );
    when(() => mockCubit.loadPhotos()).thenAnswer((_) async {});

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<PhotoCubit>.value(
          value: mockCubit,
          child: const PhotoListScreen(),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows list of photos when loaded', (tester) async {
    final mockCubit = MockPhotoCubit();

    final photos = [
      Photo(
        id: "1",
        url: 'https://testing.com/photo1.jpg',
        location: 'Test Location',
        createdBy: 'John',
        takenAt: DateTime.now(),
        description: 'Test Description',
        createdAt: DateTime.now(),
      ),
    ];

    final state = PhotoState(
      status: PhotoScreenStatus.loaded,
      photos: photos,
      filteredPhotos: photos,
    );

    // Mock state, stream and loadPhotos
    when(() => mockCubit.state).thenReturn(state);
    when(() => mockCubit.stream).thenAnswer((_) => Stream.value(state));
    when(() => mockCubit.loadPhotos()).thenAnswer((_) async {});

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<PhotoCubit>.value(
          value: mockCubit,
          child: const PhotoListScreen(),
        ),
      ),
    );

    // Wait for UI fully rendered
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('Test Location'), findsOneWidget);
  });

  testWidgets('shows "No photos available" when list is empty', (tester) async {
    final mockCubit = MockPhotoCubit();

    final emptyState = const PhotoState(
      status: PhotoScreenStatus.loaded,
      photos: [],
      filteredPhotos: [],
    );

    // Mock state, stream and loadPhotos
    when(() => mockCubit.state).thenReturn(emptyState);
    when(() => mockCubit.stream).thenAnswer((_) => Stream.value(emptyState));
    when(() => mockCubit.loadPhotos()).thenAnswer((_) async {});

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<PhotoCubit>.value(
          value: mockCubit,
          child: const PhotoListScreen(),
        ),
      ),
    );

    // Wait for UI fully rendered
    await tester.pumpAndSettle();
    expect(find.text('No photos available'), findsOneWidget);
  });
}
