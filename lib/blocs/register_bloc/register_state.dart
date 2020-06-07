part of 'register_bloc.dart';

@immutable
class RegisterState {
  final bool isUsernameValid;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final bool isPasswordConfirmed;
  final String authFailMessage;

  bool get isFormValid => isEmailValid && isPasswordValid;

  RegisterState({
    @required this.isUsernameValid,
    @required this.isEmailValid,
    @required this.isPasswordValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
    @required this.isPasswordConfirmed,
    @required this.authFailMessage,
  });

  factory RegisterState.initial() {
    return RegisterState(
        isUsernameValid: true,
        isEmailValid: true,
        isPasswordValid: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        isPasswordConfirmed: true,
        authFailMessage: '');
  }

  factory RegisterState.loading() {
    return RegisterState(
        isUsernameValid: true,
        isEmailValid: true,
        isPasswordValid: true,
        isSubmitting: true,
        isSuccess: false,
        isFailure: false,
        isPasswordConfirmed: true,
        authFailMessage: '');
  }

  factory RegisterState.failure(String authFailMessage) {
    return RegisterState(
        isUsernameValid: true,
        isEmailValid: true,
        isPasswordValid: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: true,
        isPasswordConfirmed: true,
        authFailMessage: authFailMessage);
  }

  factory RegisterState.success() {
    return RegisterState(
        isUsernameValid: true,
        isEmailValid: true,
        isPasswordValid: true,
        isSubmitting: false,
        isSuccess: true,
        isFailure: false,
        isPasswordConfirmed: true,
        authFailMessage: '');
  }

  RegisterState update({
    bool isEmailValid,
    bool isPasswordValid,
    bool isUsernameValid,
    bool isPasswordConfirmed,
  }) {
    return copyWith(
        isUsernameValid: isUsernameValid,
        isEmailValid: isEmailValid,
        isPasswordValid: isPasswordValid,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        isPasswordConfirmed: isPasswordConfirmed,
        authFailMessage: '');
  }

  RegisterState copyWith(
      {bool isUsernameValid,
      bool isEmailValid,
      bool isPasswordValid,
      bool isSubmitEnabled,
      bool isSubmitting,
      bool isSuccess,
      bool isFailure,
      bool isPasswordConfirmed,
      String authFailMessage}) {
    return RegisterState(
        isUsernameValid: isUsernameValid ?? this.isUsernameValid,
        isEmailValid: isEmailValid ?? this.isEmailValid,
        isPasswordValid: isPasswordValid ?? this.isPasswordValid,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure,
        isPasswordConfirmed: isPasswordConfirmed ?? this.isPasswordConfirmed,
        authFailMessage: authFailMessage ?? this.authFailMessage);
  }

  @override
  String toString() {
    return '''RegisterState {
      isUsernameValid: $isUsernameValid,
      isEmailValid: $isEmailValid,
      isPasswordValid: $isPasswordValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
      isPasswordConfirmed: $isPasswordConfirmed,
      authFailMessage: $authFailMessage,
    }''';
  }
}
