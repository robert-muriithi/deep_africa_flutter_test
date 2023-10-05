import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../feature/cart/data/datasource/local_data_source.dart';
import '../../feature/cart/data/repository/cart_repository_impl.dart';
import '../../feature/cart/domain/repository/cart_repository.dart';
import '../../feature/cart/presentation/cart_cubit.dart';
import '../../feature/home/data/datasource/products_remote_datasource.dart';
import '../../feature/home/data/repository/products_repository_impl.dart';
import '../../feature/home/domain/repository/products_repository.dart';
import '../../feature/home/presentation/cubits/products_cubit.dart';
import '../database/cart_data_base.dart';

final sl = GetIt.instance;

Future<void> init() async {
  initFeatures();
  await initExternal();
}

void initFeatures() {
  //Cubits
  sl.registerFactory<ProductsCubit>(() => ProductsCubit(productsRepository: sl()));
  sl.registerFactory<CartCubit>(() => CartCubit( repository: sl()));


  //Repositories
  sl.registerLazySingleton<ProductsRepository>(() => ProductsRepositoryImpl(productsRemoteDataSource: sl()));
  sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(cartDataSource: sl()));


  //DataSources
  sl.registerLazySingleton<ProductsRemoteDataSource>(() => ProductsRemoteDataSourceImpl(dio: sl()));
  sl.registerLazySingleton<CartDataSource>(() => CartDataSourceImpl(database: sl()));

}

Future<void> initExternal() async {

  sl.registerFactory<Dio>(() {
    Dio dio = Dio();
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
    return dio;
  });

  final database = await $FloorCartDatabase
      .databaseBuilder('cart.db')
      .build();

  sl.registerFactory(() => database);

}

