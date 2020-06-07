import 'package:equatable/equatable.dart';
import 'package:tv_series/repostories/models/tv_details.dart';

abstract class TvSeriesState extends Equatable {
  const TvSeriesState();
}

class TvSeriesInitial extends TvSeriesState {
  @override
  List<Object> get props => [];
}

class LoadingTvSeriesState extends TvSeriesState {
  @override
  List<Object> get props => null;
}

class LoadedTvSeriesState extends TvSeriesState {
  final TvDetails response;
  LoadedTvSeriesState(this.response);

  @override
  List<Object> get props => [response];
}

class ErrorTvSeriesState extends TvSeriesState {
  final String message;

  ErrorTvSeriesState(this.message);
  @override
  List<Object> get props => null;
}
