
import 'package:dartz/dartz.dart';
import 'package:deep_africa_flutter_test/core/model/ResponseModel.dart';

import '../../../../core/exceptions/failure.dart';

abstract class ProductsRepository {
  Future<Either<Failure, List<ProductsModel>>> getProducts({required String page, required String pageSize});
}