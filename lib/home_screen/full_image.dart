import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'dart:html' as html;

class FullImageViewer extends StatefulWidget {
  FullImageViewer({Key? key, required this.imageList}) : super(key: key);

  final List<String> imageList;

  @override
  _FullImageViewerState createState() => _FullImageViewerState();
}

class _FullImageViewerState extends State<FullImageViewer> {
  int currentIndex = 0;

  void _downloadImage(Uint8List imageBytes) {
    final base64data = base64Encode(imageBytes);
    final anchor = html.AnchorElement(
      href: 'data:image/png;base64,$base64data',
    )
      ..setAttribute('download', 'image_${DateTime.now().millisecondsSinceEpoch}.png')
      ..click();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice'),
      ),
      body: PhotoViewGallery.builder(
        itemCount: widget.imageList.length,
        scrollPhysics: BouncingScrollPhysics(),
        builder: (context, index) {
          Uint8List imageBytes = base64Decode(widget.imageList[index]);
          return PhotoViewGalleryPageOptions(
            imageProvider: MemoryImage(imageBytes),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
        backgroundDecoration: BoxDecoration(color: Colors.black),
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CupertinoColors.activeBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40)
        ),
        onPressed: () {
          Uint8List imageBytes = base64Decode(widget.imageList[currentIndex]);
          _downloadImage(imageBytes);
        },
        child: Icon(Icons.download),
      ),
    );
  }
}
