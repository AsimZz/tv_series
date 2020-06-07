part of 'login_bloc.dart';

@immutable
class LoginState {
  final bool isEmailValid;
  final bool isPasswordValid;

  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String authFailMessage;

  bool get isFormValid => isEmailValid && isPasswordValid;

  LoginState({
    @required this.isEmailValid,
    @required this.isPasswordValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
    @required this.authFailMessage,
  });

  factory LoginState.initial() {
    return LoginState(
        isEmailValid: true,
        isPasswordValid: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        authFailMessage: '');
  }

  factory LoginState.loading() {
    return LoginState(
        isEmailValid: true,
        isPasswordValid: true,
        isSubmitting: true,
        isSuccess: false,
        isFailure: false,
        authFailMessage: '');
  }

  factory LoginState.failure(String authFailMessage) {
    return LoginState(
        isEmailValid: true,
        isPasswordValid: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: true,
        authFailMessage: authFailMessage);
  }

  factory LoginState.success() {
    return LoginState(
        isEmailValid: true,
        isPasswordValid: true,
        isSubmitting: false,
        isSuccess: true,
        isFailure: false,
        authFailMessage: '');
  }

  LoginState update({
    bool isEmailValid,
    bool isPasswordValid,
    bool isEmailEmpty,
    bool isPasswordEmpty,
  }) {
    return copyWith(
        isEmailValid: isEmailValid,
        isPasswordValid: isPasswordValid,
        isEmailEmpty: isEmailEmpty,
        isPasswordEmpty: isPasswordEmpty,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        authFailMessage: '');
  }

  LoginState copyWith(
      {bool isEmailValid,
      bool isPasswordValid,
      bool isEmailEmpty,
      bool isPasswordEmpty,
      bool isSubmitEnabled,
      bool isSubmitting,
      bool isSuccess,
      bool isFailure,
      String authFailMessage}) {
    return LoginState(
        isEmailValid: isEmailValid ?? this.isEmailValid,
        isPasswordValid: isPasswordValid ?? this.isPasswordValid,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure,
        authFailMessage: authFailMessage ?? this.authFailMessage);
  }

  @override
  String toString() {
    return '''LoginState {
      isEmailValid: $isEmailValid,
      isPasswordValid: $isPasswordValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
      authFailMessage: $authFailMessage,
    }''';
  }
}
