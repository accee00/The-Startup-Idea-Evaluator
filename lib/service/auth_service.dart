import 'package:ai_voting_app/core/extension%20/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient client;
  AuthService(this.client);

  Future<Either<Failure, User?>> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      print('signup call');
      final AuthResponse response = await client.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );
      if (response.user != null) {
        return right(response.user);
      }
      return left(Failure('Unexpected error occurred'));
    } on AuthException catch (e) {
      print(e.toString());
      return left(_mapAuthExceptionToFailure(e));
    } catch (_) {
      return left(Failure('Something went wrong. Please try again.'));
    }
  }

  Future<Either<Failure, User?>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponse response = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user != null) {
        return right(response.user);
      }
      return left(Failure('Unexpected error occurred'));
    } on AuthException catch (e) {
      return left(_mapAuthExceptionToFailure(e));
    } catch (_) {
      return left(Failure('Something went wrong. Please try again.'));
    }
  }

  Future<Either<Failure, void>> signOut() async {
    try {
      await client.auth.signOut();
      return right(null);
    } on AuthException catch (e) {
      return left(_mapAuthExceptionToFailure(e));
    } catch (_) {
      return left(Failure('Something went wrong. Please try again.'));
    }
  }

  Future<User?> getCurrentUser() async {
    return client.auth.currentUser;
  }
}

Failure _mapAuthExceptionToFailure(AuthException e) {
  final String msg = e.message.toLowerCase();

  final Map<String, String> errorMap = <String, String>{
    'invalid login credentials': 'Invalid email or password',
    'user already registered': 'Email is already registered',
    'email not confirmed': 'Please verify your email before logging in',
    'rate limit exceeded': 'Too many attempts. Try again later',
    'password should be at least': 'Password is too weak',
  };

  for (final MapEntry<String, String> entry in errorMap.entries) {
    if (msg.contains(entry.key)) {
      return Failure(entry.value);
    }
  }

  return Failure('Auth error: ${e.message}');
}
