
import 'package:floor/floor.dart';

import '../entity/cart_entity.dart';

@dao
abstract class CartDao {
  @Query('SELECT * FROM products')
  Future<List<CartEntity>> getCarts();

  @Query('SELECT * FROM products WHERE id = :id')
  Future<CartEntity?> getCartById(String id);

  @insert
  Future<void> insertToCart(CartEntity product);

  @insert
  Future<void> insertCarts(List<CartEntity> products);

  @update
  Future<void> updateCart(CartEntity product);

  @delete
  Future<void> removeCart(CartEntity product);

  @Query('DELETE FROM products')
  Future<void> clearCart();
}