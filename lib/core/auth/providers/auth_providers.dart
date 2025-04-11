// Example: lib/core/auth/providers/auth_provider.dart (New File - Conceptual)
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:selene/core/auth/repositories/auth_repository.dart';
import 'package:selene/core/database/providers/firestore_provider.dart';

part 'auth_providers.g.dart';

@riverpod
FirebaseAuth firebaseAuth(Ref ref) {
  return FirebaseAuth.instance;
}

// Provider that streams the current Firebase User object
@Riverpod(keepAlive: true)
Stream<User?> authStateChanges(Ref ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
}

// Provides the current User object synchronously, IF available.
// Useful for quick checks, but less reactive than the stream.
@riverpod
User? currentUser(Ref ref) {
  // Depend on the stream to rebuild when auth state changes
  ref.watch(authStateChangesProvider);
  // Return the current user from the instance
  return ref.watch(firebaseAuthProvider).currentUser;
}

// Provider that gives the current User ID (or null if logged out)
@riverpod
String? currentUserID(Ref ref) {
  // Watch the auth state stream
  final asyncUser = ref.watch(authStateChangesProvider);
  // Return the UID from the data state, or null otherwise
  return asyncUser.whenData((user) => user?.uid).valueOrNull;
  // valueOrNull is convenient here but means dependents won't rebuild
  // based on loading/error states of auth itself. Watching authStateChangesProvider
  // directly in dependents might be better for reacting to login/logout transitions.
}

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository(
    ref.watch(firebaseAuthProvider),
    ref.watch(firestoreProvider),
  );
}
