import 'package:bloc/bloc.dart';
import 'package:deep_africa_flutter_test/core/utils/failure_mapper.dart';
import 'package:deep_africa_flutter_test/feature/cart/data/entity/cart_entity.dart';
import 'package:equatable/equatable.dart';

import '../../../core/utils/ui_state.dart';
import '../domain/repository/cart_repository.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository repository;
  CartCubit({required this.repository}) : super(const CartState());

  Future<void> addToCart(CartEntity product) async {
    emit(state.copyWith(uiState: UIState.loading));
    final result = await repository.addToCart(product);
    result.fold(
      (failure) => emit(state.copyWith(uiState: UIState.error, exception: mapFailureToMessage(failure))),
      (_) => emit(state.copyWith(uiState: UIState.success))
    );
  }

  Future<void> removeFromCart(CartEntity item) async {
    emit(state.copyWith(uiState: UIState.loading));
    final result = await repository.removeFromCart(item);
    result.fold(
      (failure) => emit(state.copyWith(uiState: UIState.error, exception: mapFailureToMessage(failure))),
      (_) => emit(state.copyWith(uiState: UIState.success))
    );
  }

  Future<void> clearCart() async {
    emit(state.copyWith(uiState: UIState.loading));
    final result = await repository.clearCart();
    result.fold(
      (failure) => emit(state.copyWith(uiState: UIState.error, exception: mapFailureToMessage(failure))),
      (_) => emit(state.copyWith(uiState: UIState.success))
    );
  }

  Future<void> getCart() async {
    emit(state.copyWith(uiState: UIState.loading));
    final result = await repository.getCart();
    result.fold(
      (failure) => emit(state.copyWith(uiState: UIState.error, exception: mapFailureToMessage(failure))),
      (carts) => emit(state.copyWith(uiState: UIState.success, carts: carts))
    );
  }

}
