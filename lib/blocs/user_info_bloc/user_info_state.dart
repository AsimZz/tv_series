part of 'user_info_bloc.dart';

abstract class UserInfoState extends Equatable {
  const UserInfoState();
}

class UserInfoInitial extends UserInfoState {
  @override
  List<Object> get props => [];
}

class LoadingUserInfoState extends UserInfoState {
  @override
  List<Object> get props => null;
}

class LoadedUserInfoState extends UserInfoState {
  final UserInfo response;
  LoadedUserInfoState(this.response);

  @override
  List<Object> get props => [response];
}

class ErrorUserInfoState extends UserInfoState {
  final String message;

  ErrorUserInfoState(this.message);
  @override
  List<Object> get props => null;
}
