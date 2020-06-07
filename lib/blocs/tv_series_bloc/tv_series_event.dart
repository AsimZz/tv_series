import 'package:equatable/equatable.dart';

abstract class TvSeriesEvent extends Equatable {
  const TvSeriesEvent();
}
class GetTvEvent extends TvSeriesEvent{

  final String tvId;

  
  GetTvEvent(this.tvId);

  @override
  
  List<Object> get props => [tvId];
}

