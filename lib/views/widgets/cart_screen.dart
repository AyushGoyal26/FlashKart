import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:grocery_app/models/cart_notifier.dart';
import 'package:grocery_app/views/widgets/main_screen.dart';
import 'package:grocery_app/views/widgets/payment.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final obj=CartNotifier.of(context);
    double amount = obj.getTprice();
    final flist=obj.cart;

    _productQuantity(IconData icon,int index){
      return GestureDetector(
        onTap: (){
          setState(() {
            icon==Icons.add?obj.inc(index):obj.dec(index);
          });
        },
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Icon(icon,size: 20,),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (_)=>const MainScreen()));
        }, icon:const Icon(Icons.home)) ,
        title:const Text("MY cart",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(221, 182, 176, 176),
      ),

      body: Column(children: [
        Expanded(child: ListView.builder(
          itemCount: flist.length,
          itemBuilder: (context,index){
          return Padding(padding: const EdgeInsets.all(8),
            child: Slidable(
              endActionPane: ActionPane(motion: const ScrollMotion(), children:[
                SlidableAction(onPressed: (context){
                  flist[index].quantity=1;
                  flist.removeAt(index);
                  setState(() {
                    
                  });
                },
                backgroundColor: Colors.red,
                icon: Icons.delete,
                label: "Delete",

                )
              ]),
              child: ListTile(
                title: Text(flist[index].name,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                subtitle: Text(flist[index].description),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(flist[index].image),   
              ),
              trailing: Column(
                children: [
                  _productQuantity(Icons.add, index),
                  Text(flist[index].quantity.toString()),
                  _productQuantity(Icons.remove, index),
                ],
              ),
              ),
            ),
          );
        })),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Rs ${obj.getTprice()}",style:  const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),

              ElevatedButton.icon(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Razorpaye(amount:amount)));
              },icon: Icon(Icons.send), label: Text("Check out"))
            ],
          ),
        )
      ],),
    );
  }
}