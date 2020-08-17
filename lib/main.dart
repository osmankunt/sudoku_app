import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:sudoku_app/home_page.dart';
import 'package:sudoku_app/sudoku_page.dart';

void main() async {
  await Hive.initFlutter('sudoku');
  //Box => sql veritabanları tablolara denk gelir
  await Hive.openBox('ayarlar');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box('ayarlar').listenable(keys: ['karanlik_tema', 'lang']),
      builder: (context, kutu, _){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: kutu.get('karanlik_tema', defaultValue: false) ? ThemeData.dark() : ThemeData.light(),
          home: HomePage(),
        );
      }
    );
  }

}
