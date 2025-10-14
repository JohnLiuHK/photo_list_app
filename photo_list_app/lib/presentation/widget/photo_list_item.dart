import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:photo_list_app/data/datasource/models/photo_model.dart';

class PhotoListItem extends StatelessWidget {
  final VoidCallback onPressed;

  const PhotoListItem({
    super.key,
    required this.photo,
    required this.onPressed,
  });

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: CachedNetworkImage(
          fadeInDuration: Duration.zero,
          fadeOutDuration: Duration.zero,
          imageUrl: photo.url,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
          placeholder: (context, url) => const SizedBox(
            width: 60,
            height: 60,
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          ),
          errorWidget: (context, url, error) =>
              const Icon(Icons.broken_image, size: 60, color: Colors.grey),
        ),
      ),
      title: Text(photo.location, style: TextStyle(fontSize: 17)),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        size: 16,
        color: Colors.grey,
      ),
      onTap: onPressed,
    );
  }
}
