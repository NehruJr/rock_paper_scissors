import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rock_paper_scissors/logic/game_logic/scenarios.dart';
import 'package:rock_paper_scissors/ui/widgets/widgets.dart';
import 'package:tflite/tflite.dart';

import '../constants/custom_colors.dart';
import '../logic/game_logic/computer_moves.dart';
import '../logic/load_data_from_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String computerChoice = '';
  String computerChoiceImg = '';
  final String computerLoading = 'question-mark.gif';
  String userChoice = '';
  String userName = '';
  ImagePicker? imagePicker;
  File? _userImage;
  String classificationResult = '';
  String gameResult = 'Pick Picture to play';

  selectPhotoFromGallery() async {
    XFile? pickedPhoto =
        await imagePicker?.pickImage(source: ImageSource.gallery);
    _userImage = File(pickedPhoto!.path);
    setState(() {
      _userImage;
      doImageClassification();
      computerChoice = getComputerMove().toString();
      computerChoiceImg = computerChoice + '.png';
      gameResult = getTheGameResult(
          classificationResult, computerChoice);
    });
  }

  capturePhotoFromCamera() async {
    XFile? capturedPhoto =
        await imagePicker?.pickImage(source: ImageSource.camera);
    _userImage = File(capturedPhoto!.path);
    setState(() {
      _userImage;
      doImageClassification();
      computerChoice = getComputerMove().toString();
      computerChoiceImg = computerChoice + '.png';
      gameResult = getTheGameResult(
          classificationResult, computerChoice);
    });
  }

  doImageClassification() async {
    var recognitions = await Tflite.runModelOnImage(
        path: _userImage!.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 1,
        threshold: 0.2,
        asynch: true);
    if (kDebugMode) {
      print(recognitions!.length.toString());
    }
    setState(() {
      classificationResult = '';
    });
    for (var element in recognitions!) {
      setState(() {
        if (kDebugMode) {
          print(element.toString());
        }
        classificationResult += element['label'];
      });
    }
  }

  Widget usernameTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Enter Your Name'),
        const SizedBox(
          height: 7,
        ),
        Container(
            width: 250,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            decoration: BoxDecoration(
              border: Border.all(color: CustomColors.customBlue),
              borderRadius: const BorderRadius.all(Radius.circular(6)),
            ),
            child: TextFormField(
              autofocus: true,
              style: const TextStyle(
                fontSize: 18,
                letterSpacing: 2.0,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              cursorColor: Colors.black,
              keyboardType: TextInputType.text,
              onFieldSubmitted: (value) {
                setState(() {
                  userName = value;
                });
              },
            )),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    loadDataFromFile();
    imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Rock Paper Scissor'),
        ),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Visibility(
                  visible: userName.isEmpty ? true : false,
                  child: usernameTextField()),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 75.0),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child:
                            customText(userName.isEmpty ? 'User' : userName)),
                    Expanded(flex: 1, child: customText('Computer')),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Stack(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            TextButton(
                                onPressed: selectPhotoFromGallery,
                                onLongPress: capturePhotoFromCamera,
                                child: Container(
                                  child: _userImage != null
                                      ? Image.file(
                                          _userImage!,
                                          height: 250.0,
                                          fit: BoxFit.cover,
                                        )
                                      : SizedBox(
                                          height: 190.0,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: const [
                                              Icon(
                                                Icons.camera_alt_rounded,
                                                color: Colors.black,
                                              ),
                                              Text(
                                                  'Press to pick picture \nLong press to capture ')
                                            ],
                                          ),
                                        ),
                                )),
                            Center(child: Text(classificationResult)),
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: GameChoiceWidget(
                            playerChoice: computerChoiceImg.isEmpty
                                ? computerLoading
                                : computerChoiceImg,
                          )),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 70),
              customText(
                  gameResult != null ? gameResult : 'Pick Picture to play'),
              const SizedBox(height: 50),
              customButton(
                  onPressed: () {
                    if (kDebugMode) {
                      print(getComputerMove().toString());
                    }

                    setState(() {
                      computerChoice = getComputerMove().toString();
                      computerChoiceImg = computerChoice + '.png';
                      gameResult = getTheGameResult(
                          classificationResult, computerChoice);
                    });
                  },
                  title: 'Play'),
              const SizedBox(
                height: 20,
              ),
              customButton(
                  onPressed: () {
                    setState(() {
                      userName = '';
                      computerChoice = '';
                      computerChoiceImg = '';
                      gameResult = 'Pick Picture to play';
                      userChoice = '';
                      _userImage = null;
                      classificationResult = '';
                    });
                  },
                  title: 'Reset')
            ],
          ),
        ),
      ),
    );
  }
}
