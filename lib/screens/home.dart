import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fav_youtube/bloc/favorite_bloc.dart';
import 'package:fav_youtube/bloc/videos_bloc.dart';
import 'package:fav_youtube/delegates/data_search.dart';
import 'package:fav_youtube/models/video.dart';
import 'package:fav_youtube/screens/favorites.dart';
import 'package:fav_youtube/widgets/video_tile.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 50,
          child: Image.asset("images/youtube_logo.png"),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        actions: [
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<Map<String, Video>>(
              stream: BlocProvider.getBloc<FavoriteBloc>().outFav,
              initialData: {},
              builder: (context, snapshot) {
                if(snapshot.hasData) return Text("${snapshot.data.length}",style: TextStyle(color: Colors.black87));
                else return Container();
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.star, color: Colors.black87,),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Favorites()));
            },
          ),
          IconButton(
            icon: Icon(Icons.search, color: Colors.black87,),
            onPressed: () async {
              String result = await showSearch(context: context, delegate: DataSearch());
              if (result != null) {
                BlocProvider.getBloc<VideosBloc>().inSearch.add(result);
              }
            },
          )
        ],
      ),
      body: StreamBuilder(
        initialData: [],
        stream:  BlocProvider.getBloc<VideosBloc>().outVideos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemBuilder: (context, index) {
                  if(index < snapshot.data.length) {
                    return VideoTile(snapshot.data[index]);
                  } else if(index > 1){
                    BlocProvider.getBloc<VideosBloc>().inSearch.add(null);
                    return Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              itemCount: snapshot.data.length + 1,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
