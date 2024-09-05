# FlashKart
The Idea 


The idea was simple: recreate the core functionalities of the ‘FlashKart’ in a way that would allow users to browse different grocery items , add them to their cart, and simulate the checkout process. We wanted to build something that felt like a real app, with user authentication, dynamic content, and a smooth user experience.

Project Overview: What We Built

1. User Authentication

We started with Firebase Authentication, enabling users to sign up and log in using either their phone number or Google account. We implemented phone authentication using verifyPhoneNumber from FirebaseAuth, ensuring that users received an OTP for secure login. For Google sign-ins, we used Firebase’s GoogleAuthProvider. One key feature was making sure that if a user was already registered, no duplicate entries were created in FireStore.

