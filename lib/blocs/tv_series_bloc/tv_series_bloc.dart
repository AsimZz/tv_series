import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:tv_series/repostories/api/tv_details_api.dart';
import 'package:tv_series/repostories/models/tv_details.dart';

import 'tv_series_event.dart';
import 'tv_series_state.dart';
import 'dart:convert';

class TvSeriesBloc extends Bloc<TvSeriesEvent, TvSeriesState> {
  final TvDetailsAPI tvApi = TvDetailsAPI();
  @override
  TvSeriesState get initialState => TvSeriesInitial();

  @override
  Stream<TvSeriesState> mapEventToState(
    TvSeriesEvent event,
  ) async* {
    if (event is GetTvEvent) {
      yield LoadingTvSeriesState();
      try {
        var tvResponse = await tvApi.getTvDetails(event.tvId);
        TvDetails response = TvDetails.fromJson(json.decode(tvResponse));
        yield LoadedTvSeriesState(response);
      } catch (e) {
        yield ErrorTvSeriesState('$e');
      }
    }
  }
}
