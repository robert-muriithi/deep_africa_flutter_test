import 'package:deep_africa_flutter_test/core/exceptions/exceptions.dart';
import 'package:deep_africa_flutter_test/core/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/dto/response_dto.dart';

abstract class ProductsRemoteDataSource {
  Future<ResponseDto> getProducts(
      {required String page, required String pageSize});
}

class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final Dio dio;

  ProductsRemoteDataSourceImpl({required this.dio});

  @override
  Future<ResponseDto> getProducts(
      {required String page, required String pageSize}) async {
    try {
      final response = await dio.get(
        '${Constants.kBaseUrl}products/latest',
        queryParameters: {
          'offset': page,
          'limit': pageSize,
          'ref_county': "047"
        },
      );
      return ResponseDto.fromJson(response.data);
    } catch (e) {
      if(kDebugMode){
        print('Error: $e');
      }
      throw ServerException(message: e.toString());
    }
  }
}
