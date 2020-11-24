import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo_list_app/db/database.dart';
import 'package:todo_list_app/screens/home_screen.dart';
import 'package:intl/intl.dart';

import 'generated/l10n.dart';

MyDatabase database;


void main() {
  database = MyDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],

      supportedLocales: [
        const Locale("en"),
        const Locale("ja"),
      ],

      title: "私だけのTODOアプリ",
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}
