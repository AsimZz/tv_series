import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:tv_series/repostories/api/tv_series_api.dart';
import 'package:tv_series/repostories/models/tv_series_response.dart';

import 'tv_search_event.dart';
import 'tv_search_state.dart';
import 'dart:convert';

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState> {
  final TvAPI tv_api = TvAPI();

  @override
  TvSearchState get initialState => TvSearchInitial();

  @override
  Stream<TvSearchState> mapEventToState(
    TvSearchEvent event,
  ) async* {
    if (event is SearchTvEvent) {
      yield LoadingTvSearchState();
      try {
        var tv_response = await tv_api.searchTvSeries(event.tvName);

        Tv_Series response = await Tv_Series.fromJson(json.decode(tv_response));

        yield LoadedSearchTvState(response);
      } catch (e) {
        yield ErrorTvSearchState('$e');
      }
    }
  }
}
