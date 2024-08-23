
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:grocery_app/cubit/user_cubit.dart';
import 'package:grocery_app/firebase_options.dart';
import 'package:grocery_app/models/cart_notifier.dart';



import 'package:provider/provider.dart';


import './views/widgets/splash.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

  runApp(const App());
  //runApp(BlocProvider(create: (_)=>UserCubit() ,child: MaterialApp(title: "Grocery app",home:Splash(),debugShowCheckedModeBanner: false,)));
}
class App extends StatefulWidget{
  const App({super.key});
  @override
  State<App>createState()=>_AppState();
}

  class _AppState extends State<App>{
  @override
  Widget build(BuildContext context) {
    
      return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartNotifier()),
        BlocProvider(create: (_) => UserCubit()),
      ],
      child:MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        home:const Splash(),
      ),
    );
  }

  }
