import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class PredictionScreen extends StatefulWidget {

  String imgurl;

  PredictionScreen({
    key,
    this.imgurl = ''
}):super(key: key);

  static final String id = 'PredicitonScreen';

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {

  bool _isDownloaded = false;
  bool _isLoading = false;

  Future<void> downloadFile(String url, String filename) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Get the app's document directory
        final Uint8List bytes = response.bodyBytes;

        final result = await ImageGallerySaver.saveImage(
          bytes,
          quality: 60,
          name: filename,
        );

        SnackBar snackBar = SnackBar(
          content: Text(
            'Image Downloaded successfully',
            style: TextStyle(fontSize: 16.0),
          ),
          backgroundColor: Colors.teal,
          duration: Duration(seconds: 1),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      } else {
        // Handle error response
        SnackBar snackBar = SnackBar(
          content: Text(
            'Erro while downloading',
            style: TextStyle(fontSize: 16.0),
          ),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 1),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        throw Exception('Failed to download file: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network errors or other exceptions
      print('Error downloading file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Style Image", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        actions: [
          IconButton(onPressed: () async{
            setState(() {
              _isLoading = true;
            });
            await downloadFile(widget.imgurl, 'hairstyle.png');
            setState(() {
              _isLoading = false;
              _isDownloaded = true;
            });
          }, icon: _isLoading ? CircularProgressIndicator(color: Colors.black, backgroundColor: Colors.white,) : _isDownloaded? Icon(Icons.file_download_done, color: Colors.white,): Icon(Icons.file_download, color: Colors.white,)),
        ],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Image.network(widget.imgurl,
          fit: BoxFit.contain,
          height: 400,
          width: 400,
          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              // Image finished loading
              return child;
            } else {
              // Image is still loading
              return CircularProgressIndicator(
                color: Colors.black,
                backgroundColor: Colors.white,
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                    : null,
              );
            }
          },
        ),
      ),
    );
  }
}
