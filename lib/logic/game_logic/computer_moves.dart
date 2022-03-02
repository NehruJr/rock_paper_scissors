import 'dart:math';

import 'package:rock_paper_scissors/logic/game_logic/game_moves.dart';

String getComputerMove (){
  int randMoveNumber = Random().nextInt(3);
  String computerMove = gameMoves[randMoveNumber];
  return computerMove;
}