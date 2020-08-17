import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:sudoku_app/language.dart';
import 'package:sudoku_app/sudoku_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Box _sudokuKutusu;

  Future<Box> _kutuac() async {
    _sudokuKutusu = await Hive.openBox('sudoku');
    return await Hive.openBox('tamamlanan_sudokular');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lang['giris_title']),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Box kutu = Hive.box('ayarlar');
              kutu.put(
                'karanlik_tema',
                !kutu.get('karanlik_tema', defaultValue: false),
              );
            },
          ),
          PopupMenuButton(
            icon: Icon(Icons.add),
            onSelected: (deger) {
              if (_sudokuKutusu.isOpen) {
                _sudokuKutusu.put('seviye', deger);
              }
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => SudokuPage()));
            },
            itemBuilder: (context) => <PopupMenuEntry>[
              PopupMenuItem(
                value: lang['seviye_secin'],
                child: Text(lang['seviye_secin'],
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyText1.color),),
                enabled: false,
              ),
              for( String k in sudokuSeviyeleri.keys)
              PopupMenuItem(
                value: k,
                child: Text(k),
              ),
            ],
          ),
        ],
      ),
      body: FutureBuilder<Box>(
        future: _kutuac(),
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (snapshot.data.length == 0)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Henüz herhangi bir sudoku çözmediniz.",
                        style: GoogleFonts.chelseaMarket(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  for (var eleman in snapshot.data.values)
                    Center(
                      child: Text("$eleman"),
                    ),
                ],
              ),
            );
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
