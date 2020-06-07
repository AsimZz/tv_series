import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';
import 'package:tv_series/blocs/authentication_bloc/bloc/authentication_bloc.dart';
import 'package:tv_series/blocs/login_bloc/login_bloc.dart';
import 'package:tv_series/domain/auth/value_objects.dart';
import 'package:tv_series/repostories/api/register_api.dart';
import 'package:tv_series/repostories/models/login_error_messages.dart';
import 'package:tv_series/repostories/models/token.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterAPI registerAPI = RegisterAPI();

  RegisterBloc();

  RegisterState get initialState => RegisterState.initial();

  @override
  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is UsernameChanged) {
      yield* _mapUsernameChangedToState(event.username);
    } else if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is ConfirmPasswordChanged) {
      yield* _mapConfirmPasswordChangedToState(event.isPasswordConfirmed);
    } else if (event is SignUpButtonPressed) {
      yield* _mapSignUpButtonPressedToState(
          username: event.username,
          email: event.email,
          password: event.password,
          confirmPassword: event.confirmPassword);
    }
  }

  Stream<RegisterState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: EmailAddress(email).isValid(),
    );
  }

  Stream<RegisterState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Password(password).isValid(),
    );
  }

  Stream<RegisterState> _mapUsernameChangedToState(String username) async* {
    yield state.update(
      isUsernameValid: Username(username).isValid(),
    );
  }

  Stream<RegisterState> _mapConfirmPasswordChangedToState(
      bool isPasswordConfirmed) async* {
    yield state.update(
      isPasswordConfirmed: isPasswordConfirmed,
    );
  }

  Stream<RegisterState> _mapSignUpButtonPressedToState(
      {String username,
      String email,
      String password,
      String confirmPassword}) async* {
    yield RegisterState.loading();
    try {
      final response = await registerAPI.createNewUser(
          username: username,
          email: email,
          password: password,
          confirmPassword: confirmPassword);
      if (response.statusCode == 200) {
        yield RegisterState.success();
      }
      if (response.statusCode == 400) {
        LoginErrorMessages authFailed =
            LoginErrorMessages.fromJson(json.decode(response.body));
        yield RegisterState.failure(authFailed.message);
      }
    } catch (_) {
      yield RegisterState.failure('');
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
