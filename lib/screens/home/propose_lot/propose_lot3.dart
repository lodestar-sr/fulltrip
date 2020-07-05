import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:fulltrip/util/SizeConfig.dart';
import 'package:fulltrip/util/global.dart';
import 'package:fulltrip/util/theme.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProposeLot3 extends StatefulWidget {
  ProposeLot3({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ProposeLot3State();
}

class _ProposeLot3State extends State<ProposeLot3> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController description = TextEditingController();
  TextEditingController prix = TextEditingController();
  File _image;
  File croppedFile;
  File result;
  var image = "";
  bool makeVisible = false;

  getImageFile(ImageSource Source) async {
    var selectedimage = await ImagePicker.pickImage(source: Source);
    print('This is the original image size : ${selectedimage?.lengthSync()}');
    if (selectedimage != null) {
      croppedFile = await ImageCropper.cropImage(
          sourcePath: selectedimage.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: AppColors.primaryColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: false),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          ));

      if (croppedFile != null) {
        File compressedFile = await FlutterNativeImage.compressImage(
            croppedFile.path,
            quality: 88,
            percentage: 80);
        print(compressedFile.lengthSync());
        setState(() {
          _image = compressedFile;
          print("This the Image $_image");
          print("This is the compressed image size :-${_image?.lengthSync()}");
          makeVisible = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ModalProgressHUD(
      inAsyncCall: Global.isLoading,
      color: AppColors.greenColor,
      progressIndicator: CircularProgressIndicator(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: Center(
                  child: Container(
                    child: Text('Précédent',
                        style: AppStyles.greyTextStyle.copyWith(fontSize: 12)),
                  ),
                ),
                onTap: () => Navigator.of(context).pop(),
              ),
              new Text("Proposer un lot",
                  style: TextStyle(fontSize: 17, color: AppColors.darkColor)),
              GestureDetector(
                child: Center(
                  child: Container(
                    margin: EdgeInsets.only(right: 12),
                    child: Text('Fermer',
                        style: AppStyles.greyTextStyle.copyWith(fontSize: 12)),
                  ),
                ),
                onTap: () => {},
              )
            ],
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: LayoutBuilder(builder:
              (BuildContext context, BoxConstraints viewportConstraints) {
            return Form(
              key: _formKey,
              child: Container(
                width: double.infinity,
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight,
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(16, 40, 16, 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            '''Augmentez vos chances d'être sollicité en insérant une photo de votre lot''',
                            style: TextStyle(fontSize: 12),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: new Center(
                              child: new Container(
                                decoration: BoxDecoration(
                                    color: makeVisible
                                        ? Colors.white
                                        : AppColors.whiteColor,
                                    borderRadius: BorderRadius.circular(5)),
                                child: new Material(
                                  child: new InkWell(
                                    onTap: () {
                                      imageModalBottomSheet(context);
                                    },
                                    child: new Container(
                                      height: SizeConfig.safeBlockVertical * 25,
                                      child: makeVisible
                                          ? Container(
                                              child: Stack(
                                              children: [
                                                Image.file(_image),
                                                Positioned(
                                                  right: 0,
                                                  top: 0,
                                                  child: IconButton(
                                                      icon: Icon(Icons.cancel,
                                                          color: AppColors
                                                              .redColor,
                                                          size: 30),
                                                      onPressed: () {
                                                        setState(() {
                                                          makeVisible = false;
                                                        });
                                                      }),
                                                )
                                              ],
                                            ))
                                          : Center(
                                              child: Image.asset(
                                              'assets/images/add_a_photo.png',
                                              height: 25,
                                              width: 25,
                                            )),
                                    ),
                                  ),
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.safeBlockVertical * 2),
                            child: RichText(
                              text: TextSpan(
                                text: "Description",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: AppColors.darkColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: TextFormField(
                              controller: description,
                              maxLines: 5,
                              decoration: InputDecoration(
                                hintText:
                                    '''conditions de chargement, objets spéciaux, piano, coffre-fort, ...''',
                                hintStyle: TextStyle(fontSize: 12),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  borderSide: BorderSide(
                                      color: AppColors.lightGreyColor
                                          .withOpacity(0.5)),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  borderSide: BorderSide(
                                      color: AppColors.lightGreyColor
                                          .withOpacity(0.5)),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.safeBlockVertical * 2),
                            child: RichText(
                              text: TextSpan(
                                text: 'Prix',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: AppColors.darkColor,
                                    fontWeight: FontWeight.w500),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.redColor)),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: TextFormField(
                              controller: prix,
                              validator: (value) {
                                if (value.trim().isEmpty) {
                                  return 'Field Required';
                                }
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  borderSide:
                                      BorderSide(color: AppColors.primaryColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  borderSide:
                                      BorderSide(color: AppColors.primaryColor),
                                ),
                              ),
                            ),
                          ),

                          ///BottomButton
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.safeBlockVertical * 4),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: AppColors.primaryColor
                                          .withOpacity(0.24),
                                      blurRadius: 16,
                                      spreadRadius: 4),
                                ],
                              ),
                              child: ButtonTheme(
                                minWidth: double.infinity,
                                height: 60,
                                child: RaisedButton(
                                  child: Text('Publier le lot',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                  color: AppColors.primaryColor,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      Navigator.of(context)
                                          .pushNamed('Felicitations');
                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  elevation: 0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  //Bottom Sheet
  void imageModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 130.0,
            color: Colors.white,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton.extended(
                    backgroundColor: AppColors.primaryColor,
                    label: Text("Camera"),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                      //image = "";
                      getImageFile(ImageSource.camera);
                    },
                    heroTag: UniqueKey(),
                    icon: Icon(Icons.camera),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton.extended(
                    backgroundColor: AppColors.primaryColor,
                    label: Text("Gallery"),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();

                      getImageFile(ImageSource.gallery);
                    },
                    heroTag: UniqueKey(),
                    icon: Icon(
                      Icons.photo_library,
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
