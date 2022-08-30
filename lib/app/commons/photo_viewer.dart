import 'package:belove_app/app/global_data/global_key.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoViewer extends StatefulWidget {
  const PhotoViewer(
      {Key? key, required this.galleryItems, required this.selectedIndex})
      : super(key: key);

  final List<String> galleryItems;
  final int selectedIndex;

  @override
  State<PhotoViewer> createState() => _PhotoViewerState();
}

class _PhotoViewerState extends State<PhotoViewer> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.selectedIndex);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(30),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.black.withOpacity(0.9),
          leading: GestureDetector(
              onTap: () {
                navigatorKey.currentState?.pop();
              },
              child: const Icon(Ionicons.close_outline)),
        ),
      ),
      body: PhotoViewGallery.builder(
        scrollPhysics: const BouncingScrollPhysics(),
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(widget.galleryItems[index]),
            initialScale: PhotoViewComputedScale.contained * 0.8,
          );
        },
        itemCount: widget.galleryItems.length,
        pageController: _pageController,
        onPageChanged: (i) {},
      ),
    );
  }
}
