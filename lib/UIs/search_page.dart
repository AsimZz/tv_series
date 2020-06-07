import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:tv_series/blocs/tv_search_bloc/bloc/bloc.dart';
import 'package:tv_series/blocs/tv_search_bloc/bloc/tv_search_bloc.dart';
import 'package:tv_series/blocs/tv_search_bloc/bloc/tv_search_event.dart';
import 'package:tv_series/blocs/tv_search_bloc/bloc/tv_search_state.dart';
import 'tv_series_page.dart';

class TvSearchPage extends SearchDelegate {
  final listOfCollectionsIds;
  final listOfFavoritesIds;
  final String userId;
  final TvSearchBloc tv_bloc;
  final String searchFieldLabel = 'e.g Game of thrones';

  TvSearchPage({
    this.userId,
    this.tv_bloc,
    this.listOfCollectionsIds,
    this.listOfFavoritesIds,
  });

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {}

  @override
  Widget buildSuggestions(BuildContext context) {
    tv_bloc.add(SearchTvEvent(
      query,
    ));
    return BlocBuilder(
      bloc: tv_bloc,
      builder: (context, state) {
        if (state is LoadingTvSearchState) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is ErrorTvSearchState) {
          return Container(
            child: Center(
              child: Text(''),
            ),
          );
        }
        if (state is LoadedSearchTvState) {
          final tv_shows = state.response;

          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => new TvSeriesPage(
                                userId: userId,
                                inCollection: listOfCollectionsIds.contains(
                                    tv_shows.results[index].id.toString()),
                                inFavorite: listOfFavoritesIds.contains(
                                    tv_shows.results[index].id.toString()),
                                tvId: tv_shows.results[index].id.toString(),
                              )));
                },
                leading: Icon(
                  Icons.tv,
                  color: Colors.black,
                ),
                title: Text(
                  tv_shows.results[index].originalName,
                  style: TextStyle(color: Colors.black),
                ),
              );
            },
            itemCount: tv_shows.results.length,
          );
        }
      },
    );
  }
}

class SeachContent extends StatefulWidget {
  String query;
  SeachContent();

  @override
  _SeachContentState createState() => _SeachContentState();
}

class _SeachContentState extends State<SeachContent> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TvSearchBloc>(context)
        .add(SearchTvEvent('Game of thrones'));
    return BlocBuilder<TvSearchBloc, TvSearchState>(
      builder: (context, state) {
        if (state is LoadingTvSearchState) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is ErrorTvSearchState) {
          return Container(
            child: Center(
              child: Text(state.message),
            ),
          );
        }
        if (state is LoadedSearchTvState) {
          final tv_shows = state.response;

          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => new TvSeriesPage(
                                tvId: tv_shows.results[index].id.toString(),
                              )));
                },
                leading: Icon(
                  Icons.tv,
                  color: Colors.black,
                ),
                title: Text(
                  tv_shows.results[index].originalName,
                  style: TextStyle(color: Colors.black),
                ),
              );
            },
            itemCount: tv_shows.results.length,
          );
        }
      },
    );
  }
}
