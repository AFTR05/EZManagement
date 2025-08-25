
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezmanagement/src/data/repositories/api/firebase_authentication_impl.dart';
import 'package:ezmanagement/src/domain/repositories/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'riverpod_repositories.g.dart';



@riverpod
AuthenticationRepository authenticationRepository(Ref ref) {
  return FirebaseAuthenticationRepositoryImpl(
    firebaseAuth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  );
}
