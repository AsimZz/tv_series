import 'package:equatable/equatable.dart';

abstract class TvSearchEvent extends Equatable {
  const TvSearchEvent();
}
class SearchTvEvent extends TvSearchEvent{

  final String tvName;

  
  SearchTvEvent(this.tvName);

  @override
  
  List<Object> get props => [tvName];
}

