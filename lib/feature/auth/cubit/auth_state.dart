part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSignedUp extends AuthState {
  final User? user;
  const AuthSignedUp(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthUserState extends AuthState {
  final User user;
  final bool fromSignUp;
  final bool fromSignIn;

  const AuthUserState(
    this.user, {
    this.fromSignUp = false,
    this.fromSignIn = false,
  });
}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}

class AuthSignedOut extends AuthState {}
