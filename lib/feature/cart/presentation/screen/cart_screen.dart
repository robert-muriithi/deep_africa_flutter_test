import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/sl/service_locator.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/ui_state.dart';
import '../cart_cubit.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => sl<CartCubit>()..getCart(),
         child: _buildBody(context)
    );
  }


  BlocConsumer<CartCubit, CartState> _buildBody(BuildContext context) {
    const imageBaseUrl = Constants.kImageBaseUrl;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state.uiState == UIState.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.exception ?? ''),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        final totalCost = state.carts.fold<double>(
          0,
          (previousValue, element) => previousValue + element.price,
        );
        return Scaffold(
          bottomNavigationBar: BottomAppBar(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: Kes ${totalCost.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CartCubit>().clearCart();
                      context.read<CartCubit>().getCart();
                    },
                    child: const Text('Checkout Cart'),
                  ),
                ],
              ),
            ),
          ),
          appBar: AppBar(
            title: const Text('Cart'),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            )
          ),
          body: state.uiState == UIState.loading
              ? const Center(child: CircularProgressIndicator())
              : state.uiState == UIState.success
                  ? RefreshIndicator(
                      onRefresh: () async {
                        context
                            .read<CartCubit>()
                            .getCart();
                      },
                      child: ListView.builder(
                        itemCount: state.carts.length,
                        itemBuilder: (context, index) {
                          final cart = state.carts[index];
                          final parsedText =
                              cart.description.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ') ?? '';

                          return Container(
                            margin: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  child: Image.network(
                                    '$imageBaseUrl${cart.image[0]}',
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cart.name ?? '',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        parsedText,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        'Price: ${cart.price}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    context.read<CartCubit>().removeFromCart(cart);
                                    context.read<CartCubit>().getCart();
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  : const Center(child: Text('No items in cart')),
        );
      },
    );
  }
}
