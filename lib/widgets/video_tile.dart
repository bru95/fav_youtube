import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fav_youtube/bloc/favorite_bloc.dart';
import 'package:fav_youtube/models/video.dart';
import 'package:flutter/material.dart';

class VideoTile extends StatelessWidget {

  final Video video;

  VideoTile(this.video);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 16.0/9.0,
            child: Image.network(video.thumb, fit: BoxFit.cover,),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(video.title, style: TextStyle(color: Colors.black87, fontSize: 16)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(video.channel, style: TextStyle(color: Colors.black87, fontSize: 14)),
                    )
                  ],
                ),
              ),
              StreamBuilder<Map<String, Video>>(
                initialData: {},
                stream: BlocProvider.getBloc<FavoriteBloc>().outFav,
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    return IconButton(
                        icon: Icon(snapshot.data.containsKey(video.id) ? Icons.star : Icons.star_border),
                        onPressed: (){
                          BlocProvider.getBloc<FavoriteBloc>().toggleFavorite(video);
                        }
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
