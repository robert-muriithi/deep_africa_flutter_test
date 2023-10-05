
import 'package:equatable/equatable.dart';

class ResponseModel extends Equatable {
  int? totalSize;
  String? limit;
  String? offset;
  List<ProductsModel>? products;

  ResponseModel({this.totalSize, this.limit, this.offset, this.products});

  @override
  List<Object?> get props => [
    totalSize,
    limit,
    offset,
    products,
  ];

}

class ProductsModel extends Equatable{
  int? id;
  String? name;
  String? description;
  List<String>? image;
  int? price;
  List<VariationsModel>? variations;
  int? tax;
  int? status;
  String? createdAt;
  String? updatedAt;
  List<String>? attributes;
  List<CategoryIdsModel>? categoryIds;
  List<ChoiceOptionsModel>? choiceOptions;
  int? discount;
  String? discountType;
  String? taxType;
  String? unit;
  int? totalStock;
  int? minOrderQty;
  int? wishlistCount;
  int? stockAroundMe;

  ProductsModel(
      {this.id,
        this.name,
        this.description,
        this.image,
        this.price,
        this.variations,
        this.tax,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.attributes,
        this.categoryIds,
        this.choiceOptions,
        this.discount,
        this.discountType,
        this.taxType,
        this.unit,
        this.totalStock,
        this.minOrderQty,
        this.wishlistCount,
        this.stockAroundMe,
        });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      description,
      image,
      price,
      variations,
      tax,
      status,
      createdAt,
      updatedAt,
      attributes,
      categoryIds,
      choiceOptions,
      discount,
      discountType,
      taxType,
      unit,
      totalStock,
      minOrderQty,
      wishlistCount,
      stockAroundMe,
    ];
  }
}

class VariationsModel extends Equatable {
  String? type;
  int? price;
  int? stock;

  VariationsModel({this.type, this.price, this.stock});

  @override
  List<Object?> get props {
    return [
      type,
      price,
      stock,
    ];
  }
}

class CategoryIdsModel extends Equatable{
  String? id;
  int? position;

  CategoryIdsModel({this.id, this.position});

  @override
  List<Object?> get props {
    return [
      id,
      position,
    ];
  }
}

class ChoiceOptionsModel extends Equatable {
  String? name;
  String? title;
  List<String>? options;

  ChoiceOptionsModel({this.name, this.title, this.options});

  @override
  List<Object?> get props {
    return [
      name,
      title,
      options,
    ];
  }
}
