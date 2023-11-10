

import 'package:flutter/material.dart.';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sizer/sizer.dart';
import '../../data-layer/models/mars_photo.dart';
import '../../data-layer/repo/repo.dart';

class PhotosView extends StatelessWidget {
  final Repo repo = Repo();

  PhotosView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mars Photos'),
      ),
      body: FutureBuilder<List<MarsPhoto>>(
        future: repo.fetchLatestPhotos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<MarsPhoto> photos = snapshot.data!;
            return ListView.builder(
              itemCount: photos.length,
              itemBuilder: (context, index) {
                return Container(
                  color:Theme.of(context).dialogBackgroundColor,
                  width: 400.sp,
                  height: 200.sp,
                  child: Column (
                    children: [
                      Text(photos[index].id.toString()),
                      Text(photos[index].earthDate.toString()),
                      Text(photos[index].camera.toString()),
                      CachedNetworkImage(
                        imageUrl: photos[index].imgSrc,
                        placeholder: (context, url) => const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      )


                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
