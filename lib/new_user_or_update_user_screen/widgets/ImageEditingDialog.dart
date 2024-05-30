import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practice/utils/popups/loaders.dart';

class EditImagesDialog extends StatefulWidget {
  final List<String> initialImages;
  final String documentId;

  EditImagesDialog({required this.initialImages, required this.documentId});

  @override
  _EditImagesDialogState createState() => _EditImagesDialogState();
}

class _EditImagesDialogState extends State<EditImagesDialog> {
  List<String> imageBase64List = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    imageBase64List = List.from(widget.initialImages);
  }

  Future<void> pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? images = await picker.pickMultiImage();

    if (images != null && images.isNotEmpty) {
      List<String> newImages = await Future.wait(images.map((image) async {
        Uint8List imageBytes = await image.readAsBytes();
        return base64Encode(imageBytes);
      }));
      setState(() {
        imageBase64List.addAll(newImages);
      });
    }
  }

  void removeImage(int index) {
    setState(() {
      imageBase64List.removeAt(index);
    });
  }

  Future<void> saveImages() async {
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseFirestore.instance
          .collection('client_details')
          .doc(widget.documentId)
          .update({
        'Image URL': imageBase64List,
      });
      Navigator.of(context).pop();
    } catch (e) {
      // Handle error
      SLoaders.errorSnackBar(title: 'Error updating images: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Images'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(
            spacing: 10,
            children: imageBase64List.asMap().entries.map((entry) {
              int index = entry.key;
              String imageBase64 = entry.value;
              Uint8List imageBytes = base64Decode(imageBase64);

              return Stack(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: MemoryImage(imageBytes),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: GestureDetector(
                      onTap: () => removeImage(index),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: pickImages,
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(10),
              dashPattern: [6, 3],
              color: Colors.black,
              child: Container(
                height: 100,
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image),
                    Text('Add Images'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        isLoading
            ? CircularProgressIndicator()
            : TextButton(
                onPressed: saveImages,
                child: Text('Save'),
              ),
      ],
    );
  }
}
