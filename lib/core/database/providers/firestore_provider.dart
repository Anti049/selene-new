import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:selene/core/auth/providers/auth_providers.dart';

part 'firestore_provider.g.dart';

typedef PreferencesDocument = DocumentReference<Map<String, dynamic>>;
typedef PreferencesCollection = CollectionReference<Map<String, dynamic>>;

@riverpod
FirebaseFirestore firestore(Ref ref) {
  return FirebaseFirestore.instance;
}

// Example: Provider for a specific collection reference
@riverpod
CollectionReference<Map<String, dynamic>> themesCollection(Ref ref) {
  return ref.watch(firestoreProvider).collection('themes');
}

// Example: Provider for a specific document reference (Preferences)
const String kPreferencesDocId = 'preferences'; // Define your doc ID

@riverpod
PreferencesDocument preferencesDocument(Ref ref) {
  // Depend on the user ID provider
  final userId = ref.watch(
    currentUserIDProvider,
  ); // Or watch authStateChangesProvider directly

  // If no user is logged in, we cannot provide a user-specific document reference.
  // Throw an error, which Riverpod will propagate to dependent providers/widgets.
  if (userId == null) {
    throw Exception('User not authenticated. Cannot access preferences.');
  }

  // Construct the user-specific path
  // users -> {userId} -> settings -> user_preferences
  return ref
      .watch(firestoreProvider)
      .collection('users') // Top-level collection for users
      .doc(userId) // Document for the specific user
      .collection('settings') // Subcollection for user settings
      .doc('preferences'); // The actual preferences document
}

@riverpod
PreferencesCollection preferencesCollection(Ref ref) {
  // Depend on the user ID provider
  final userId = ref.watch(
    currentUserIDProvider,
  ); // Or watch authStateChangesProvider directly

  // If no user is logged in, we cannot provide a user-specific document reference.
  // Throw an error, which Riverpod will propagate to dependent providers/widgets.
  if (userId == null) {
    throw Exception('User not authenticated. Cannot access preferences.');
  }

  // Construct the user-specific path
  // users -> {userId} -> settings -> user_preferences
  return ref
      .watch(firestoreProvider)
      .collection('users') // Top-level collection for users
      .doc(userId) // Document for the specific user
      .collection('preferences'); // Subcollection for user settings
}
