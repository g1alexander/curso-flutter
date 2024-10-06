import 'package:teslo_app/config/config.dart';
import 'package:teslo_app/features/products/products.dart';

class ProductsDatasourceImpl extends ProductsDatasource {
  final String accessToken;

  ProductsDatasourceImpl({required this.accessToken});

  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike) async {
    try {
      final String? id = productLike['id'];
      final String method = id == null ? 'POST' : 'PATCH';
      final String url = id == null ? '/products' : '/products/$id';

      productLike.remove('id');

      final response = await Api(accessToken: accessToken).request(
        url,
        data: productLike,
        method: method,
      );

      return ProductMapper.jsonToEntity(response.data);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<Product> getProductById(String id) async {
    try {
      final response = await Api().get('/products/$id');

      return ProductMapper.jsonToEntity(response.data);
    } on ErrorApi catch (e) {
      if (e.response?.statusCode == 404) {
        throw ProductNotFound();
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<Product>> getProductsByPage(
      {int limit = 10, int offset = 0}) async {
    final response =
        await Api().get<List?>('/products?limit=$limit&offset=$offset');

    final List<Product> products = [];

    for (final product in response.data ?? []) {
      products.add(ProductMapper.jsonToEntity(product));
    }

    return products;
  }

  @override
  Future<List<Product>> searchProductByTerm(String term) {
    // TODO: implement searchProductByTerm
    throw UnimplementedError();
  }
}
