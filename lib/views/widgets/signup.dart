import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/views/widgets/main_screen.dart';
import 'package:grocery_app/views/widgets/signin.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String? name, email, password;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

 Future<void> registration() async {
  if (password == null || name == null || email == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.red,
        content: Text("Please fill in all fields", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
    );
    return;
  }

  try {

    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );


    await userCredential.user?.updateProfile(displayName: name);

    await userCredential.user?.reload();
    User? updatedUser = FirebaseAuth.instance.currentUser;

    if (updatedUser != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.amber,
          content: Text("Registered successfully", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
      );

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainScreen()));
    } else {
      throw Exception("User profile could not be updated.");
    }
  } on FirebaseAuthException catch (e) {
    String message;
    if (e.code == "weak-password") {
      message = "Password is too weak";
    } else if (e.code == "email-already-in-use") {
      message = "Account already exists";
    } else {
      message = "An unexpected error occurred. Please try again.";
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(message, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.red,
        content: Text("An unexpected error occurred. Please try again.", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 40, left: 30, right: 30, bottom: 50),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("assets/images/signup.jpg"),
                const SizedBox(height: 20),
                const Center(child: Text("Sign Up", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
                const Center(child: Text("Enter the below details to proceed.")),
                const SizedBox(height: 40),
                const Text("Name", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 237, 236, 236),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your Name";
                      }
                      return null;
                    },
                    controller: nameController,
                    decoration: const InputDecoration(border: InputBorder.none, hintText: "Name"),
                  ),
                ),
                const SizedBox(height: 20),
                const Text("Email", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 237, 236, 236),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your Email";
                      }
                      return null;
                    },
                    controller: emailController,
                    decoration: const InputDecoration(border: InputBorder.none, hintText: "example@gmail.com"),
                  ),
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      setState(() {
                        name = nameController.text;
                        email = emailController.text;
                        password = passwordController.text;
                      });
                      registration();
                    }
                  },
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 4,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.green),
                      child: const Center(child: Text("Sign UP", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const Signin())),
                      child: const Text("Sign In", style: TextStyle(color: Colors.green, fontSize: 15, fontWeight: FontWeight.w700)),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
