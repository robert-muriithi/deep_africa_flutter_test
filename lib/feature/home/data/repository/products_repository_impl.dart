import 'package:dartz/dartz.dart';
import '../datasource/products_remote_datasource.dart';
import '../../domain/repository/products_repository.dart';
import '../../../../core/exceptions/failure.dart';
import '../../../../core/model/ResponseModel.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource productsRemoteDataSource;

  ProductsRepositoryImpl({required this.productsRemoteDataSource});

  @override
  Future<Either<Failure, List<ProductsModel>>> getProducts(
      {required String page, required String pageSize}) async {
    try {
      final response = await productsRemoteDataSource.getProducts(
          page: page, pageSize: pageSize);
      return Right(response.products ?? []);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
