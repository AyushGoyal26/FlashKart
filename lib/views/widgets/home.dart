import 'package:flutter/material.dart';
import 'package:grocery_app/models/product_data.dart';
import 'package:grocery_app/models/products.dart';
import 'package:grocery_app/shared/services/gps.dart';
import 'package:grocery_app/views/widgets/details_screen.dart';
import 'package:grocery_app/views/widgets/product_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GeolocatorService _geolocatorService = GeolocatorService();
  String _locationMessage = "";
  int _selectedCategoryIndex = 0;
  String _searchQuery = "";
  List<Product> _filteredProducts = MyProducts.allProducts;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _updateFilteredProducts();
  }

  Future<void> _getCurrentLocation() async {
    Map<String, String> locationData = await _geolocatorService.getCurrentLocation();
    setState(() {
      if (locationData.containsKey('error')) {
        _locationMessage = locationData['error']!;
      } else {
        _locationMessage = 'Latitude: ${locationData['latitude']}, Longitude: ${locationData['longitude']}\nAddress: ${locationData['address']}';
      }
    });
  }

  void _updateFilteredProducts() {
    setState(() {
      List<Product> products = _getCurrentProductList();
      _filteredProducts = products.where((product) {
        final name = product.name.toLowerCase();
        final query = _searchQuery.toLowerCase();
        return name.contains(query);
      }).toList();
    });
  }

  List<Product> _getCurrentProductList() {
    switch (_selectedCategoryIndex) {
      case 1:
        return MyProducts.Vegetables;
      case 2:
        return MyProducts.electronics;
      case 3:
        return MyProducts.cleaners;
      default:
        return MyProducts.allProducts;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.home),
        title: Text(
          _locationMessage,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: _buildSearchBar(),
        ),
        backgroundColor: const Color.fromARGB(221, 182, 176, 176),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Products",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            _buildCategorySelector(),
            const SizedBox(height: 20),
            Expanded(child: _buildProductGrid()),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(15),
        hintText: "Search...",
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      onChanged: (String value) {
        setState(() {
          _searchQuery = value;
          _updateFilteredProducts(); 
        });
      },
    );
  }

  Widget _buildCategorySelector() {
    final categories = ["All Products", "Vegetables", "Electronics", "Cleaners"];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(categories.length, (index) {
          return _buildCategoryItem(index, categories[index]);
        }),
      ),
    );
  }

  Widget _buildCategoryItem(int index, String name) {
    return GestureDetector(
      onTap: () => setState(() {
        _selectedCategoryIndex = index;
        _updateFilteredProducts(); 
      }),
      child: Container(
        width: 100,
        height: 40,
        margin: const EdgeInsets.only(top: 10, left: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _selectedCategoryIndex == index
              ? Color.fromARGB(221, 182, 176, 176)
              : Color.fromARGB(255, 225, 225, 222),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _selectedCategoryIndex == index ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildProductGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (100 / 140),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      scrollDirection: Axis.vertical,
      itemCount: _filteredProducts.length,
      itemBuilder: (context, index) {
        final product = _filteredProducts[index];
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailsScreen(product: product),
            ),
          ),
          child: ProductCard(product: product),
        );
      },
    );
  }
}
