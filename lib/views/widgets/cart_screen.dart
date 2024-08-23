import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_app/models/cart_notifier.dart';
import 'package:grocery_app/views/widgets/main_screen.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Razorpay _razorpay;
  void chkout(amount)async{
    amount = amount*100;
      var options = {
        'key':'rzp_test_1DP5mmOlF5G5ag',
        'amount': amount,
        'name':'Flashkart',
        'prefill':{'contact':'123456789','email':'Flashkart@gmail.com'},
        'external':{
          'wallets':['paytm']
        }
      };
  try{
    _razorpay.open(options);
  }catch(e){
    debugPrint('Error : e');
  }
  }
  void handlepayment(PaymentSuccessResponse response){
    Fluttertoast.showToast(msg: 'payment Successful'+response.paymentId!,toastLength: Toast.LENGTH_SHORT);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen()));

  }
  void handlepaymenterror(PaymentFailureResponse response){
    Fluttertoast.showToast(msg: 'payment Fail'+response.message!,toastLength: Toast.LENGTH_SHORT);


  }
  void handleexternalwallet(ExternalWalletResponse response){
    Fluttertoast.showToast(msg: 'External Wallet'+response.walletName!,toastLength: Toast.LENGTH_SHORT);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,handlepayment);
_razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlepaymenterror);
_razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleexternalwallet);
  }
  @override
  Widget build(BuildContext context) {
    final obj=CartNotifier.of(context);
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
        leading: const Icon(Icons.shopping_bag) ,
        title:const Text("MY cart",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
        centerTitle: true,
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
                chkout(obj.getTprice());
              },icon: Icon(Icons.send), label: Text("Check out"))
            ],
          ),
        )
      ],),
    );
  }
}
