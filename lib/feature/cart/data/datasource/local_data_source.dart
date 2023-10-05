
import 'package:deep_africa_flutter_test/feature/cart/data/entity/cart_entity.dart';

import '../../../../core/database/cart_data_base.dart';
import '../../../../core/exceptions/exceptions.dart';

abstract class CartDataSource {
  Future<void> addToCart(CartEntity product);
  Future<void> removeFromCart(CartEntity product);
  Future<void> clearCart();
  Future<List<CartEntity>> getCart();
}

class CartDataSourceImpl implements CartDataSource {
  final CartDatabase database;

  CartDataSourceImpl({required this.database});

  @override
  Future<List<CartEntity>> getCart() async {
    try{
      return await database.productsDao.getCarts();
    } catch(e) {
      throw DatabaseException(message: e.toString());
    }
  }

  @override
  Future<void> clearCart() async {
    try{
      return await database.productsDao.clearCart();
    } catch(e) {
      throw DatabaseException(message: e.toString());
    }
  }

  @override
  Future<void> removeFromCart(CartEntity product) async {
    try{
      return await database.productsDao.removeCart(product);
    } catch(e) {
      throw DatabaseException(message: e.toString());
    }
  }

  @override
  Future<void> addToCart(CartEntity product) {
    try{
      return database.productsDao.insertToCart(product);
    } catch(e) {
      throw DatabaseException(message: e.toString());
    }
  }
}