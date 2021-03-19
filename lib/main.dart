import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fav_youtube/api.dart';
import 'package:fav_youtube/bloc/favorite_bloc.dart';
import 'package:fav_youtube/bloc/videos_bloc.dart';
import 'package:fav_youtube/screens/home.dart';
import 'package:flutter/material.dart';

void main() {

  Api api = Api();
  api.search("banana");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        blocs: [
          Bloc((i) => VideosBloc()),
          Bloc((i) => FavoriteBloc()),
        ],
        child: MaterialApp(
          title: 'FlutterTube',
          debugShowCheckedModeBanner: false,
          home: Home(),
        )
    );
  }
}

