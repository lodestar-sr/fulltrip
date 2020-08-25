import 'dart:io';

import 'package:Fulltrip/data/models/user.model.dart';
import 'package:Fulltrip/data/providers/auth.provider.dart';
import 'package:Fulltrip/util/constants.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/size_config.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:Fulltrip/widgets/app_loader.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class Documents extends StatefulWidget {
  Documents({Key key}) : super(key: key);

  @override
  _DocumentsState createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> with TickerProviderStateMixin {
  User user;
  AnimationController rotationController;

  @override
  void initState() {
    super.initState();
    user = context.read<AuthProvider>().loggedInUser;
    rotationController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    rotationController.addListener(() {
      setState(() {
        if (rotationController.status == AnimationStatus.completed) {
          rotationController.repeat();
        }
      });
    });
    rotationController.forward(from: 0.0);
  }

  @override
  void dispose() {
    rotationController.dispose();
    super.dispose();
  }

  Future<String> uploadFile(File file, DocType type) async {
    if (file == null) {
      return '';
    }

    DateTime now = DateTime.now();
    String fileName =
        '${now.year}${now.month}${now.day}_${now.hour}${now.minute}${now.second}';

    if (file != null) {
      setState(() => Global.isLoading = true);
      StorageTaskSnapshot snapshot = await Global.storage
          .ref()
          .child('docs/doc_${fileName}')
          .putFile(file)
          .onComplete;
      setState(() => Global.isLoading = false);

      if (snapshot.error == null) {
        String downloadUrl = await snapshot.ref.getDownloadURL();
        switch (type) {
          case DocType.INSURANCE:
            setState(() => user.insuranceDoc = downloadUrl);
            break;
          case DocType.TRANSPORT:
            setState(() => user.transportDoc = downloadUrl);
            break;
          case DocType.KBIS:
            setState(() => user.kbisDoc = downloadUrl);
            break;
          case DocType.IDENTITY:
            setState(() => user.identityDoc = downloadUrl);
            break;
          case DocType.BANK:
            setState(() => user.bankDoc = downloadUrl);
            break;
        }
        setState(() => Global.isLoading = true);
        user.save(context);
        setState(() => Global.isLoading = false);
        return downloadUrl;
      } else {
        print('Error from file repo ${snapshot.error.toString()}');
        return '';
      }
    } else {
      return '';
    }
  }

  onChooseDoc(DocType type) async {
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
                  label: Text("Document"),
                  onPressed: () async {
                    Navigator.of(context, rootNavigator: true).pop();
                    File doc = await FilePicker.getFile();
                    uploadFile(doc, type);
                  },
                  heroTag: UniqueKey(),
                  icon: Icon(Icons.picture_as_pdf),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton.extended(
                  backgroundColor: AppColors.primaryColor,
                  label: Text("Photo"),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    imageModalBottomSheet(context, type);
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
      },
    );
  }

  //Bottom Sheet
  void imageModalBottomSheet(context, DocType type) {
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
                    onPressed: () async {
                      Navigator.of(context, rootNavigator: true).pop();
                      File photo = await getImageFile(ImageSource.camera);
                      uploadFile(photo, type);
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
                    onPressed: () async {
                      Navigator.of(context, rootNavigator: true).pop();
                      File photo = await getImageFile(ImageSource.gallery);
                      uploadFile(photo, type);
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

  Future<File> getImageFile(ImageSource source) async {
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
        return compressedFile;
      } else {
        File compressedFile = await FlutterNativeImage.compressImage(
            selectedImage.path,
            quality: 60,
            percentage: 50);
        return compressedFile;
      }
    }
    return null;
  }

  docSection(DocType type) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 4.0),
            leading: user.getDocStatus(type) == DocStatus.NONE
                ? Icon(Feather.file_text, color: AppColors.primaryColor)
                : (user.getDocStatus(type) == DocStatus.PENDING
                    ? RotationTransition(
                        turns: Tween(begin: 0.0, end: 1.0)
                            .animate(rotationController),
                        child:
                            Icon(Feather.loader, color: AppColors.orangeColor),
                      )
                    : Icon(Feather.check_circle, color: AppColors.greenColor)),
            title: Align(
              alignment: Alignment(-1.2, 0),
              child: user.getDocStatus(type) == DocStatus.NONE
                  ? Text(
                      'Ajouter',
                      style: AppStyles.primaryTextStyle
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                    )
                  : (user.getDocStatus(type) == DocStatus.PENDING
                      ? Text(
                          'Vérification',
                          style: AppStyles.orangeTextStyle,
                        )
                      : Text(
                          'Confirmé',
                          style: AppStyles.greenTextStyle,
                        )),
            ),
            onTap: () {
              if (user.getDocStatus(type) == DocStatus.NONE) {
                onChooseDoc(type);
              } else if (user.getDocStatus(type) == DocStatus.CONFIRMED) {
                onOpenDoc(type);
              }
            },
          ),
        ),
        user.getDocStatus(type) == DocStatus.PENDING
            ? GestureDetector(
                child: Text(
                  'Edit',
                  style: AppStyles.navbarActiveTextStyle
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                onTap: () => onChooseDoc(type),
              )
            : Container(),
      ],
    );
  }

  String url;

  onOpenDoc(DocType type) {}

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ModalProgressHUD(
      inAsyncCall: Global.isLoading,
      color: AppColors.primaryColor,
      progressIndicator: AppLoader(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: AppColors.backButtonColor, //change your color here
          ),
          title: Text('Documents', style: AppStyles.blackTextStyle),
        ),
        body: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return Container(
            width: double.infinity,
            child: SingleChildScrollView(
              child: GestureDetector(
                onTap: () =>
                    FocusScope.of(context).requestFocus(new FocusNode()),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(24, 16, 24, 40),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text:
                                      "Attestation d'assurance en cours de validité sur 2020",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                  children: <TextSpan>[],
                                ),
                              ),
                              docSection(DocType.INSURANCE),
                              Divider(),
                              RichText(
                                text: TextSpan(
                                  text: "Copie des licences de transport",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                  children: <TextSpan>[],
                                ),
                              ),
                              docSection(DocType.TRANSPORT),
                              Divider(),
                              RichText(
                                text: TextSpan(
                                  text: "Extrait Kbis",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                  children: <TextSpan>[],
                                ),
                              ),
                              docSection(DocType.KBIS),
                              Divider(),
                              RichText(
                                text: TextSpan(
                                  text: "Carte nationale d'identité du gérant",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.darkColor,
                                      fontWeight: FontWeight.w500),
                                  children: <TextSpan>[],
                                ),
                              ),
                              docSection(DocType.IDENTITY),
                              Divider(),
                              RichText(
                                text: TextSpan(
                                  text: "Relevé d'identité bancaire",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.darkColor,
                                      fontWeight: FontWeight.w500),
                                  children: <TextSpan>[],
                                ),
                              ),
                              docSection(DocType.BANK),
                              Divider(),
                            ],
                          ),
                        ]),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
