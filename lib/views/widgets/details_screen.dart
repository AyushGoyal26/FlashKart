import 'package:flutter/material.dart';

import 'package:grocery_app/models/cart_notifier.dart';
import 'package:grocery_app/models/products.dart';
import 'package:grocery_app/views/widgets/cart_screen.dart';

import 'package:provider/provider.dart';


class DetailsScreen extends StatelessWidget {
  final Product product;
  const DetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    var obj=Provider.of<CartNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Details",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(221, 182, 176, 176),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            height: 100,
            width: double.infinity,
            child: Column(
              children: [
                Column(
                  
                  children: [
                      Text(
                      product.name.toUpperCase(),
                      style:
                        const  TextStyle(fontSize: 25, fontWeight: FontWeight.bold),

                        
                    ),
                    
                  ],
                ),
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
                child: Image.network(
                  product.image,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("M.R.P    Rs ${product.price}",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
              ],
            ),
          ),
          const  SizedBox(height: 20,),
          Text(product.description),
          
        ],
      ),

      bottomSheet: BottomAppBar(
        child: Container(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
          width: double.infinity,
          height: MediaQuery.of(context).size.height /5,
          decoration: BoxDecoration(
            color: Color.fromARGB(221, 182, 176, 176),
            borderRadius: BorderRadius.circular(8)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Rs ${product.price}",style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),


              ElevatedButton.icon(onPressed: (){
                obj.toogleProduct(product);
                Navigator.push(context, MaterialPageRoute(builder: (_)=>const CartScreen()));
              }, icon:const Icon(Icons.add),label: const Text("Add to cart"), )
            ],
          ),
        ),
      ),
    );
  }
}
