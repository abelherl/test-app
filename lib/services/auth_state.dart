part of 'auth_cubit.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class SuccessState extends AuthState {
  final User user;
  const SuccessState(this.user);

  @override
  List<Object> get props => [user];
}

class FailedState extends AuthState {
  final String errorMessage;
  final String field;
  FailedState(this.errorMessage, this.field);
  @override
  List<Object> get props => [errorMessage];
}