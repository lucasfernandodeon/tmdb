import 'package:flutter/material.dart';
import 'package:tmdb/core/inject.dart';
import 'package:tmdb/views/movies/movies_list_view.dart';

void main() {
  Inject.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TMDB',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          backgroundColor: Colors.grey,
          primaryColor: Colors.black,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red)),
          appBarTheme: const AppBarTheme(color: Colors.black),
          textTheme: const TextTheme(
              bodyLarge: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
              titleMedium: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
              bodySmall: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 10))),
      home: const MoviesListView(),
    );
  }
}
