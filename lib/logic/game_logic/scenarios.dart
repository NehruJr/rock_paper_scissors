String getTheGameResult(String playerMove , String computerMove){
  if (playerMove == computerMove) {
    return "Tie";
  } else if (playerMove == "Rock" && computerMove == "Scissors") {
    return "You Win";
  } else if (playerMove == "Scissors" && computerMove == "Paper") {
    return "You Win";
  } else if (playerMove == "Paper" && computerMove == "Rock") {
    return "You Win";
  } else if (computerMove == "Rock" && playerMove == "Scissors") {
    return "Computer Wins";
  } else if (computerMove == "Scissors" && playerMove == "Paper") {
    return "Computer Wins";
  } else if (computerMove == "Paper" && playerMove == "Rock") {
    return "Computer Wins";
  }else {
    return "Check your picture";
  }
}