import 'package:flutter/material.dart';
import 'package:json_getter/json_getter.dart';

import 'data.mocks.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter JSON Getter Example',
      debugShowCheckedModeBanner: false,
      home: ExampleScreen(),
    );
  }
}

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({super.key});

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  ValueNotifier<List<Product>> productList = ValueNotifier([]);

  Future<void> _getProducts() async {
    productList.value = productJsonMock
        .map((json) => Product.fromJson(json, filters: filtersConfigMock))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (Navigator.canPop(context)) ? AppBar() : null,
      body: ValueListenableBuilder(
        valueListenable: productList,
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) {
              return ProductCard(product: value[index]);
            },
          );
        },
      ),
    );
  }
}

class Product {
  Product({
    this.name,
    this.price,
    this.image,
    this.customFields,
  });

  factory Product.fromJson(
    Map<String, dynamic> json, {
    Map<String, Map<String, List<Map<String, String?>>>>? filters,
  }) {
    final name = json['name']?.toString();

    final price = json['price']?.toString();

    final images = json['images'];
    final image = (images is List<Map> && images.isNotEmpty)
        ? images[0]['src']?.toString()
        : null;

    final customFields = filters?.map(
      (key, filter) {
        return MapEntry(
          key,
          JsonGetter.get(
            filters: FiltersMapper.fromMap(filter),
            json: json,
          ),
        );
      },
    );

    return Product(
      name: name,
      price: price,
      image: image,
      customFields: customFields,
    );
  }

  final String? name;
  final String? image;
  final String? price;

  /// Custom fields from json_getter filters
  final Map<String, dynamic>? customFields;
}

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  Widget _renderProductDetails(Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (product.name != null) Text(product.name!),
        if (product.price != null) Text('Price: \$${product.price}'),
        if (product.customFields?['categories']?.toString().isNotEmpty ?? false)
          Text(
            'Categories: ${product.customFields?['categories']}',
          ),
        if (product.customFields?['tags']?.toString().isNotEmpty ?? false)
          Text('Tags: ${product.customFields?['tags']}'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: (screenSize.width > 720 || isLandscape)
          ? Row(
              spacing: 8,
              children: [
                if (product.image != null)
                  Flexible(child: Image.network(product.image!)),
                _renderProductDetails(product),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (product.image != null) Image.network(product.image!),
                _renderProductDetails(product),
              ],
            ),
    );
  }
}
