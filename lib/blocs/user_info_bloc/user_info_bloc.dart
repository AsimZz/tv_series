import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tv_series/repostories/api/get_user_info_api.dart';
import 'package:tv_series/repostories/models/user_info.dart';

part 'user_info_event.dart';
part 'user_info_state.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  final UserInfoAPI userInfo = UserInfoAPI();

  @override
  UserInfoState get initialState => UserInfoInitial();

  @override
  Stream<UserInfoState> mapEventToState(
    UserInfoEvent event,
  ) async* {
    if (event is GetUserInfoEvent) {
      yield LoadingUserInfoState();
      try {
        var userResponse = await userInfo.getUserInfo(token: event.token);

        UserInfo response = UserInfo.fromJson(json.decode(userResponse));
        yield LoadedUserInfoState(response);
      } catch (e) {
        yield ErrorUserInfoState('$e');
      }
    }
  }
}
