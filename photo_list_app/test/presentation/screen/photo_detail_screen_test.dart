import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

import 'package:photo_list_app/data/datasource/models/photo_model.dart';
import 'package:photo_list_app/presentation/screen/photo_detail_screen.dart';

void main() {
  testWidgets('displays correct photo details', (WidgetTester tester) async {
    // Create a mock photo data
    final mockPhoto = Photo(
      id: '1',
      url: 'https://test.com/photo.jpg',
      location: 'Hong Kong',
      createdBy: 'John',
      takenAt: DateTime(2024, 3, 12, 15, 30),
      description: 'Test Description',
      createdAt: DateTime(2024, 3, 12, 15, 30),
    );

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(home: PhotoDetailScreen(photo: mockPhoto)),
    );

    // Check display info
    expect(find.text('Photo Details'), findsOneWidget);
    expect(find.text('Location'), findsOneWidget);
    expect(find.text('Hong Kong'), findsOneWidget);
    expect(find.text('Created By'), findsOneWidget);
    expect(find.text('John'), findsOneWidget);
    expect(find.text('Test Description'), findsOneWidget);

    // Check date format
    final formattedDate = DateFormat(
      'yyyy-MM-dd, HH:mm',
    ).format(mockPhoto.takenAt);
    expect(find.text(formattedDate), findsOneWidget);

    // Verify image URL is passed to CachedNetworkImage
    final imageWidget = tester.widget<CachedNetworkImage>(
      find.byType(CachedNetworkImage),
    );
    expect(imageWidget.imageUrl, equals(mockPhoto.url));
  });
}
