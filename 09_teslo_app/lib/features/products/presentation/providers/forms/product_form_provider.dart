import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_app/config/config.dart';
import 'package:teslo_app/features/products/products.dart';
import 'package:teslo_app/features/shared/shared.dart';

final productFormProvider = StateNotifierProvider.autoDispose
    .family<ProductFormNotifier, ProductFormState, Product>((ref, product) {
  //TODO: create update function

  return ProductFormNotifier(
    product: product,
    // onSubmitCallback:
  );
});

class ProductFormNotifier extends StateNotifier<ProductFormState> {
  final void Function(Map<String, dynamic> productLike)? onSubmitCallback;

  ProductFormNotifier({
    this.onSubmitCallback,
    required Product product,
  }) : super(ProductFormState(
          id: product.id,
          title: Title.dirty(product.title),
          slug: Slug.dirty(product.slug),
          inStock: Stock.dirty(product.stock),
          price: Price.dirty(product.price),
          sizes: product.sizes,
          gender: product.gender,
          description: product.description,
          tags: product.tags.join(', '),
          images: product.images,
        ));

  Future<bool> onFormSubmit() async {
    _touchedEverything();

    if (!state.isFormValid) return false;
    if (onSubmitCallback == null) return false;

    final productLike = {
      'id': state.id,
      'title': state.title.value,
      'price': state.price.value,
      'description': state.description,
      'slug': state.slug.value,
      'stock': state.inStock.value,
      'sizes': state.sizes,
      'gender': state.gender,
      'tags': state.tags.split(','),
      'images': state.images
          .map((image) =>
              image.replaceAll('${Environment.apiUrl}/files/product/', ''))
          .toList()
    };

    //TODO: submit

    return true;
  }

  void _touchedEverything() {
    state = state.copyWith(
        isFormValid: Formz.validate([
      Title.dirty(state.title.value),
      Slug.dirty(state.slug.value),
      Stock.dirty(state.inStock.value),
      Price.dirty(state.price.value)
    ]));
  }

  void onTitleChanged(String value) {
    state = state.copyWith(
        title: Title.dirty(value),
        isFormValid: Formz.validate([
          Title.dirty(value),
          Slug.dirty(state.slug.value),
          Stock.dirty(state.inStock.value),
          Price.dirty(state.price.value)
        ]));
  }

  void onSlugChanged(String value) {
    state = state.copyWith(
        slug: Slug.dirty(value),
        isFormValid: Formz.validate([
          Slug.dirty(value),
          Title.dirty(state.title.value),
          Stock.dirty(state.inStock.value),
          Price.dirty(state.price.value)
        ]));
  }

  void onStockChanged(int value) {
    state = state.copyWith(
        inStock: Stock.dirty(value),
        isFormValid: Formz.validate([
          Stock.dirty(value),
          Slug.dirty(state.slug.value),
          Title.dirty(state.title.value),
          Price.dirty(state.price.value)
        ]));
  }

  void onPriceChanged(double value) {
    state = state.copyWith(
        price: Price.dirty(value),
        isFormValid: Formz.validate([
          Price.dirty(value),
          Slug.dirty(state.slug.value),
          Stock.dirty(state.inStock.value),
          Title.dirty(state.title.value)
        ]));
  }

  void onSizeChanged(List<String> sizes) {
    state = state.copyWith(size: sizes);
  }

  void onGenderChanged(String gender) {
    state = state.copyWith(gender: gender);
  }

  void onDescriptionChanged(String description) {
    state = state.copyWith(description: description);
  }

  void onTagsChanged(String tags) {
    state = state.copyWith(tags: tags);
  }
}

class ProductFormState {
  final bool isFormValid;
  final String? id;
  final Title title;
  final Slug slug;
  final Stock inStock;
  final Price price;
  final List<String> sizes;
  final String gender;
  final String description;
  final String tags;
  final List<String> images;

  ProductFormState({
    this.isFormValid = false,
    this.id,
    this.title = const Title.dirty(''),
    this.slug = const Slug.dirty(''),
    this.inStock = const Stock.dirty(0),
    this.price = const Price.dirty(0),
    this.sizes = const [],
    this.gender = 'men',
    this.description = '',
    this.tags = '',
    this.images = const [],
  });

  ProductFormState copyWith({
    bool? isFormValid,
    String? id,
    Title? title,
    Slug? slug,
    Stock? inStock,
    Price? price,
    List<String>? size,
    String? gender,
    String? description,
    String? tags,
    List<String>? images,
  }) =>
      ProductFormState(
        isFormValid: isFormValid ?? this.isFormValid,
        id: id ?? this.id,
        title: title ?? this.title,
        slug: slug ?? this.slug,
        inStock: inStock ?? this.inStock,
        price: price ?? this.price,
        sizes: size ?? this.sizes,
        gender: gender ?? this.gender,
        description: description ?? this.description,
        tags: tags ?? this.tags,
        images: images ?? this.images,
      );
}
