part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class SignUpButtonPressed extends RegisterEvent {
  final String username;
  final String email;
  final String password;
  final String confirmPassword;

  SignUpButtonPressed(
      {@required this.username,
      @required this.email,
      @required this.password,
      @required this.confirmPassword});

  @override
  List<Object> get props => [email, username, password, confirmPassword];
  @override
  String toString() =>
      'LoginButtonPressed { username: $username,email: $email, password: $password, confirmPassword: $confirmPassword }';
}

class UsernameChanged extends RegisterEvent {
  final String username;

  const UsernameChanged({@required this.username});

  @override
  List<Object> get props => [username];

  @override
  String toString() => 'UsernameChanged { username: $username }';
}

class EmailChanged extends RegisterEvent {
  final String email;

  const EmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged { Email: $email }';
}

class PasswordChanged extends RegisterEvent {
  final String password;

  const PasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class ConfirmPasswordChanged extends RegisterEvent {
  final bool isPasswordConfirmed;

  const ConfirmPasswordChanged({@required this.isPasswordConfirmed});

  @override
  List<Object> get props => [isPasswordConfirmed];

  @override
  String toString() =>
      'ConfirmPasswordChanged { isPasswordConfirmed: $isPasswordConfirmed }';
}
