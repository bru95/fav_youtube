import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

import '../api.dart';
import '../bloc/favorite_bloc.dart';
import '../models/video.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final bloc = BlocProvider.getBloc<FavoriteBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
        centerTitle: true
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder<Map<String, Video>>(
        stream: bloc.outFav,
        builder: (context, snapshot) {
          return ListView(
            children: snapshot.data.values.map((v) {
              return InkWell(
                onTap: (){
                  FlutterYoutube.playYoutubeVideoById(apiKey: API_KEY, videoId: v.id);
                },
                onLongPress: (){
                  bloc.toggleFavorite(v);
                },
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 50,
                      child: Image.network(v.thumb),
                    ),
                    Expanded(child: Text(v.title, maxLines: 2,))
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
