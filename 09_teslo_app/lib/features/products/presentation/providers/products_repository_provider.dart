import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_app/features/auth/auth.dart';
import 'package:teslo_app/features/products/products.dart';

final productsRepositoryProvider = Provider<ProductsRepository>((ref) {
  final accessToken = ref.watch(authProvider).user?.token ?? '';

  final productsRepository = ProductsRepositoryImpl(
    ProductsDatasourceImpl(accessToken: accessToken),
  );

  return productsRepository;
});
