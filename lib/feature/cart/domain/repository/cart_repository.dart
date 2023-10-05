

import 'package:dartz/dartz.dart';
import 'package:deep_africa_flutter_test/core/exceptions/failure.dart';

import '../../data/entity/cart_entity.dart';

abstract class CartRepository {
  /*Future<void> addToCart(CartEntity product);
  Future<void> removeFromCart(String productId);
  Future<void> clearCart();
  Future<List<CartEntity>> getCart();*/
  Future<Either<Failure, void>> addToCart(CartEntity product);
  Future<Either<Failure, void>> removeFromCart(CartEntity item);
  Future<Either<Failure, void>> clearCart();
  Future<Either<Failure, List<CartEntity>>> getCart();
}