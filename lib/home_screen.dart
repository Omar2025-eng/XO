import 'package:flutter/material.dart';

import 'BoardButton.dart';


class HomeScreen extends StatefulWidget {
  static const String routeName = 'XO game';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> boardState = [
    '', '', '',
    '', '', '',
    '', '', '',
  ];
  int player1Score = 0;
  int player2Score = 0;
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("XO Game"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Scores display
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Player1 (X)",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "$player1Score",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Player2 (O)",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "$player2Score",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Board display
          Expanded(child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BoardButton(text: boardState[0], index: 0, onButtonClick: onButtonAction),
              BoardButton(text: boardState[1], index: 1, onButtonClick: onButtonAction),
              BoardButton(text: boardState[2], index: 2, onButtonClick: onButtonAction),
            ],
          )),
          Expanded(child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BoardButton(text: boardState[3], index: 3, onButtonClick: onButtonAction),
              BoardButton(text: boardState[4], index: 4, onButtonClick: onButtonAction),
              BoardButton(text: boardState[5], index: 5, onButtonClick: onButtonAction),
            ],
          )),
          Expanded(child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BoardButton(text: boardState[6], index: 6, onButtonClick: onButtonAction),
              BoardButton(text: boardState[7], index: 7, onButtonClick: onButtonAction),
              BoardButton(text: boardState[8], index: 8, onButtonClick: onButtonAction),
            ],
          )),
        ],
      ),
    );
  }

  void onButtonAction(int index) {
    if (boardState[index].isNotEmpty) {
      return;
    }
    // Update the board
    setState(() {
      if (counter % 2 == 0) {
        boardState[index] = 'X';
      } else {
        boardState[index] = 'O';
      }
      counter++;
    });

    // Check winner after each move
    if (checkWinner("X")) {
      setState(() {
        player1Score += 5;
        showWinnerDialog("Player 1 (X) Wins!");
        resetBoard();
      });
    } else if (checkWinner("O")) {
      setState(() {
        player2Score += 5;
        showWinnerDialog("Player 2 (O) Wins!");
        resetBoard();
      });
    } else if (counter == 9) {
      showWinnerDialog("It's a Draw!");
      resetBoard();
    }
  }

  void resetBoard() {
    boardState = ['', '', '', '', '', '', '', '', ''];
    counter = 0;
  }

  bool checkWinner(String symbol) {
    for (int i = 0; i < 9; i += 3) {
      if (boardState[i] == symbol && boardState[i + 1] == symbol && boardState[i + 2] == symbol) {
        return true;
      }
    }
    for (int i = 0; i < 3; i++) {
      if (boardState[i] == symbol && boardState[i + 3] == symbol && boardState[i + 6] == symbol) {
        return true;
      }
    }
    if (boardState[0] == symbol && boardState[4] == symbol && boardState[8] == symbol) {
      return true;
    }
    if (boardState[2] == symbol && boardState[4] == symbol && boardState[6] == symbol) {
      return true;
    }
    return false;
  }

  void showWinnerDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Game Over"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}