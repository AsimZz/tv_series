import 'package:equatable/equatable.dart';
import 'package:tv_series/repostories/models/tv_series_response.dart';



abstract class TvSearchState extends Equatable {
  const TvSearchState();
}

class TvSearchInitial extends TvSearchState {
  @override
  List<Object> get props => [];
}

class LoadingTvSearchState extends TvSearchState {
  @override
  List<Object> get props => null;
}

class LoadedSearchTvState extends TvSearchState {
  final Tv_Series response;
  LoadedSearchTvState(this.response);

  @override
  List<Object> get props => [response];
}

class ErrorTvSearchState extends TvSearchState {
  final String message;

  ErrorTvSearchState(this.message);
  @override
  List<Object> get props => null;
}
