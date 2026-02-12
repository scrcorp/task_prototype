import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../data/mock_data.dart';

class AuthState {
  final bool isAuthenticated;
  final User? user;

  const AuthState({
    this.isAuthenticated = false,
    this.user,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    User? user,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState());

  void login(String id, String password) {
    // Mock login - always succeeds
    state = AuthState(
      isAuthenticated: true,
      user: mockUser,
    );
  }

  void logout() {
    state = const AuthState();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(authProvider).user;
});
