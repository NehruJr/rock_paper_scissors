import 'package:flutter/foundation.dart';
import 'package:tflite/tflite.dart';

loadDataFromFile() async {
  String? output = await Tflite.loadModel(
    model: 'assets/model_unquant.tflite',
    labels: 'assets/labels.txt',
  );
  if (kDebugMode) {
    print(output);
  }
}
