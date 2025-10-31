import 'package:flutter/material.dart';
import '../../data/repositories/product_repository.dart';
import '../../data/models/product.dart';
import '../../widgets/product_card.dart';

class ProductSearch extends StatefulWidget {
  const ProductSearch({super.key});

  @override
  State<ProductSearch> createState() => _ProductSearchState();
}

class _ProductSearchState extends State<ProductSearch> {
  final ProductRepository _productRepository = MockProductRepository();
  final TextEditingController _searchController = TextEditingController();
  List<Product> _searchResults = [];
  bool _isLoading = false;
  String _lastSearchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _searchProducts(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _lastSearchQuery = query;
    });

    try {
      final results = await _productRepository.searchProductsBySeries(query);
      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error searching products: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Products'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by series (e.g., iphone, galaxy)',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _searchProducts('');
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                _searchProducts(value);
              },
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _searchResults.isEmpty && _lastSearchQuery.isNotEmpty
                    ? Center(
                        child: Text('No products found for "$_lastSearchQuery"'),
                      )
                    : _searchResults.isEmpty
                        ? const Center(
                            child: Text('Start typing to search for products'),
                          )
                        : GridView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16.0,
                              mainAxisSpacing: 16.0,
                              childAspectRatio: 0.75,
                            ),
                            itemCount: _searchResults.length,
                            itemBuilder: (context, index) {
                              return ProductCard(product: _searchResults[index]);
                            },
                          ),
          ),
        ],
      ),
    );
  }
}
