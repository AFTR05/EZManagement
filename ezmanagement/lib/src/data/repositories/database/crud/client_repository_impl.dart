import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:ezmanagement/src/core/exceptions/client_exception.dart';
import 'package:ezmanagement/src/core/exceptions/failure.dart';
import 'package:ezmanagement/src/domain/entities/client_entity.dart';
import 'package:ezmanagement/src/domain/repositories/crud/client_repository.dart';

class ClientRepositoryImpl extends ClientRepository {
  ClientRepositoryImpl({
    FirebaseFirestore? firestore,
    String collectionPath = 'clients',
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _collection =
            (firestore ?? FirebaseFirestore.instance).collection(collectionPath);

  final FirebaseFirestore _firestore;
  final CollectionReference<Map<String, dynamic>> _collection;

  @override
  Future<Either<Failure, List<ClientEntity>>> getAllElements() async {
    try {
      final snap = await _collection.get();
      final items =
          snap.docs.map((d) => ClientEntity.fromMap(d.data(), d.id)).toList();
      return Right(items);
    } catch (e) {
      return Left(ClientException());
    }
  }

  @override
  Future<Either<Failure, ClientEntity>> getElementById({
    required String id,
  }) async {
    try {
      final doc = await _collection.doc(id).get();
      if (!doc.exists) return Left(ClientException());
      return Right(ClientEntity.fromMap(doc.data()!, doc.id));
    } catch (e) {
      return Left(ClientException());
    }
  }

  @override
  Future<Either<Failure, ClientEntity>> createElement({
    required ClientEntity t,
  }) async {
    try {
      final docRef = t.id.isEmpty ? _collection.doc() : _collection.doc(t.id);
      final newEntity = t.id.isEmpty
          ? ClientEntity.fromMap(t.toMap(), docRef.id)
          : t;

      await docRef.set(newEntity.toMap(), SetOptions(merge: false));
      return Right(newEntity);
    } catch (e) {
      return Left(ClientException());
    }
  }

  @override
  Future<Either<Failure, List<ClientEntity>>> createElements({
    required List<ClientEntity> ts,
  }) async {
    if (ts.isEmpty) return const Right([]);
    try {
      final batch = _firestore.batch();
      final created = <ClientEntity>[];

      for (final c in ts) {
        final docRef = c.id.isEmpty ? _collection.doc() : _collection.doc(c.id);
        final newEntity = c.id.isEmpty
            ? ClientEntity.fromMap(c.toMap(), docRef.id)
            : c;

        batch.set(docRef, newEntity.toMap(), SetOptions(merge: false));
        created.add(newEntity);
      }

      await batch.commit();
      return Right(created);
    } catch (e) {
      return Left(ClientException());
    }
  }

  @override
  Future<Either<Failure, ClientEntity>> updateElement({
    required ClientEntity t,
  }) async {
    try {
      await _collection.doc(t.id).update(t.toMap());
      return Right(t);
    } catch (e) {
      return Left(ClientException());
    }
  }

  @override
  Future<Either<Failure, List<ClientEntity>>> updateElements({
    required List<ClientEntity> ts,
  }) async {
    if (ts.isEmpty) return const Right([]);
    try {
      final batch = _firestore.batch();
      for (final c in ts) {
        batch.update(_collection.doc(c.id), c.toMap());
      }
      await batch.commit();
      return Right(ts);
    } catch (e) {
      return Left(ClientException());
    }
  }

  @override
  Future<Either<Failure, ClientEntity>> deleteElement({
    required ClientEntity t,
  }) async {
    try {
      await _collection.doc(t.id).delete();
      return Right(t);
    } catch (e) {
      return Left(ClientException());
    }
  }

  @override
  Future<Either<Failure, List<ClientEntity>>> deleteElements({
    required List<ClientEntity> ts,
  }) async {
    if (ts.isEmpty) return const Right([]);
    try {
      final batch = _firestore.batch();
      for (final c in ts) {
        batch.delete(_collection.doc(c.id));
      }
      await batch.commit();
      return Right(ts);
    } catch (e) {
      return Left(ClientException());
    }
  }
}
