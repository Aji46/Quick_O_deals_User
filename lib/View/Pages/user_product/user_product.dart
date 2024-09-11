import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_o_deals/Controller/auth/provider/login_.dart';
import 'package:quick_o_deals/Controller/auth/provider/user_product.dart';
import 'package:quick_o_deals/Model/user_product/user_product.dart';
import 'package:quick_o_deals/View/widget/bottom_nav_bar/bottom%20_navigation_bar.dart';



class UserProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<logProvider>(
      builder: (context, logProvider, child) {
        if (!logProvider.isLoggedIn) {
        
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()),
            );
          });
          return const Center(child: CircularProgressIndicator());
        }

        final userId = FirebaseAuth.instance.currentUser?.uid;

        return ChangeNotifierProvider(
          create: (context) => UserProductController(UserProductModel()),
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Your Products'),
            ),
            body: Consumer<UserProductController>(
              builder: (context, controller, child) {
                return StreamBuilder<QuerySnapshot>(
                  stream: userId != null ? controller.fetchUserProducts(userId) : null,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return const Center(child: Text('Something went wrong'));
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('No products found'));
                    }

                    final products = snapshot.data!.docs;

                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2 / 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: products.length,
                     itemBuilder: (ctx, index) {
  final product = products[index];

  // Check if 'imageUrl' exists and is not null
  final imageUrl = product.get('images') ?? 'default_image_url'; // Replace with a default image URL or placeholder

  return Card(
    elevation: 5,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image.network(
            imageUrl[0],
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            product.get('productName') ?? 'No Name', // Handle missing name
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {}
              // => 
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => EditProductPage(productId: product.id),
              //   ),
              // ),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => Provider.of<UserProductController>(context, listen: false).deleteProduct(product.id),
            ),
          ],
        ),
      ],
    ),
  );
}

                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
