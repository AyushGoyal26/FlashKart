import 'package:flutter/material.dart';
import 'package:grocery_app/views/widgets/main_screen.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Razorpaye extends StatefulWidget {
  Razorpaye({super.key, required this.amount});
  late double amount;

  @override
  State<Razorpaye> createState() => _RazorpayeState();
}

class _RazorpayeState extends State<Razorpaye> {
  late Razorpay _razorpay;
  TextEditingController amtctrl = TextEditingController();

  void chkout(amount) async {
    amount = amount * 100;
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': amount,
      'name': 'Flash_Kart',
      'prefill': {'contact': '123456789', 'email': 'test@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error : e');
    }
  }

  void handlepayment(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: 'payment Successful' + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MainScreen()));
  }

  void handlepaymenterror(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: 'payment Fail' + response.message!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void handleexternalwallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: 'External Wallet' + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
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
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlepayment);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlepaymenterror);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleexternalwallet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(221, 182, 176, 176),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
            
                    children: [
            const SizedBox(
              height: 100,
            ),
            Image.network(
              'https://imgs.search.brave.com/2uKbNE0eQ3nCeab8qrpnmwjJzFenkUR5rELliegJ7HY/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/cG5nYWxsLmNvbS93/cC1jb250ZW50L3Vw/bG9hZHMvNS9Pbmxp/bmUtUGF5bWVudC1Q/TkctUGhvdG8ucG5n',
              height: 100,
              width: 300,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('WELCOME TO OUR PAYMENT GATEWAY',
                style: TextStyle(fontSize: 40)),
            Text('Your Bill Amount is ${widget.amount}'),
            const SizedBox(
              height: 30,
            ),
            Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  cursorColor: Colors.white,
                  autofocus: false,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      labelText: 'Enter your name ',
                      labelStyle: TextStyle(fontSize: 15, color: Colors.white),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 1)),
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15)),
                  controller: amtctrl,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Name';
                    }
                    return null;
                  },
                )),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                if (amtctrl.text.toString().isNotEmpty) {
                  setState(() {
                    double amt = widget.amount;
                    chkout(amt);
                  });
                }
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Make Payment'),
              ),
              style: ElevatedButton.styleFrom(foregroundColor: Colors.grey),
            )
                    ],
                  ),
          )),
    );
  }
}
