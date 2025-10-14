import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:photo_list_app/business/service/photo_service.dart';
import 'package:photo_list_app/business/cubit/cubit/photo_cubit.dart';
import 'package:photo_list_app/data/datasource/models/photo_model.dart';
import 'package:photo_list_app/data/datasource/repositories/photo_repo_Impl.dart';
import 'package:photo_list_app/presentation/screen/photo_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Init database
  await Hive.initFlutter();
  Hive.registerAdapter(PhotoAdapter());
  await Hive.openBox<Photo>('photos');

  final photoRepo = PhotoRepoImpl();
  final photoService = PhotoService(photoRepo);

  runApp(MainApp(photoService: photoService));
}

class MainApp extends StatelessWidget {
  final PhotoService photoService;

  const MainApp({super.key, required this.photoService});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhotoCubit(photoService),
      child: const MaterialApp(home: PhotoListScreen()),
    );
  }
}
