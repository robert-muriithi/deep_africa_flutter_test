part of 'products_cubit.dart';

class ProductsState extends Equatable {
  final String? exception;
  final UIState uiState;
  final List<ProductsModel> products;
  const ProductsState({this.exception, this.uiState = UIState.initial, this.products = const []});

  @override
  List<Object?> get props => [exception, uiState, products];

  ProductsState copyWith({
    String? exception,
    UIState? uiState,
    List<ProductsModel>? products,
  }) {
    return ProductsState(
      exception: exception ?? this.exception,
      uiState: uiState ?? this.uiState,
      products: products ?? this.products,
    );
  }

}


