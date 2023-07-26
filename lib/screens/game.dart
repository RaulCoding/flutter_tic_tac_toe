// ignore_for_file: unrelated_type_equality_checks, prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool oTurn = true;
  List<String> displayXO = ['', '', '', '', '', '', '', '', ''];
  List<int> matchedIndexes = [];
  int attempts = 0;
  
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  String resultDeclaration = '';
  bool winnerFound = false;
  
  
  static const maxSeconds = 30;
  int seconds = maxSeconds;
  Timer? timer;

  static var customFontWhite = GoogleFonts.coiny(
    textStyle:const TextStyle(color: Colors.white, letterSpacing: 3, fontSize: 28),
  );
  
  void startTimer(){
    timer = Timer.periodic(const Duration(seconds: 1), (_) { 
      setState(() {
        if(seconds > 0){
          seconds --;
        } else{
          stopTimer();
        }
      });
    });
  }
  
  void stopTimer(){
    resetTimer();
    timer?.cancel();
  }
  
  void resetTimer()=> seconds = maxSeconds;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Player 0',style: customFontWhite,),
                      Text(oScore.toString(),style: customFontWhite,),
                    ],
                  ),
                  const SizedBox(width: 30),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Player X',style: customFontWhite,),
                      Text(xScore.toString(),style: customFontWhite,),
                    ],
                  )
                ],
              )
            ),
            Expanded(
              flex: 3,
              child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        _tapped(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              width: 5,
                              color: MainColor.primaryColor,
                            ),
                            color: matchedIndexes.contains(index) ? MainColor.accentColor : MainColor.secondaryColor),
                        child: Center(
                          child: Text(
                            displayXO[index],
                            style: GoogleFonts.coiny(
                                textStyle: TextStyle(fontSize: 64, color: MainColor.primaryColor)),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      resultDeclaration, 
                      style: customFontWhite
                    ),
                    const SizedBox(height: 10),
                    _buildTimer()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _tapped(int index) {
    final isRunning = timer == null ? false : timer!.isActive;
    
    if(isRunning){
      setState(() {
        if (oTurn && displayXO[index] == '') {
          displayXO[index] = '0';
          filledBoxes++;
        } else if (!oTurn && displayXO[index] == '') {
          displayXO[index] = 'X';
          filledBoxes++;
        }
  
        oTurn = !oTurn;
        _checkwinner();
      });
    }
  }

  void _checkwinner() {
    //Comprueba la primera fila
    if (displayXO[0] == displayXO[1] && 
        displayXO[0] == displayXO[2] && 
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Gana el jugador' + ' '  + displayXO[0];
        matchedIndexes.addAll([0,1,2]);
        stopTimer();
        _updateScore(displayXO[0]);
      });
    }
    
    //Comprueba la segunda fila
    if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] && 
        displayXO[3] != '') {
      setState(() {
        resultDeclaration = 'Gana el jugador' + ' '  + displayXO[3];
        matchedIndexes.addAll([3,4,5]);
        stopTimer();
        _updateScore(displayXO[3]);
      });
    }
    //Comprueba la tercera fila
    if (displayXO[6] == displayXO[7] && 
        displayXO[6] == displayXO[8] && 
        displayXO[6] != '') {
      setState(() {
        resultDeclaration = 'Gana el jugador' + ' '  + displayXO[6];
        matchedIndexes.addAll([6,7,8]);
        stopTimer();
        _updateScore(displayXO[6]);
      });
    }
    //Comprueba la primera columna
    if (displayXO[0] == displayXO[3] && 
        displayXO[0] == displayXO[6] && 
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Gana el jugador' + ' '  + displayXO[0];
        matchedIndexes.addAll([0,3,6]);
        stopTimer();
        _updateScore(displayXO[0]);
      });
    }
    //Comprueba la segunda columna
    if (displayXO[1] == displayXO[4] && 
        displayXO[1] == displayXO[7] && 
        displayXO[1] != '') {
      setState(() {
        resultDeclaration = 'Gana el jugador' + ' '  + displayXO[1];
        matchedIndexes.addAll([1,4,7]);
        stopTimer();
        _updateScore(displayXO[1]);
      });
    }
    //Comprueba la tercera columna
    if (displayXO[2] == displayXO[5] && 
        displayXO[2] == displayXO[8] && 
        displayXO[2] != '') {
      setState(() {
        resultDeclaration = 'Gana el jugador' + ' '  + displayXO[2];
        matchedIndexes.addAll([2,5,8]);
        stopTimer();
        _updateScore(displayXO[2]);
      });
    }
    //Comprueba la diagonal izquierda
    if (displayXO[0] == displayXO[4] && 
        displayXO[0] == displayXO[8] && 
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Gana el jugador' + ' ' + displayXO[0];
        matchedIndexes.addAll([0,4,8]);
        stopTimer();
        _updateScore(displayXO[0]);
      });
    }
    //Comprueba la diagonal derecha
    if (displayXO[2] == displayXO[4] && 
        displayXO[2] == displayXO[6] && 
        displayXO[2] != '') {
      setState(() {
        resultDeclaration = 'Gana el jugador' + ' ' + displayXO[2];
        matchedIndexes.addAll([2,4,6]);
        stopTimer();
        _updateScore(displayXO[2]);
      });
    }
    else if(!winnerFound && filledBoxes == 9) {
      setState(() {
        resultDeclaration = 'Empate';
        stopTimer();
      });
    }
  }
  
  
  
  void _updateScore(String winner){
    if (winner == '0'){
      oScore++;
    } else if( winner == 'X') {
      xScore++;
    }
    winnerFound = true;
  }
  
  void _clearBoard(){
    setState(() {
      for(int i = 0; i < 9; i++){
        displayXO[i] = '';
      }
      resultDeclaration = '';
    });
    filledBoxes = 0;
    matchedIndexes = [];
  }
  
  Widget _buildTimer(){
    final isRunning = timer == null ? false : timer!.isActive;
    
    return isRunning 
      ? SizedBox(
        width: 100,
        height: 100,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              value: 1 - seconds / maxSeconds,
              valueColor: const AlwaysStoppedAnimation(Colors.white),
              strokeWidth: 8,
              backgroundColor: MainColor.accentColor ,
            ),
            Center(child: Text('$seconds', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize:50),),)
          ]
        ),
      )
      : ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: 32, 
            vertical: 16
          )
        ),
        onPressed: () {
          startTimer();
          _clearBoard();
          attempts++;
        },
        child: Text(
          attempts == 0 ? 'Comenzar' : '¡Otra Partida!', 
          style: const TextStyle(fontSize: 20, color: Colors.black),),
      );
  }
}
