import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sudoku_app/language.dart';
import 'sudokus.dart';

final Map<String, int> sudokuSeviyeleri = {
  lang['seviye1']: 62,
  lang['seviye2']: 53,
  lang['seviye3']: 44,
  lang['seviye4']: 35,
  lang['seviye5']: 26,
  lang['seviye6']: 17,
};

class SudokuPage extends StatefulWidget {
  @override
  _SudokuPageState createState() => _SudokuPageState();
}

class _SudokuPageState extends State<SudokuPage> {

  /// final List ornekSudoku = List.generate(9, (i) => List.generate(9, (j) => j));

  final List ornekSudoku = [
    [1, 2, 3, 4, 5, 6, 7, 8, 9],
    [2, 3, 4, 5, 6, 7, 8, 9, 1],
    [3, 4, 5, 6, 7, 8, 9, 1, 2],
    [4, 5, 6, 7, 8, 9, 1, 2, 3],
    [5, 6, 7, 8, 9, 1, 2, 3, 4],
    [6, 7, 8, 9, 1, 2, 3, 4, 5],
    [7, 8, 9, 1, 2, 3, 4, 5, 6],
    [8, 9, 1, 2, 3, 4, 5, 6, 7],
    [9, 1, 2, 3, 4, 5, 6, 7, 8],
  ];

  final Box _sudokuBox = Hive.box('sudoku');

  List _sudoku = [];
  String _sudokuString;

  void _createSudoku() {
    int willBeShown = sudokuSeviyeleri[_sudokuBox.get('seviye', defaultValue: lang['seviye2'])];

    _sudokuString = sudokus[Random().nextInt(sudokus.length)];

    _sudoku = List.generate(9, (i) => List.generate(9, (j) => int.tryParse(_sudokuString.substring(i*9, (i + 1) * 9).split('')[j])));

    int i = 0;
    while (i < 81 - willBeShown) {
      int x = Random().nextInt(9);
      int y = Random().nextInt(9);
      if (_sudoku[x][y] != 0) {
        _sudoku[x][y] = 0;
        i++;
      }
    }

    setState(() {

    });
    print(willBeShown);
    print(_sudokuString);
  }



  @override
  void initState() {
    _createSudoku();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(lang['sudoku_title']),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh), onPressed: _createSudoku),
          ],
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text(
                _sudokuBox.get('seviye', defaultValue: lang['seviye2']),
              ),
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  color: Colors.amber,
                  padding: EdgeInsets.all(2.0),
                  margin: EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      for (int x = 0; x < 9; x++)
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    for (int y = 0; y < 9; y++)
                                      Expanded(
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                margin: EdgeInsets.all(1.0),
                                                color: Colors.grey,
                                                alignment: Alignment.center,
                                                child: Text(_sudoku[x][y] > 0 ?_sudoku[x][y].toString() : "",
                                                    ),
                                              ),
                                            ),
                                            if (y == 2 || y == 5)
                                              SizedBox(width: 3,),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              if (x == 2 || x == 5)
                                SizedBox(height: 3,)
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8,),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Card(
                                    child: Container(
                                      margin: EdgeInsets.all(3.0),
                                      color: Colors.amber,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Card(
                                    child: Container(
                                      margin: EdgeInsets.all(3.0),
                                      color: Colors.amber,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Card(
                                    child: Container(
                                      margin: EdgeInsets.all(3.0),
                                      color: Colors.amber,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Card(
                                    child: Container(
                                      margin: EdgeInsets.all(3.0),
                                      color: Colors.amber,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          for (int i = 1; i < 10; i+=3)
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                for (int j = 0; j < 3; j++)
                                Expanded(
                                  child: Card(
                                    color: Colors.amber,
                                    shape: CircleBorder(),
                                    child: InkWell(
                                      onTap: () {
                                        print("${i+j}");
                                      },
                                      child: Container(
                                        margin: EdgeInsets.all(3.0),
                                        child: Text("${i+j}", style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),),
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
