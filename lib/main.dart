import 'package:flutter/material.dart';
import 'package:tokenlab_movies/views/HomeView/home_view.dart';
import 'package:tokenlab_movies/views/MovieDetailsView/movie_details_view.dart';

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tokenlab Movies',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color.fromRGBO(63, 63, 63, 1),
        inputDecorationTheme:
            const InputDecorationTheme(filled: true, fillColor: Colors.white),
        primaryTextTheme: Typography().white,
        textTheme: Typography().white,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (context) => HomeView());
        }
        if (settings.name == '/movie') {
          var args = settings.arguments;
          return MaterialPageRoute(
              builder: (context) => MovieDetailsView(id: args as int));
        }
        return MaterialPageRoute(builder: (context) => const UnknownScreen());
      },
      onUnknownRoute: (settings) =>
          MaterialPageRoute(builder: (context) => const UnknownScreen()),
      debugShowCheckedModeBanner: false,
    );
  }
}

class UnknownScreen extends StatelessWidget {
  const UnknownScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('404!'),
      ),
    );
  }
}
