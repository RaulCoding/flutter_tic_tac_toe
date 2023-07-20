// ignore_for_file: unrelated_type_equality_checks, prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

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
  
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  String resultDeclaration = '';
  bool winnerFound = false;

  static var customFontWhite = GoogleFonts.coiny(
    textStyle:const TextStyle(color: Colors.white, letterSpacing: 3, fontSize: 28),
  );

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
              child: Container(
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
                ),
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
                            color: MainColor.secondaryColor),
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
              child: Text(resultDeclaration, style: customFontWhite),
            ),
          ],
        ),
      ),
    );
  }

  void _tapped(int index) {
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

  void _checkwinner() {
    //Comprueba la primera fila
    if (displayXO[0] == displayXO[1] && 
        displayXO[0] == displayXO[2] && 
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Gana el jugador' + ' '  + displayXO[0];
        _updateScore(displayXO[0]);
      });
    }
    
    //Comprueba la segunda fila
    if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] && 
        displayXO[3] != '') {
      setState(() {
        resultDeclaration = 'Gana el jugador' + ' '  + displayXO[3];
        _updateScore(displayXO[3]);
      });
    }
    //Comprueba la tercera fila
    if (displayXO[6] == displayXO[7] && 
        displayXO[6] == displayXO[8] && 
        displayXO[6] != '') {
      setState(() {
        resultDeclaration = 'Gana el jugador' + ' '  + displayXO[6];
        _updateScore(displayXO[6]);
      });
    }
    //Comprueba la primera columna
    if (displayXO[0] == displayXO[3] && 
        displayXO[0] == displayXO[6] && 
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Gana el jugador' + ' '  + displayXO[0];
        _updateScore(displayXO[0]);
      });
    }
    //Comprueba la segunda columna
    if (displayXO[1] == displayXO[4] && 
        displayXO[1] == displayXO[7] && 
        displayXO[1] != '') {
      setState(() {
        resultDeclaration = 'Gana el jugador' + ' '  + displayXO[1];
        _updateScore(displayXO[1]);
      });
    }
    //Comprueba la tercera columna
    if (displayXO[2] == displayXO[5] && 
        displayXO[2] == displayXO[8] && 
        displayXO[2] != '') {
      setState(() {
        resultDeclaration = 'Gana el jugador' + ' '  + displayXO[2];
        _updateScore(displayXO[2]);
      });
    }
    //Comprueba la diagonal izquierda
    if (displayXO[0] == displayXO[4] && 
        displayXO[0] == displayXO[8] && 
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Gana el jugador' + ' ' + displayXO[0];
        _updateScore(displayXO[0]);
      });
    }
    //Comprueba la diagonal derecha
    if (displayXO[2] == displayXO[4] && 
        displayXO[2] == displayXO[6] && 
        displayXO[2] != '') {
      setState(() {
        resultDeclaration = 'Gana el jugador' + ' ' + displayXO[2];
        _updateScore(displayXO[2]);
      });
    }
    if(!winnerFound && filledBoxes == 9) {
      setState(() {
        resultDeclaration = 'Empate';
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
}
