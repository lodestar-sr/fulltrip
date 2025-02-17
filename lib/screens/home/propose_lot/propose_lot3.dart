import 'dart:io';
import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/size_config.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:Fulltrip/util/validators/validators.dart';
import 'package:Fulltrip/widgets/action_buttons/accept_button.dart';
import 'package:Fulltrip/widgets/app_loader.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

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
  bool makeVisible = false;

  @override
  void initState() {
    super.initState();
    description.text = Global.lotForm.description;
    prix.text =
        Global.lotForm.price == null ? '' : Global.lotForm.price.toString();
  }

  getImageFile(ImageSource source) async {
    var selectedImage = await ImagePicker.pickImage(source: source);
    print('This is the original image size : ${selectedImage?.lengthSync()}');
    if (selectedImage != null) {
      File croppedFile = await ImageCropper.cropImage(
          sourcePath: selectedImage.path,
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
            quality: 60,
            percentage: 50);
        setState(() {
          _image = compressedFile;
          makeVisible = true;
        });
      } else {
        File compressedFile = await FlutterNativeImage.compressImage(
            selectedImage.path,
            quality: 60,
            percentage: 50);
        setState(() {
          _image = compressedFile;
          makeVisible = true;
        });
      }
    }
  }

  //Bottom Sheet
  void imageModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 130.0,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton.extended(
                    backgroundColor: AppColors.primaryColor,
                    label: Text("Camera"),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
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

  onSubmit() {
    if (_formKey.currentState.validate()) {
      final form = _formKey.currentState;
      form.save();

      Global.lotForm.date = DateTime.now();

      setState(() => Global.isLoading = true);
      uploadFile().then((downloadURL) async {
        setState(() => Global.isLoading = false);
        if (downloadURL != null) {
          Global.lotForm.photo = downloadURL;
        }

        Navigator.of(context).pushNamed('ProposeLot4');
      });
    }
  }

  Future<String> uploadFile() async {
    DateTime now = DateTime.now();
    String fileName =
        '${now.year}${now.month}${now.day}_${now.hour}${now.minute}${now.second}';

    if (_image != null) {
      StorageTaskSnapshot snapshot = await Global.storage
          .ref()
          .child('lots/image_${fileName}')
          .putFile(_image)
          .onComplete;

      if (snapshot.error == null) {
        String downloadUrl = await snapshot.ref.getDownloadURL();
        return downloadUrl;
      } else {
        print('Error from image repo ${snapshot.error.toString()}');
        return null;
      }
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ModalProgressHUD(
      inAsyncCall: Global.isLoading,
      color: AppColors.primaryColor,
      progressIndicator: AppLoader(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
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
                onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
                    'dashboard', (Route<dynamic> route) => false),
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
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            '''Augmentez vos chances d'être sollicité en insérant une photo de votre lot''',
                            style:
                                AppStyles.blackTextStyle.copyWith(fontSize: 13),
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
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Stack(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    child: Image.file(
                                                      _image,
                                                      width: double.infinity,
                                                      fit: BoxFit.fitWidth,
                                                    ),
                                                  ),
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
                                text: "La description",
                                style: AppStyles.blackTextStyle,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: TextFormField(
                              controller: description,
                              maxLines: 5,
                              onChanged: (value) =>
                                  Global.lotForm.description = value,
                              onSaved: (value) =>
                                  Global.lotForm.description = value,
                              decoration: InputDecoration(
                                hintText:
                                    '''conditions de chargement, objets spéciaux, piano, coffre-fort, ...''',
                                hintStyle: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.safeBlockVertical * 2),
                            child: RichText(
                              text: TextSpan(
                                text: 'Prix',
                                style: AppStyles.blackTextStyle.copyWith(
                                  fontSize: 15,
                                ),
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
                          TextFormField(
                            controller: prix,
                            validator: (val) => Validators.mustNumeric(val),
                            onChanged: (value) =>
                                Global.lotForm.price = double.parse(value),
                            keyboardType: TextInputType.number,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: SizeConfig.safeBlockVertical * 4,
                            ),
                            child: AcceptButton(
                              text: 'Revoir ce lot',
                              onPressed: onSubmit,
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
}
