import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grocery_app/shared/services/image_picker.dart';
import 'package:grocery_app/views/widgets/signin.dart';
 // Import the image picker service

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  final ImagePickerService _imagePickerService = ImagePickerService();  // Use the image picker service
  late String _photoUrl;

  @override
  void initState() {
    super.initState();
    _photoUrl = user?.photoURL ?? '';
  }

  Future<void> _signOut() async {
    try {
      // Sign out from Google
      await GoogleSignIn().signOut();
      // Sign out from Firebase
      await FirebaseAuth.instance.signOut();
      // Navigate back to the Sign-In page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Signin()),
      );
    } catch (e) {
      // Handle any errors during sign-out
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Error signing out: ${e.toString()}",
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }

  Future<void> _pickImage() async {
    File? imageFile = await _imagePickerService.pickImageFromGallery();
    if (imageFile != null) {
      await _uploadImage(imageFile);
    }
  }

  Future<void> _uploadImage(File imageFile) async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child('profile_photos').child(user!.uid + '.jpg');
      await storageRef.putFile(imageFile);
      final downloadUrl = await storageRef.getDownloadURL();
      await FirebaseAuth.instance.currentUser?.updatePhotoURL(downloadUrl);
      setState(() {
        _photoUrl = downloadUrl;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: const Text("Profile photo updated successfully!"),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Error updating profile photo: ${e.toString()}",
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Profile",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(221, 182, 176, 176),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Profile Picture
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(75),
                    child: _photoUrl.isNotEmpty
                        ? Image.network(
                            _photoUrl,
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          )
                        : Icon(
                            Icons.person,
                            size: 150,
                            color: Colors.grey[600],
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Display Name
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(20),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(15),
                    title: const Text(
                      "Name",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      user?.displayName ?? "Not available",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              // Display Email
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(20),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(15),
                    title: const Text(
                      "Email",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      user?.email ?? "Not available",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              // Logout Button
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _signOut,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Icon(Icons.logout, color: Colors.white, size: 30),
                       SizedBox(width: 10),
                       Text(
                        "Logout",
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

