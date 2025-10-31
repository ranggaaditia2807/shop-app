import '../models/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getAllProducts();
  Future<List<Product>> getTrendingProducts();
  Future<List<Product>> searchProductsBySeries(String series);
  Future<Product?> getProductById(String id);
}

class MockProductRepository implements ProductRepository {
  final List<Product> _mockProducts = [
    Product(
      id: '1',
      name: 'iPhone 15 Pro',
      description: 'Latest iPhone with advanced features',
      price: 999.99,
      imageUrl: 'https://example.com/iphone15pro.jpg',
      category: 'Smartphones',
      series: 'iphone',
      isTrending: true,
    ),
    Product(
      id: '2',
      name: 'iPhone 15',
      description: 'Powerful iPhone for everyday use',
      price: 799.99,
      imageUrl: 'https://example.com/iphone15.jpg',
      category: 'Smartphones',
      series: 'iphone',
      isTrending: true,
    ),
    Product(
      id: '3',
      name: 'Samsung Galaxy S24',
      description: 'Android flagship smartphone',
      price: 899.99,
      imageUrl: 'https://example.com/galaxys24.jpg',
      category: 'Smartphones',
      series: 'galaxy',
      isTrending: true,
    ),
    Product(
      id: '4',
      name: 'MacBook Pro 16"',
      description: 'Professional laptop for creators',
      price: 2499.99,
      imageUrl: 'https://example.com/macbookpro.jpg',
      category: 'Laptops',
      series: 'macbook',
      isTrending: false,
    ),
    Product(
      id: '5',
      name: 'iPad Air',
      description: 'Versatile tablet for work and play',
      price: 599.99,
      imageUrl: 'https://example.com/ipadair.jpg',
      category: 'Tablets',
      series: 'ipad',
      isTrending: false,
    ),
  ];

  @override
  Future<List<Product>> getAllProducts() async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
    return _mockProducts;
  }

  @override
  Future<List<Product>> getTrendingProducts() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockProducts.where((product) => product.isTrending).toList();
  }

  @override
  Future<List<Product>> searchProductsBySeries(String series) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _mockProducts
        .where((product) => product.series.toLowerCase().contains(series.toLowerCase()))
        .toList();
  }

  @override
  Future<Product?> getProductById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _mockProducts.firstWhere((product) => product.id == id);
  }
}
