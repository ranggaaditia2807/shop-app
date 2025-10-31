import 'package:flutter/material.dart';
import '../../data/repositories/product_repository.dart';
import '../../data/models/product.dart';
import '../../widgets/product_card.dart';

class MarketplaceDashboard extends StatefulWidget {
  const MarketplaceDashboard({super.key});

  @override
  State<MarketplaceDashboard> createState() => _MarketplaceDashboardState();
}

class _MarketplaceDashboardState extends State<MarketplaceDashboard> {
  final ProductRepository _productRepository = MockProductRepository();
  List<Product> _trendingProducts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTrendingProducts();
  }

  Future<void> _loadTrendingProducts() async {
    try {
      final products = await _productRepository.getTrendingProducts();
      setState(() {
        _trendingProducts = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading products: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marketplace'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).pushNamed('/search');
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.of(context).pushNamed('/profile');
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Trending Products',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _trendingProducts.isEmpty
                      ? const Center(child: Text('No trending products available'))
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16.0,
                            mainAxisSpacing: 16.0,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: _trendingProducts.length,
                          itemBuilder: (context, index) {
                            return ProductCard(product: _trendingProducts[index]);
                          },
                        ),
                ],
              ),
            ),
    );
  }
}
