

import 'package:dartz/dartz.dart';
import 'package:deep_africa_flutter_test/feature/cart/domain/repository/cart_repository.dart';

import '../../../../core/exceptions/exceptions.dart';
import '../../../../core/exceptions/failure.dart';
import '../datasource/local_data_source.dart';
import '../entity/cart_entity.dart';

class CartRepositoryImpl implements CartRepository {
  final CartDataSource cartDataSource;

  CartRepositoryImpl({required this.cartDataSource});

  @override
  Future<Either<Failure, List<CartEntity>>> getCart() async {
    try{
      final cart = await cartDataSource.getCart();
      return Right(cart);
    } on DatabaseException catch(e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> clearCart() async {
    try{
      final cart = await cartDataSource.clearCart();
      return Right(cart);
    } on DatabaseException catch(e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromCart(CartEntity item) async {
    try{
      final cart = await cartDataSource.removeFromCart(item);
      return Right(cart);
    } on DatabaseException catch(e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> addToCart(CartEntity product) async {
    try{
      final cart = await cartDataSource.addToCart(product);
      return Right(cart);
    } on DatabaseException catch(e) {
      return Left(DatabaseFailure(e.message));
    }
  }
}