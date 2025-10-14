import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:photo_list_app/data/models/photo_model.dart';

class PhotoDetailScreen extends StatelessWidget {
  final Photo photo;

  const PhotoDetailScreen({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Photo Details")),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 100),
        children: [
          CachedNetworkImage(
            fadeInDuration: Duration.zero,
            fadeOutDuration: Duration.zero,
            imageUrl: photo.url,
            width: double.infinity, // fill width
            fit: BoxFit.fitWidth, // maintain aspect ratio
            placeholder: (context, url) => const SizedBox(
              height: 200,
              child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
            ),
            errorWidget: (context, url, error) =>
                const Icon(Icons.broken_image, size: 60, color: Colors.grey),
          ),
          ListTile(
            leading: Text(
              "Details",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
                color: Colors.grey[700],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Divider(height: 1, thickness: 1, color: Colors.grey[300]),
          ),
          ListTile(
            leading: Text(
              "Location",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
                color: const Color.fromARGB(255, 72, 56, 56),
              ),
            ),
            trailing: Text(
              photo.location,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Divider(height: 1, thickness: 1, color: Colors.grey[300]),
          ),
          ListTile(
            leading: Text(
              "Created By",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
                color: Colors.grey[700],
              ),
            ),
            trailing: Text(
              photo.createdBy,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Divider(height: 1, thickness: 1, color: Colors.grey[300]),
          ),
          ListTile(
            leading: Text(
              "Taken At",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
                color: Colors.grey[700],
              ),
            ),
            trailing: Text(
              DateFormat('yyyy-MM-dd, HH:mm').format(photo.takenAt),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Divider(height: 1, thickness: 1, color: Colors.grey[300]),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  "Description",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                child: Text(
                  photo.description,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
