
import 'package:deep_africa_flutter_test/core/database/type_converter.dart';
import 'package:floor/floor.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../feature/cart/data/dao/products_dao.dart';
import '../../feature/cart/data/entity/cart_entity.dart';

part 'cart_data_base.g.dart';

@TypeConverters([ImagesTypeConverters])
@Database(version: 1, entities: [CartEntity])
abstract class CartDatabase extends FloorDatabase {
  CartDao get productsDao;
}