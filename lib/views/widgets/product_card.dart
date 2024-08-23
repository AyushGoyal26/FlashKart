import 'package:flutter/material.dart';
import 'package:grocery_app/models/products.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  const ProductCard({super.key,required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.withOpacity(0.1),
      ),
      child: Column(
        children: [
          
          SizedBox(
            height: 130,
            width: 130,
            child: Image.network(widget.product.image,fit: BoxFit.cover ,),
          ),
          Text(widget.product.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          Text("Rs ${widget.product.price}"),
        ],
      ),
    );
  }
}