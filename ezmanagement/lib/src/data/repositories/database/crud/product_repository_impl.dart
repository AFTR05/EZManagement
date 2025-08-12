import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:ezmanagement/src/core/exceptions/failure.dart';
import 'package:ezmanagement/src/core/exceptions/product_exception.dart';
import 'package:ezmanagement/src/domain/entities/product_entity.dart';
import 'package:ezmanagement/src/domain/repositories/crud/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  ProductRepositoryImpl({
    FirebaseFirestore? firestore,
    String collectionPath = 'products',
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _collection =
            (firestore ?? FirebaseFirestore.instance).collection(collectionPath);

  final FirebaseFirestore _firestore;
  final CollectionReference<Map<String, dynamic>> _collection;

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllElements() async {
    try {
      final snap = await _collection.get();
      final items = snap.docs
          .map((d) => ProductEntity.fromMap(d.data(), d.id))
          .toList();
      return Right(items);
    } catch (_) {
      return Left(ProductException());
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getElementById({
    required String id,
  }) async {
    try {
      final doc = await _collection.doc(id).get();
      if (!doc.exists) return Left(ProductException());
      return Right(ProductEntity.fromMap(doc.data()!, doc.id));
    } catch (_) {
      return Left(ProductException());
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> createElement({
    required ProductEntity t,
  }) async {
    try {
      final docRef = t.id.isEmpty ? _collection.doc() : _collection.doc(t.id);

      // Si tienes copyWith({id}), úsalo. Aquí rehidratamos desde el map con el nuevo id.
      final newEntity =
          t.id.isEmpty ? ProductEntity.fromMap(t.toMap(), docRef.id) : t;

      await docRef.set(newEntity.toMap(), SetOptions(merge: false));
      return Right(newEntity);
    } catch (_) {
      return Left(ProductException());
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> createElements({
    required List<ProductEntity> ts,
  }) async {
    if (ts.isEmpty) return const Right([]);
    try {
      final batch = _firestore.batch();
      final created = <ProductEntity>[];

      for (final p in ts) {
        final docRef = p.id.isEmpty ? _collection.doc() : _collection.doc(p.id);
        final newEntity =
            p.id.isEmpty ? ProductEntity.fromMap(p.toMap(), docRef.id) : p;

        batch.set(docRef, newEntity.toMap(), SetOptions(merge: false));
        created.add(newEntity);
      }

      await batch.commit();
      return Right(created);
    } catch (_) {
      return Left(ProductException());
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> updateElement({
    required ProductEntity t,
  }) async {
    try {
      await _collection.doc(t.id).update(t.toMap());
      return Right(t);
    } catch (_) {
      return Left(ProductException());
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> updateElements({
    required List<ProductEntity> ts,
  }) async {
    if (ts.isEmpty) return const Right([]);
    try {
      final batch = _firestore.batch();
      for (final p in ts) {
        batch.update(_collection.doc(p.id), p.toMap());
      }
      await batch.commit();
      return Right(ts);
    } catch (_) {
      return Left(ProductException());
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> deleteElement({
    required ProductEntity t,
  }) async {
    try {
      await _collection.doc(t.id).delete();
      return Right(t);
    } catch (_) {
      return Left(ProductException());
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> deleteElements({
    required List<ProductEntity> ts,
  }) async {
    if (ts.isEmpty) return const Right([]);
    try {
      final batch = _firestore.batch();
      for (final p in ts) {
        batch.delete(_collection.doc(p.id));
      }
      await batch.commit();
      return Right(ts);
    } catch (_) {
      return Left(ProductException());
    }
  }
}
