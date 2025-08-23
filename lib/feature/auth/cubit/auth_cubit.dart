import 'package:ai_voting_app/service/auth_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authService) : super(AuthInitial());

  final AuthService _authService;

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(AuthLoading());
    final result = await _authService.signUp(
      email: email,
      password: password,
      name: name,
    );
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthUserState(user!, fromSignUp: true)),
    );
  }

  Future<void> signIn({required String email, required String password}) async {
    emit(AuthLoading());
    final result = await _authService.signIn(email: email, password: password);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthUserState(user!, fromSignIn: true)),
    );
  }

  Future<void> signOut() async {
    emit(AuthLoading());
    final result = await _authService.signOut();
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthSignedOut()),
    );
  }

  Future<void> getCurrentUser() async {
    final user = await _authService.getCurrentUser();
    if (user != null) {
      emit(AuthUserState(user));
    } else {
      emit(AuthInitial());
    }
  }
}
