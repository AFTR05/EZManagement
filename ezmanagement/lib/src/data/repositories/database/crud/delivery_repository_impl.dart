import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:ezmanagement/src/core/exceptions/failure.dart';
import 'package:ezmanagement/src/core/exceptions/delivery_exception.dart';
import 'package:ezmanagement/src/domain/entities/delivery_entity.dart';
import 'package:ezmanagement/src/domain/repositories/crud/delivery_repository.dart';

class DeliveryRepositoryImpl extends DeliveryRepository {
  DeliveryRepositoryImpl({
    FirebaseFirestore? firestore,
    String collectionPath = 'deliveries',
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _collection =
            (firestore ?? FirebaseFirestore.instance).collection(collectionPath);

  final FirebaseFirestore _firestore;
  final CollectionReference<Map<String, dynamic>> _collection;

  // Normaliza campos antes de mapear a la entidad (maneja Timestamp/DateTime)
  Map<String, dynamic> _normalize(Map<String, dynamic> data) {
    final normalized = Map<String, dynamic>.from(data);
    final raw = normalized['deliveryDate'];
    if (raw is Timestamp) {
      normalized['deliveryDate'] = raw.toDate().toIso8601String();
    } else if (raw is DateTime) {
      normalized['deliveryDate'] = raw.toIso8601String();
    }
    return normalized;
  }

  @override
  Future<Either<Failure, List<DeliveryEntity>>> getAllElements() async {
    try {
      final snap = await _collection.get();
      final items = snap.docs
          .map((d) => DeliveryEntity.fromMap(_normalize(d.data()), d.id))
          .toList();
      return Right(items);
    } catch (_) {
      return Left(DeliveryException());
    }
  }

  @override
  Future<Either<Failure, DeliveryEntity>> getElementById({
    required String id,
  }) async {
    try {
      final doc = await _collection.doc(id).get();
      if (!doc.exists) return Left(DeliveryException());
      return Right(DeliveryEntity.fromMap(_normalize(doc.data()!), doc.id));
    } catch (_) {
      return Left(DeliveryException());
    }
  }

  @override
  Future<Either<Failure, DeliveryEntity>> createElement({
    required DeliveryEntity t,
  }) async {
    try {
      final docRef = t.id.isEmpty ? _collection.doc() : _collection.doc(t.id);

      // Si tu entidad tiene copyWith, úsalo; si no, reconstuye desde el map + id
      final newEntity = t.id.isEmpty
          ? DeliveryEntity.fromMap(t.toMap(), docRef.id)
          : t;

      await docRef.set(newEntity.toMap(), SetOptions(merge: false));
      return Right(newEntity);
    } catch (_) {
      return Left(DeliveryException());
    }
  }

  @override
  Future<Either<Failure, List<DeliveryEntity>>> createElements({
    required List<DeliveryEntity> ts,
  }) async {
    if (ts.isEmpty) return const Right([]);
    try {
      final batch = _firestore.batch();
      final created = <DeliveryEntity>[];

      for (final d in ts) {
        final docRef = d.id.isEmpty ? _collection.doc() : _collection.doc(d.id);
        final newEntity = d.id.isEmpty
            ? DeliveryEntity.fromMap(d.toMap(), docRef.id)
            : d;

        batch.set(docRef, newEntity.toMap(), SetOptions(merge: false));
        created.add(newEntity);
      }

      await batch.commit();
      return Right(created);
    } catch (_) {
      return Left(DeliveryException());
    }
  }

  @override
  Future<Either<Failure, DeliveryEntity>> updateElement({
    required DeliveryEntity t,
  }) async {
    try {
      await _collection.doc(t.id).update(t.toMap());
      return Right(t);
    } catch (_) {
      return Left(DeliveryException());
    }
  }

  @override
  Future<Either<Failure, List<DeliveryEntity>>> updateElements({
    required List<DeliveryEntity> ts,
  }) async {
    if (ts.isEmpty) return const Right([]);
    try {
      final batch = _firestore.batch();
      for (final d in ts) {
        batch.update(_collection.doc(d.id), d.toMap());
      }
      await batch.commit();
      return Right(ts);
    } catch (_) {
      return Left(DeliveryException());
    }
  }

  @override
  Future<Either<Failure, DeliveryEntity>> deleteElement({
    required DeliveryEntity t,
  }) async {
    try {
      await _collection.doc(t.id).delete();
      return Right(t);
    } catch (_) {
      return Left(DeliveryException());
    }
  }

  @override
  Future<Either<Failure, List<DeliveryEntity>>> deleteElements({
    required List<DeliveryEntity> ts,
  }) async {
    if (ts.isEmpty) return const Right([]);
    try {
      final batch = _firestore.batch();
      for (final d in ts) {
        batch.delete(_collection.doc(d.id));
      }
      await batch.commit();
      return Right(ts);
    } catch (_) {
      return Left(DeliveryException());
    }
  }
}
