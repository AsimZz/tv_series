import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tv_series/blocs/tv_series_bloc/tv_series_bloc.dart';
import 'package:tv_series/blocs/tv_series_bloc/tv_series_event.dart';
import 'package:tv_series/blocs/tv_series_bloc/tv_series_state.dart';
import 'package:tv_series/repostories/models/tv_details.dart';
import 'circular_clipper.dart';

class TvSeriesPage extends StatefulWidget {
  final String tvId;
  final String userId;

  final bool inCollection;
  final bool inFavorite;

  TvSeriesPage({
    Key key,
    this.tvId,
    this.inCollection,
    this.inFavorite,
    this.userId,
  }) : super(key: key);
  @override
  _TvSeriesPageState createState() => _TvSeriesPageState();
}

class _TvSeriesPageState extends State<TvSeriesPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocProvider(
          create: (context) => TvSeriesBloc(),
          child: GetTvDetails(
            tvId: widget.tvId,
            userId: widget.userId,
            inCollection: widget.inCollection,
            inFavorite: widget.inFavorite,
          ),
        ));
  }
}

class GetTvDetails extends StatefulWidget {
  final String tvId;
  final String userId;
  final bool inCollection;
  final bool inFavorite;
  GetTvDetails({
    this.tvId,
    this.userId,
    this.inCollection,
    this.inFavorite,
  });

  @override
  _GetTvDetailsState createState() => _GetTvDetailsState();
}

class _GetTvDetailsState extends State<GetTvDetails> {
  String tvId;
  String userId;
  bool inCollection;
  bool inFavorite;
  @override
  void initState() {
    tvId = widget.tvId;
    userId = widget.userId;
    inCollection = widget.inCollection;
    inFavorite = widget.inFavorite;
    BlocProvider.of<TvSeriesBloc>(context)
        .add(GetTvEvent(widget.tvId.toString()));
  }

  void myfavoritesButton(String title, String imageUrl) {}

  void mycollectionButton(String title, String imageUrl) {}

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvSeriesBloc, TvSeriesState>(builder: (
      context,
      state,
    ) {
      if (state is LoadingTvSeriesState) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is ErrorTvSeriesState) {
        return Center(
          child: Text(state.message),
        );
      }
      if (state is LoadedTvSeriesState) {
        TvDetails show = state.response;

        String genre = _getGenreList(show, context);
        return ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                SizedBox(height: 100.0),
                Container(
                  transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                  child: ClipShadowPath(
                    clipper: CircularClipper(),
                    shadow: Shadow(blurRadius: 20.0),
                    child: FadeInImage.memoryNetwork(
                      height: 450.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: kTransparentImage,
                      image:
                          'https://image.tmdb.org/t/p/w500' + show.posterPath,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      padding: EdgeInsets.only(left: 30.0),
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back),
                      iconSize: 30.0,
                      color: Colors.black,
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0.0,
                  left: 20.0,
                  child: IconButton(
                    icon:
                        (!inCollection ? Icon(Icons.add) : Icon(Icons.remove)),
                    onPressed: () {
                      final String postUrl =
                          'http://tv-series-api.herokuapp.com/user/collection/';
                      setState(() {
                        if (inCollection) {
                          http.delete(
                            postUrl + widget.userId + '/' + widget.tvId,
                            headers: {"Content-type": "application/json"},
                          );
                          print('col1:$inCollection');
                          inCollection = false;
                          print('col2: $inCollection');
                        } else {
                          http.post(postUrl + widget.userId,
                              headers: {"Content-type": "application/json"},
                              body: json.encode({
                                "tv_id": widget.tvId,
                                "tv_title": show.originalName,
                                "image_url": "https://image.tmdb.org/t/p/w500" +
                                    show.posterPath
                              }));
                          inCollection = true;
                        }
                      });
                    },
                    iconSize: 40.0,
                    color: Colors.black,
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  right: 25.0,
                  child: IconButton(
                    icon: (!inFavorite
                        ? Icon(Icons.favorite_border)
                        : Icon(Icons.favorite)),
                    onPressed: () {
                      final String postUrl =
                          'http://tv-series-api.herokuapp.com/user/favorite/';
                      setState(() {
                        if (inFavorite) {
                          http.delete(
                            postUrl + widget.userId + '/' + widget.tvId,
                            headers: {"Content-type": "application/json"},
                          );
                          inFavorite = false;
                        } else {
                          http.post(postUrl + widget.userId,
                              headers: {"Content-type": "application/json"},
                              body: json.encode({
                                "tv_id": widget.tvId,
                                "tv_title": show.originalName,
                                "image_url": "https://image.tmdb.org/t/p/w500" +
                                    show.posterPath
                              }));
                          inFavorite = true;
                        }
                      });
                    },
                    iconSize: 35.0,
                    color: Colors.red[500],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    show.originalName.toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.0),
                  SizedBox(height: 12.0),
                  Text(
                    genre.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            'Year',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.black54,
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Text(
                            show.firstAirDate.split('-')[0],
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            'Country',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.black54,
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Text(
                            show.originalLanguage.toUpperCase(),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[],
                      ),
                    ],
                  ),
                  SizedBox(height: 25.0),
                  Container(
                    height: 120.0,
                    child: SingleChildScrollView(
                      child: Text(
                        show.overview,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }
    });
  }

  String _getGenreList(TvDetails show, context) {
    String genre = '';
    for (Genres i in show.genres) {
      genre = genre + i.name + ',';
    }
    return genre.substring(0, genre.length - 1);
  }

  Widget _getTvDetails(
      {TvDetails show,
      String tvId,
      bool inCollection,
      bool inFavorite,
      context}) {}
}
