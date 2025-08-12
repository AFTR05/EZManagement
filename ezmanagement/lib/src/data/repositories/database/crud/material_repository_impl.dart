import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:ezmanagement/src/core/exceptions/failure.dart';
import 'package:ezmanagement/src/core/exceptions/material_exception.dart';
import 'package:ezmanagement/src/domain/entities/material_entity.dart';
import 'package:ezmanagement/src/domain/repositories/crud/material_repository.dart';

class MaterialRepositoryImpl extends MaterialRepository {
  MaterialRepositoryImpl({
    FirebaseFirestore? firestore,
    String collectionPath = 'materials',
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _collection =
            (firestore ?? FirebaseFirestore.instance).collection(collectionPath);

  final FirebaseFirestore _firestore;
  final CollectionReference<Map<String, dynamic>> _collection;

  @override
  Future<Either<Failure, List<MaterialEntity>>> getAllElements() async {
    try {
      final snap = await _collection.get();
      final items =
          snap.docs.map((d) => MaterialEntity.fromMap(d.data(), d.id)).toList();
      return Right(items);
    } catch (_) {
      return Left(MaterialException());
    }
  }

  @override
  Future<Either<Failure, MaterialEntity>> getElementById({
    required String id,
  }) async {
    try {
      final doc = await _collection.doc(id).get();
      if (!doc.exists) return Left(MaterialException());
      return Right(MaterialEntity.fromMap(doc.data()!, doc.id));
    } catch (_) {
      return Left(MaterialException());
    }
  }

  @override
  Future<Either<Failure, MaterialEntity>> createElement({
    required MaterialEntity t,
  }) async {
    try {
      final docRef = t.id.isEmpty ? _collection.doc() : _collection.doc(t.id);

      // Si tienes copyWith({id}), úsalo. Aquí rehidratamos desde el map con nuevo id.
      final newEntity =
          t.id.isEmpty ? MaterialEntity.fromMap(t.toMap(), docRef.id) : t;

      await docRef.set(newEntity.toMap(), SetOptions(merge: false));
      return Right(newEntity);
    } catch (_) {
      return Left(MaterialException());
    }
  }

  @override
  Future<Either<Failure, List<MaterialEntity>>> createElements({
    required List<MaterialEntity> ts,
  }) async {
    if (ts.isEmpty) return const Right([]);
    try {
      final batch = _firestore.batch();
      final created = <MaterialEntity>[];

      for (final m in ts) {
        final docRef = m.id.isEmpty ? _collection.doc() : _collection.doc(m.id);
        final newEntity =
            m.id.isEmpty ? MaterialEntity.fromMap(m.toMap(), docRef.id) : m;

        batch.set(docRef, newEntity.toMap(), SetOptions(merge: false));
        created.add(newEntity);
      }

      await batch.commit();
      return Right(created);
    } catch (_) {
      return Left(MaterialException());
    }
  }

  @override
  Future<Either<Failure, MaterialEntity>> updateElement({
    required MaterialEntity t,
  }) async {
    try {
      await _collection.doc(t.id).update(t.toMap());
      return Right(t);
    } catch (_) {
      return Left(MaterialException());
    }
  }

  @override
  Future<Either<Failure, List<MaterialEntity>>> updateElements({
    required List<MaterialEntity> ts,
  }) async {
    if (ts.isEmpty) return const Right([]);
    try {
      final batch = _firestore.batch();
      for (final m in ts) {
        batch.update(_collection.doc(m.id), m.toMap());
      }
      await batch.commit();
      return Right(ts);
    } catch (_) {
      return Left(MaterialException());
    }
  }

  @override
  Future<Either<Failure, MaterialEntity>> deleteElement({
    required MaterialEntity t,
  }) async {
    try {
      await _collection.doc(t.id).delete();
      return Right(t);
    } catch (_) {
      return Left(MaterialException());
    }
  }

  @override
  Future<Either<Failure, List<MaterialEntity>>> deleteElements({
    required List<MaterialEntity> ts,
  }) async {
    if (ts.isEmpty) return const Right([]);
    try {
      final batch = _firestore.batch();
      for (final m in ts) {
        batch.delete(_collection.doc(m.id));
      }
      await batch.commit();
      return Right(ts);
    } catch (_) {
      return Left(MaterialException());
    }
  }
}
