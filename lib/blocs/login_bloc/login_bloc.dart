import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';
import 'package:tv_series/blocs/authentication_bloc/bloc/authentication_bloc.dart';
import 'package:tv_series/blocs/user_info_bloc/user_info_bloc.dart';
import 'package:tv_series/domain/auth/value_objects.dart';
import 'package:tv_series/repostories/api/login_api.dart';
import 'package:tv_series/repostories/models/login_error_messages.dart';
import 'package:tv_series/repostories/models/token.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc authenticationBloc;
  final UserInfoBloc userInfoBloc;
  final LoginAPI loginApi = LoginAPI();

  LoginBloc({
    this.userInfoBloc,
    this.authenticationBloc,
  });

  LoginState get initialState => LoginState.initial();

  @override
  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is LoginButtonPressed) {
      yield* _mapLoginButtonPressedToState(
        email: event.email,
        password: event.password,
      );
    }
  }

  Stream<LoginState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: EmailAddress(email).isValid(),
    );
  }

  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Password(password).isValid(),
    );
  }

  Stream<LoginState> _mapLoginButtonPressedToState({
    String email,
    String password,
  }) async* {
    yield LoginState.loading();
    try {
      final response = await loginApi.logInUser(
        email: email,
        password: password,
      );
      if (response.statusCode == 200) {
        Token hasToken = Token.fromJson(json.decode(response.body));

        authenticationBloc.add(LoggedIn(token: hasToken.token));

        yield LoginState.success();
      }
      if (response.statusCode == 400) {
        LoginErrorMessages authFailed =
            LoginErrorMessages.fromJson(json.decode(response.body));
        yield LoginState.failure(authFailed.message);
      }
    } catch (_) {
      yield LoginState.failure('');
    }
  }
// if (event is LoginButtonPressed) {
//       yield LoginLoading();

//       try {
//         final response = await loginApi.logInUser(
//           email: event.email,
//           password: event.password,
//         );
//         if (response.statusCode == 200) {
//           Token hasToken = Token.fromJson(json.decode(response.body));

//           authenticationBloc.add(LoggedIn(token: hasToken.token));
//           yield LoginInitial();
//         }
//         if (response.statusCode == 400) {
//           LoginErrorMessages errorMessages =
//               LoginErrorMessages.fromJson(json.decode(response.body));
//           yield (error: errorMessages.message);
//         }
//       } catch (error) {
//         yield LoginFailure(error: error.toString());
//       }
//     }
}
