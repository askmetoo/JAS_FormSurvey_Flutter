import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class ImagePicker extends StatefulWidget {
  @override
  _ImagePickerState createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  List<Asset> images = List<Asset>();
  String _error;

  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: images == null
          ? Text('No image')
          : List.generate(images.length, (index) {
              print('re');
              Asset asset = images[index];
              return Padding(
                padding: EdgeInsets.all(3.0),
                child: AssetThumb(
                  asset: asset,
                  width: 300,
                  height: 300,
                ),
              );
            }),
    );
  }

  Future<void> loadAssets() async {
    setState(() {
      images = List<Asset>();
    });

    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        enableCamera: true,
        maxImages: 300,
      );
    } on Exception catch (e) {
      error = e.toString();
      print(error);
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      if (error == null) _error = 'No Error Dectected';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Image Picker'),
          centerTitle: true,
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            Center(child: Text('Error: $_error')),
            RaisedButton(
              child: Text("Pick images"),
              onPressed: loadAssets,
            ),
            Expanded(
              child: images == null
                  ? Center(
                      child: Text('photo empty'),
                    )
                  : buildGridView(),
            ),
            RaisedButton(
              child: Text('Upload Image'),
              onPressed: (){},
            )
          ],
        )));
  }
}
