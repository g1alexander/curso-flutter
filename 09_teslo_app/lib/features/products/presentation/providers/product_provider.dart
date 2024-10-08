import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_app/features/products/products.dart';

final productProvider = StateNotifierProvider.autoDispose
    .family<ProductNotifier, ProductState, String>((ref, productId) {
  final productRepository = ref.watch(productsRepositoryProvider);

  return ProductNotifier(
    productRepository: productRepository,
    productId: productId,
  );
});

class ProductNotifier extends StateNotifier<ProductState> {
  final ProductsRepository productRepository;

  ProductNotifier({
    required this.productRepository,
    required String productId,
  }) : super(ProductState(id: productId)) {
    loadProduct();
  }

  Product _newEmptyProduct() => Product(
        id: 'new',
        title: '',
        price: 0,
        description: '',
        slug: '',
        stock: 0,
        sizes: [],
        gender: 'men',
        tags: [],
        images: [],
      );

  Future<void> loadProduct() async {
    try {
      if (state.id == 'new') {
        state = state.copyWith(isLoading: false, product: _newEmptyProduct());
        return;
      }
      final product = await productRepository.getProductById(state.id);

      state = state.copyWith(isLoading: false, product: product);
    } catch (e) {
      print(e);
    }
  }
}

class ProductState {
  final String id;
  final Product? product;
  final bool isLoading;
  final bool isSaving;

  ProductState({
    required this.id,
    this.product,
    this.isLoading = true,
    this.isSaving = false,
  });

  ProductState copyWith({
    String? id,
    Product? product,
    bool? isLoading,
    bool? isSaving,
  }) =>
      ProductState(
        id: id ?? this.id,
        product: product ?? this.product,
        isLoading: isLoading ?? this.isLoading,
        isSaving: isSaving ?? this.isSaving,
      );
}
