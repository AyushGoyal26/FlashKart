# FlashKart
The Idea 


The idea was simple: recreate the core functionalities of the ‘FlashKart’ in a way that would allow users to browse different grocery items , add them to their cart, and simulate the checkout process. We wanted to build something that felt like a real app, with user authentication, dynamic content, and a smooth user experience.

Project Overview: What We Built

1. User Authentication

We started with Firebase Authentication, enabling users to sign up and log in using either their phone number or Google account. We implemented phone authentication using verifyPhoneNumber from FirebaseAuth, ensuring that users received an OTP for secure login. For Google sign-ins, we used Firebase’s GoogleAuthProvider. One key feature was making sure that if a user was already registered, no duplicate entries were created in FireStore.

2. Dynamic Home Screen

The home screen is where users first interact with the app. At the top of the screen, we display the user’s address, fetched using the Geolocator package. Below that, interactive cards lead to the menu screen. The home screen also features a bottom navigation bar with three tabs — Home, Cart , Profile — each providing access to different parts of the app. While some of these screens contain static data, the Home screen is fully functional, offering a dynamic user experience.

3. Category Screen & Cart Functionality

The category screen is a critical part of the app, allowing users to browse through different item categories. We implemented a scroll-able list of tabs representing these categories, and clicking on each tab renders a list of items cards. The items details, including names, descriptions, and prices, are made individually in a file. The bottom navigation button takes users to the Cart screen, where they can review their order, adjust quantities, and proceed to checkout.

4. Checkout and Payment Integration

For the checkout process, we integrated two payment methods: UPI (which currently works only on Android) and Razorpay. The Razorpay integration uses a demo/test mode since this is not a production app. Although users can go through the motions of selecting a payment method, the app currently doesn’t complete actual transactions — a feature we plan to implement more fully in the future.

5. UI/UX Considerations

We placed a strong emphasis on creating a user-friendly interface that mirrors the experience of using a professional app. This included designing a splash screen with a loading indicator, using consistent color schemes, and ensuring that navigation was intuitive. While the app isn’t fully feature-complete, the foundation we’ve built offers a smooth and visually appealing user experience.

The Challenges We Faced

1. State Management with BLoC

Implementing BLoC (Business Logic Component) for state management was one of the most challenging aspects of this project. Ensuring that the state was correctly managed across multiple screens — especially in complex interactions like adding items to the cart or handling authentication — required careful planning and debugging.

2. Geolocation Integration

Fetching and displaying the user’s location using the Geolocator package posed its own set of challenges. We had to account for various permissions, handle errors gracefully, and ensure that the location data was accurate and updated in real-time.

3. Payment Gateway Integration

While integrating UPI and Razorpay was relatively straightforward, the challenge lay in ensuring that the payment process was smooth and intuitive. Given that Razorpay is in test mode, we had to simulate the payment process without actually processing transactions — a task that required careful attention to detail.

4. Collaboration Using GitHub

This was our first time working on a project of this scale using GitHub. Managing version control, handling merge conflicts, and ensuring that everyone was on the same page took some getting used to, but it ultimately strengthened our teamwork and communication skills./




