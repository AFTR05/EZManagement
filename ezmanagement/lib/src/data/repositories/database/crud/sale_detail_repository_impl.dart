import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:ezmanagement/src/core/exceptions/failure.dart';
import 'package:ezmanagement/src/core/exceptions/sale_detail_exception.dart';
import 'package:ezmanagement/src/domain/entities/sale_detail_entity.dart';
import 'package:ezmanagement/src/domain/repositories/crud/sale_detail_repository.dart';

class SaleDetailRepositoryImpl extends SaleDetailRepository {
  SaleDetailRepositoryImpl({
    FirebaseFirestore? firestore,
    String collectionPath = 'sale_details',
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _collection =
            (firestore ?? FirebaseFirestore.instance).collection(collectionPath);

  final FirebaseFirestore _firestore;
  final CollectionReference<Map<String, dynamic>> _collection;

  // Usamos un ID compuesto para cada detalle: "<saleId>_<productId>"
  String _docIdFor(SaleDetailEntity e) => '${e.saleId}_${e.productId}';

  @override
  Future<Either<Failure, List<SaleDetailEntity>>> getAllElements() async {
    try {
      final snap = await _collection.get();
      final items = snap.docs
          .map((d) => SaleDetailEntity.fromMap(d.data(), d.id))
          .toList();
      return Right(items);
    } catch (_) {
      return Left(SaleDetailException());
    }
  }

  @override
  Future<Either<Failure, SaleDetailEntity>> getElementById({
    required String id, // esperado como "<saleId>_<productId>"
  }) async {
    try {
      final doc = await _collection.doc(id).get();
      if (!doc.exists) return Left(SaleDetailException());
      return Right(SaleDetailEntity.fromMap(doc.data()!, doc.id));
    } catch (_) {
      return Left(SaleDetailException());
    }
  }

  @override
  Future<Either<Failure, SaleDetailEntity>> createElement({
    required SaleDetailEntity t,
  }) async {
    try {
      final docRef = _collection.doc(_docIdFor(t));
      await docRef.set(t.toMap(), SetOptions(merge: false));
      return Right(t);
    } catch (_) {
      return Left(SaleDetailException());
    }
  }

  @override
  Future<Either<Failure, List<SaleDetailEntity>>> createElements({
    required List<SaleDetailEntity> ts,
  }) async {
    if (ts.isEmpty) return const Right([]);
    try {
      final batch = _firestore.batch();
      for (final e in ts) {
        final docRef = _collection.doc(_docIdFor(e));
        batch.set(docRef, e.toMap(), SetOptions(merge: false));
      }
      await batch.commit();
      return Right(ts);
    } catch (_) {
      return Left(SaleDetailException());
    }
  }

  @override
  Future<Either<Failure, SaleDetailEntity>> updateElement({
    required SaleDetailEntity t,
  }) async {
    try {
      await _collection.doc(_docIdFor(t)).update(t.toMap());
      return Right(t);
    } catch (_) {
      return Left(SaleDetailException());
    }
  }

  @override
  Future<Either<Failure, List<SaleDetailEntity>>> updateElements({
    required List<SaleDetailEntity> ts,
  }) async {
    if (ts.isEmpty) return const Right([]);
    try {
      final batch = _firestore.batch();
      for (final e in ts) {
        batch.update(_collection.doc(_docIdFor(e)), e.toMap());
      }
      await batch.commit();
      return Right(ts);
    } catch (_) {
      return Left(SaleDetailException());
    }
  }

  @override
  Future<Either<Failure, SaleDetailEntity>> deleteElement({
    required SaleDetailEntity t,
  }) async {
    try {
      await _collection.doc(_docIdFor(t)).delete();
      return Right(t);
    } catch (_) {
      return Left(SaleDetailException());
    }
  }

  @override
  Future<Either<Failure, List<SaleDetailEntity>>> deleteElements({
    required List<SaleDetailEntity> ts,
  }) async {
    if (ts.isEmpty) return const Right([]);
    try {
      final batch = _firestore.batch();
      for (final e in ts) {
        batch.delete(_collection.doc(_docIdFor(e)));
      }
      await batch.commit();
      return Right(ts);
    } catch (_) {
      return Left(SaleDetailException());
    }
  }
}
