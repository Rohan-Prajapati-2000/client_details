import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FullImageViewer extends StatelessWidget{
  FullImageViewer({super.key, required this.imageURL});

  final String imageURL;


  @override
  Widget build(BuildContext context) {
    Uint8List imageBytes = base64Decode(imageURL);
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice'),
      ),
      body: Center(
        child: Image.memory(imageBytes),
      ),
    );
  }

}