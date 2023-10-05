import '../../../cart/presentation/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/colors.dart';
import '../../../../core/model/ResponseModel.dart';
import '../../../../core/sl/service_locator.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/ui_state.dart';
import '../../../cart/data/entity/cart_entity.dart';
import '../../../cart/presentation/screen/cart_screen.dart';

class ProductDetails extends StatelessWidget {
  final ProductsModel product;

  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    const imageBaseUrl = Constants.kImageBaseUrl;
    final parsedText =
        product.description?.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ') ?? '';
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    bool isAdded = false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        actions: [
          BlocBuilder(builder: (context, state) {
            return IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider.value(
                      value: BlocProvider.of<CartCubit>(context),
                      child: const CartScreen(),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
            );
          }
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              '$imageBaseUrl${product.image![0]}',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 300,
            ),
            const SizedBox(height: 10),
            Text(
              product.name ?? '',
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                parsedText.isEmpty ? 'No description' : parsedText,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 30),
            // Add to cart button
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? lightColorScheme.primaryContainer.withOpacity(0.5)
                    : darkColorScheme.primaryContainer.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                onPressed: () {
                  if (isAdded == false) {
                    BlocProvider.of<CartCubit>(context).addToCart(CartEntity(
                      id: product.id ?? 0,
                      name: product.name ?? '',
                      description: product.description ?? '',
                      price: product.price ?? 0,
                      image: product.image ?? [],
                    )).then((value) => isAdded = true);
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CartScreen()
                      ),
                    );
                  }
                },
                child: BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    if (state.uiState == UIState.loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.uiState == UIState.success) {
                      return Text(
                        isAdded ? 'Proceed to checkout' : 'Add to cart',
                        style:  TextStyle(
                          color: isAdded ? Colors.white : Colors.white,
                          fontSize: 18,
                        ),
                      );
                    } else {
                      return const Text(
                        'Add to cart',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            /*BlocBuilder<CartCubit, CartState>(builder: (context, state) {
               if (state.uiState == UIState.success) {
                // show checkout button
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? lightColorScheme.primaryContainer.withOpacity(0.5)
                        : darkColorScheme.primaryContainer.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                            value: BlocProvider.of<CartCubit>(context),
                            child: const CartScreen(),
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Checkout',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },*/
          ],
        ),
      ),
    );
  }

  void _dispatchAddToCart(BuildContext context, ProductsModel product) {

  }
}
