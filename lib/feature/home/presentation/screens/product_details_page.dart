
import 'package:deep_africa_flutter_test/feature/home/presentation/screens/product_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/model/ResponseModel.dart';
import '../../../../core/sl/service_locator.dart';
import '../../../../core/utils/constants.dart';
import 'package:flutter/material.dart';

import '../../../cart/presentation/cart_cubit.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductsModel product;

  const ProductDetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CartCubit>(),
      child: ProductDetails(product: product),
    );
  }
}
