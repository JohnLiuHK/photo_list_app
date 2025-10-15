import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:photo_list_app/business/cubit/PhotoCubit/photo_cubit.dart';
import 'package:photo_list_app/presentation/screen/photo_detail_screen.dart';
import 'package:photo_list_app/presentation/widget/photo_list_item.dart';

class PhotoListScreen extends StatefulWidget {
  const PhotoListScreen({super.key});

  @override
  State<PhotoListScreen> createState() => _PhotoListScreenState();
}

class _PhotoListScreenState extends State<PhotoListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PhotoCubit>().loadPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Photos")),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: "Search photos...",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (query) => context.read<PhotoCubit>().search(query),
              ),
            ),

            Expanded(
              child: BlocBuilder<PhotoCubit, PhotoState>(
                builder: (context, state) {
                  if (state.status == PhotoScreenStatus.isLoading ||
                      state.status == PhotoScreenStatus.initial) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<PhotoCubit>().loadPhotos(refresh: true);
                    },
                    child: state.filteredPhotos.isEmpty
                        ? ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: const [
                              const SizedBox(height: 300),
                              const Center(
                                child: Text(
                                  "No photos available",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          )
                        : ListView.separated(
                            itemCount: state.filteredPhotos.length,
                            itemBuilder: (context, index) {
                              final photo = state.filteredPhotos[index];

                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: PhotoListItem(
                                  photo: photo,
                                  onPressed: () {
                                    // Navigate to detail screen
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            PhotoDetailScreen(photo: photo),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 5,
                                ),
                                child: Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Colors.grey[300],
                                ),
                              );
                            },
                          ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
