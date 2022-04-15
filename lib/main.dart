import 'package:flutter/material.dart';

import 'data/repository_impl.dart';
import 'presentation/home_screen.dart';
import 'presentation/repository_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      repository: DummyRepositoryImpl(),
      child: MaterialApp(
        title: 'Rental App',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          backgroundColor: Colors.white,
          primarySwatch: Colors.blue,
          inputDecorationTheme: InputDecorationTheme(
            fillColor: Colors.grey[100],
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: false,
            toolbarTextStyle: _titleTextStyle,
            titleTextStyle: _titleTextStyle,
          ),
        ),
        home: const MyHomePage(),
      ),
    );
  }

  TextStyle get _titleTextStyle {
    return const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Color(0xff333333),
    );
  }
}
