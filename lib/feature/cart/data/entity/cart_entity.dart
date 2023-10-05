import 'package:deep_africa_flutter_test/core/dto/response_dto.dart';
import 'package:deep_africa_flutter_test/core/utils/constants.dart';
import 'package:floor/floor.dart';

@Entity(tableName: Constants.kProductTable)
class CartEntity {
  @primaryKey
  final int id;
  final String name;
  final String description;
  final List<String> image;
  final int price;

  CartEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
  });

  factory CartEntity.fromDto(Products products) {
    return CartEntity(
      id: products.id ?? 0,
      name: products.name ?? '',
      description: products.description ?? '',
      image: products.image ?? [],
      price: products.price ?? 0,
    );
  }

}
