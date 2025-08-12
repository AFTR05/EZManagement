import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:ezmanagement/src/core/exceptions/failure.dart';
import 'package:ezmanagement/src/core/exceptions/material_input_exception.dart';
import 'package:ezmanagement/src/domain/entities/material_input_entity.dart';
import 'package:ezmanagement/src/domain/repositories/crud/material_input_repository.dart';

class MaterialInputRepositoryImpl extends MaterialInputRepository {
  MaterialInputRepositoryImpl({
    FirebaseFirestore? firestore,
    String collectionPath = 'material_inputs',
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _collection =
            (firestore ?? FirebaseFirestore.instance).collection(collectionPath);

  final FirebaseFirestore _firestore;
  final CollectionReference<Map<String, dynamic>> _collection;

  @override
  Future<Either<Failure, List<MaterialInputEntity>>> getAllElements() async {
    try {
      final snap = await _collection.get();
      final items = snap.docs
          .map((d) => MaterialInputEntity.fromMap(d.data(), d.id))
          .toList();
      return Right(items);
    } catch (_) {
      return Left(MaterialInputException());
    }
  }

  @override
  Future<Either<Failure, MaterialInputEntity>> getElementById({
    required String id,
  }) async {
    try {
      final doc = await _collection.doc(id).get();
      if (!doc.exists) return Left(MaterialInputException());
      return Right(MaterialInputEntity.fromMap(doc.data()!, doc.id));
    } catch (_) {
      return Left(MaterialInputException());
    }
  }

  @override
  Future<Either<Failure, MaterialInputEntity>> createElement({
    required MaterialInputEntity t,
  }) async {
    try {
      final docRef = t.id.isEmpty ? _collection.doc() : _collection.doc(t.id);

      // Si tu entidad tiene copyWith({id}), puedes usarlo en lugar de fromMap(...)
      final newEntity = t.id.isEmpty
          ? MaterialInputEntity.fromMap(t.toMap(), docRef.id)
          : t;

      await docRef.set(newEntity.toMap(), SetOptions(merge: false));
      return Right(newEntity);
    } catch (_) {
      return Left(MaterialInputException());
    }
  }

  @override
  Future<Either<Failure, List<MaterialInputEntity>>> createElements({
    required List<MaterialInputEntity> ts,
  }) async {
    if (ts.isEmpty) return const Right([]);
    try {
      final batch = _firestore.batch();
      final created = <MaterialInputEntity>[];

      for (final m in ts) {
        final docRef = m.id.isEmpty ? _collection.doc() : _collection.doc(m.id);
        final newEntity = m.id.isEmpty
            ? MaterialInputEntity.fromMap(m.toMap(), docRef.id)
            : m;

        batch.set(docRef, newEntity.toMap(), SetOptions(merge: false));
        created.add(newEntity);
      }

      await batch.commit();
      return Right(created);
    } catch (_) {
      return Left(MaterialInputException());
    }
  }

  @override
  Future<Either<Failure, MaterialInputEntity>> updateElement({
    required MaterialInputEntity t,
  }) async {
    try {
      await _collection.doc(t.id).update(t.toMap());
      return Right(t);
    } catch (_) {
      return Left(MaterialInputException());
    }
  }

  @override
  Future<Either<Failure, List<MaterialInputEntity>>> updateElements({
    required List<MaterialInputEntity> ts,
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
      return Left(MaterialInputException());
    }
  }

  @override
  Future<Either<Failure, MaterialInputEntity>> deleteElement({
    required MaterialInputEntity t,
  }) async {
    try {
      await _collection.doc(t.id).delete();
      return Right(t);
    } catch (_) {
      return Left(MaterialInputException());
    }
  }

  @override
  Future<Either<Failure, List<MaterialInputEntity>>> deleteElements({
    required List<MaterialInputEntity> ts,
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
      return Left(MaterialInputException());
    }
  }
}
