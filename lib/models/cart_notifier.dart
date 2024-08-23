

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/products.dart';

class CartNotifier extends ChangeNotifier{
  final List<Product> _cart=[];
  List<Product> get cart=>_cart;

  void toogleProduct(Product product){
    if(_cart.contains(product)){
      for(Product element in _cart){
        element.quantity++;
      }
    }else{
      _cart.add(product);
    }
    notifyListeners();
  }
  inc(int index)=>_cart[index].quantity++;
  dec(int index)=>_cart[index].quantity>1?_cart[index].quantity--:_cart.removeAt(index);

  getTprice(){
    double total=0.0;
    for(Product el in _cart){
      total+=el.price*el.quantity;
    }
    return total;
  }

  static CartNotifier of(
    BuildContext context,
    {bool listen=true,}
  ){
    return Provider.of<CartNotifier>(context,listen:listen);
  }
}