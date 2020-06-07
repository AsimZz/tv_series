part of 'user_info_bloc.dart';

abstract class UserInfoEvent extends Equatable {
  const UserInfoEvent();
}

class GetUserInfoEvent extends UserInfoEvent {
  final String token;

  const GetUserInfoEvent({@required this.token});
  @override
  List<Object> get props => throw UnimplementedError();
}
