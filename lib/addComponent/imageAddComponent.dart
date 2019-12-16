import 'package:flutter/material.dart';
import 'package:jas_survey/emptyState.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class ImageAddComponent extends StatefulWidget {
  List<Asset> imgList;
  final Function setImgList, getImgList;

  ImageAddComponent({@required this.imgList, @required this.setImgList, @required this.getImgList});

  @override
  _ImageAddComponentState createState() => _ImageAddComponentState();
}

class _ImageAddComponentState extends State<ImageAddComponent> {
  @override
  void initState() {
    super.initState();
    setState(() {
      widget.imgList = widget.getImgList();
    });
  }

  Widget buildGridView() {
    return GridView.count(
      padding: EdgeInsets.all(3.0),
      crossAxisCount: 3,
      children: List.generate(widget.imgList.length, (index) {
        // print(widget.imgList[index]);
        Asset asset = widget.imgList[index];
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
      widget.imgList = List<Asset>();
    });

    List<Asset> resultList;

    try {
      resultList = await MultiImagePicker.pickImages(
        enableCamera: true,
        maxImages: 10,
      );
    } on NoImagesSelectedException catch (e) {
      print(e);
      Navigator.pop(context);
      // setState(() {
      //   widget.imgList = widget.getImgList();
      // });
    } on Exception catch (e) {
      print(e);
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      // imageList = resultList;
      widget.imgList = resultList;
    });

  }

  @override
  Widget build(BuildContext context) {
    // widget.imgList == null ?
    // print("total image = 0"):print("total image"+widget.imgList.length.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker'),
        centerTitle: false,
        elevation: 0,
        // backgroundColor: Theme.of(context).accentColor,
        actions: <Widget>[
          MaterialButton(
            key: Key('saveCompBtn'),
            child: Text(
              "SAVE",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              await widget.setImgList(widget.imgList);
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(3.0),
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.76,
                child: widget.imgList == null || widget.imgList.length == 0
                    ? Center(
                        child: EmptyState(
                          title: "Oops..!!",
                          message: "Belum ada image yang diambil..!!",
                        ),
                      )
                    : Container(child: buildGridView()),
              ),

              //FOR DISPLAY ADD IMAGE BUTTON
              Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  padding: EdgeInsets.only(
                      left: 15.0,
                      right: 15.0,
                      bottom: MediaQuery.of(context).size.height * 0.005),
                  child: MaterialButton(
                    key: Key('btnToImagePicker'),
                    height: MediaQuery.of(context).size.height * 0.07,
                    color: Theme.of(context).accentColor,
                    minWidth: double.infinity,
                    child: Text(
                      'Add Image',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 17.0),
                    ),
                    onPressed: loadAssets,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
