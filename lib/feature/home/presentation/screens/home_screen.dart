import 'package:deep_africa_flutter_test/config/colors.dart';
import 'package:deep_africa_flutter_test/feature/cart/presentation/screen/cart_screen.dart';
import 'package:deep_africa_flutter_test/feature/home/presentation/screens/product_details.dart';
import 'package:deep_africa_flutter_test/feature/home/presentation/screens/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/sl/service_locator.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/ui_state.dart';
import '../cubits/products_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  int _currentPage = 1;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMoreData();
    }
  }

  void _loadMoreData() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    await context.read<ProductsCubit>().getProducts(
      page: (_currentPage + 1).toString(),
      pageSize: '12',
    );
    setState(() {
      _currentPage++;
      _isLoading = false;
      //context.read<ProductsCubit>().addProducts(products);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          sl<ProductsCubit>()..getProducts(page: '1', pageSize: '12'),
        ),
      ],
      child: BlocConsumer<ProductsCubit, ProductsState>(
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
          return Scaffold(
            appBar: AppBar(
              title: const Text('Products'),
              actions: [
                IconButton(
                  onPressed: () {
                    context
                        .read<ProductsCubit>()
                        .getProducts(page: '1', pageSize: '12');
                  },
                  icon: const Icon(Icons.refresh),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CartScreen()));
                    },
                    icon: const Icon(Icons.shopping_basket_outlined))
              ],
            ),
            body: state.uiState == UIState.loading && _currentPage == 1
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  _currentPage = 1;
                });
                context
                    .read<ProductsCubit>()
                    .getProducts(page: '1', pageSize: '12');
              },
              child: ListView.builder(
                controller: _scrollController,
                itemCount: state.products.length + (_isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == state.products.length && _isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final product =
                  state.products[index % state.products.length];
                  const imageBaseUrl = Constants.kImageBaseUrl;
                  final parsedText = product.description
                      ?.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ') ??
                      '';

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailsPage(product: product)));
                    },
                    child: Container(
                      height: 100,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? lightColorScheme.onSurface.withOpacity(0.5)
                            : darkColorScheme.onSurface.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 100,
                                child: ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(8),
                                  child: Image.network(
                                    '$imageBaseUrl${product.image?[0] ?? ''}',
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name ?? '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                    parsedText.isEmpty
                                        ? 'No description'
                                        : parsedText,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w300,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 2),
                                const SizedBox(height: 10),
                                Text(
                                  'Ksh ${product.price ?? ''}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

