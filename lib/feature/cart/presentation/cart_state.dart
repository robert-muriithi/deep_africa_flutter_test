part of 'cart_cubit.dart';

class CartState extends Equatable {
  final String? exception;
  final UIState uiState;
  final List<CartEntity> carts;
  const CartState({this.exception, this.uiState = UIState.initial, this.carts = const []});

  @override
  List<Object?> get props => [exception, uiState, carts];

  CartState copyWith({
    String? exception,
    UIState? uiState,
    List<CartEntity>? carts,
  }) {
    return CartState(
      exception: exception ?? this.exception,
      uiState: uiState ?? this.uiState,
      carts: carts ?? this.carts,
    );
  }
}


