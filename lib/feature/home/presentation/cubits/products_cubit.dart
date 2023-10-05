import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deep_africa_flutter_test/core/utils/failure_mapper.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/model/ResponseModel.dart';
import '../../../../core/utils/ui_state.dart';
import '../../domain/repository/products_repository.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepository productsRepository;
  ProductsCubit({required this.productsRepository}) : super(const ProductsState());

  FutureOr<void> getProducts({required String page, required String pageSize}) async {
    emit(state.copyWith(uiState: UIState.loading));
    final response = await productsRepository.getProducts(page: page, pageSize: pageSize);
    response.fold(
      (failure) => emit(state.copyWith(exception: mapFailureToMessage(failure), uiState: UIState.error)),
      (products) => emit(state.copyWith(products: products, uiState: UIState.success)),
    );
  }
}
