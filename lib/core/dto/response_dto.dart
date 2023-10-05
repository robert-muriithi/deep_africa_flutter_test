import '../model/ResponseModel.dart';

class ResponseDto {
  int? totalSize;
  String? limit;
  String? offset;
  List<Products>? products;

  ResponseDto({this.totalSize, this.limit, this.offset, this.products});

  factory ResponseDto.fromJson(Map<String, dynamic> json) {
    return ResponseDto(
      totalSize: json['total_size'],
      limit: json['limit'],
      offset: json['offset'],
      products: json['products'] != null
          ? (json['products'] as List).map((i) => Products.fromJson(i)).toList()
          : null,
    );
  }
}

class Products extends ProductsModel{
  Products({
    required super.id,
    required super.name,
    required super.description,
    required super.image,
    required super.price,
    required super.variations,
    required super.tax,
    required super.status,
    required super.createdAt,
    required super.updatedAt,
    required super.attributes,
    required super.categoryIds,
    required super.choiceOptions,
    required super.discount,
    required super.discountType,
    required super.taxType,
    required super.unit,
    required super.totalStock,
    required super.minOrderQty,
    required super.wishlistCount,
    required super.stockAroundMe,
});


  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'].cast<String>(),
      price: json['price'],
      variations: json['variations'] != null
          ? (json['variations'] as List).map((i) => Variations.fromJson(i)).toList()
          : null,
      tax: json['tax'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      attributes: json['attributes'].cast<String>(),
      categoryIds: json['category_ids'] != null
          ? (json['category_ids'] as List).map((i) => CategoryIds.fromJson(i)).toList()
          : null,
      choiceOptions: json['choice_options'] != null
          ? (json['choice_options'] as List).map((i) => ChoiceOptions.fromJson(i)).toList()
          : null,
      discount: json['discount'],
      discountType: json['discount_type'],
      taxType: json['tax_type'],
      unit: json['unit'],
      totalStock: json['total_stock'],
      minOrderQty: json['min_order_qty'],
      wishlistCount: json['wishlist_count'],
      stockAroundMe: json['stock_around_me'],
    );

  }

}

class Variations extends VariationsModel {

  Variations({required super.type, required super.price, required super.stock});

  factory Variations.fromJson(Map<String, dynamic> json) {
    return Variations(
      type: json['type'],
      price: json['price'],
      stock: json['stock'],
    );
  }


}

class CategoryIds extends CategoryIdsModel {


  CategoryIds({required super.id, required super.position});

  factory CategoryIds.fromJson(Map<String, dynamic> json) {
    return CategoryIds(
      id: json['id'],
      position: json['position'],
    );
  }

}

class ChoiceOptions extends ChoiceOptionsModel {


  ChoiceOptions({required super.name, required super.title, required super.options});

  factory ChoiceOptions.fromJson(Map<String, dynamic> json) {
    return ChoiceOptions(
      name: json['name'],
      title: json['title'],
      options: json['options'].cast<String>(),
    );
  }
}
