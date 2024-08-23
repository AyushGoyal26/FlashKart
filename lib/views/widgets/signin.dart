import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/cubit/user_cubit.dart';
import 'package:grocery_app/views/widgets/main_screen.dart';
import 'package:grocery_app/views/widgets/signup.dart';
import 'package:sign_in_button/sign_in_button.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  String email = "", password = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

Future<void> _userLogin() async {
  if (_formKey.currentState!.validate()) {
    if (email == null || password == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Email and password cannot be null",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      );
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == "user-not-found") {
        message = "User doesn't exist";
      } else if (e.code == "wrong-password") {
        message = "Wrong password";
      } else {
        message = "An unexpected error occurred. Please try again.";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            message,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "An unexpected error occurred. Please try again.",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 40, left: 30, right: 30, bottom: 50),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("assets/images/login.jpg"),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    "Sign In",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                const Center(child: Text("Enter the below details to proceed.")),
                const SizedBox(height: 40),
                const Text("Email", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 237, 236, 236),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your Email";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(border: InputBorder.none, hintText: "example@gmail.com"),
                  ),
                ),
                const SizedBox(height: 30),
                const Text("Password", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 237, 236, 236),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your Password";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(border: InputBorder.none, hintText: "Password"),
                  ),
                ),
                const SizedBox(height: 10),

                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      email = emailController.text;
                      password = passwordController.text;
                    });
                    _userLogin();
                  },
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 4,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.green,
                      ),
                      child: const Center(
                        child: Text(
                          "Login",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Center(child: Text("or")),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SignInButton(
                      Buttons.googleDark,
                      onPressed: () {
                         BlocProvider.of<UserCubit>(context).login();
                        Timer(const Duration(seconds: 4), (){
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const MainScreen()),
                    );});
                      },
                      text: "Login with Google",
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    GestureDetector(
                      onTap: () => Timer(const Duration(seconds: 4), (){Navigator.push(context, MaterialPageRoute(builder: (_) => const Signup()));}),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.green, fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}
