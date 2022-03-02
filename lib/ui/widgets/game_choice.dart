import 'package:flutter/material.dart';

class GameChoiceWidget extends StatefulWidget {
  const GameChoiceWidget({Key? key, required this.playerChoice}) : super(key: key);
  final String playerChoice;
  @override
  State<GameChoiceWidget> createState() => _GameChoiceWidgetState();
}

class _GameChoiceWidgetState extends State<GameChoiceWidget> {
  @override
  Widget build(BuildContext context) {
    String imageUrl = '';
    setState(() {
        imageUrl = widget.playerChoice;
      });
    return Column(
      children: [
        Image.asset('assets/images/$imageUrl'),
      ],
    );
  }
}
