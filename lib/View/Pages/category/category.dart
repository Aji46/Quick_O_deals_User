import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_o_deals/Controller/Provider/category_provider.dart';
import 'package:quick_o_deals/Controller/Provider/product_provider.dart';
import 'package:quick_o_deals/Model/add_product/product.dart';
import 'package:quick_o_deals/View/Pages/product_add/product_add.dart';

class CategoryPage extends StatelessWidget {
  final Product product;

  const CategoryPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fetch categories when the page is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Category Page'),
      ),
      body: Consumer<CategoryProvider>(
        builder: (context, categoryProvider, child) {
          if (categoryProvider.categories.isEmpty) {
            return const Center(child: Text('No categories available.'));
          } else {
            return GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 20.0,
                childAspectRatio: 3 / 4,
              ),
              itemCount: categoryProvider.categories.length,
              itemBuilder: (context, index) {
                final category = categoryProvider.categories[index];
                return InkWell(
                  onTap: () async {
                    final User? currentUser = FirebaseAuth.instance.currentUser;

                    if (currentUser != null) {
                      // Save to Firebase with user credentials and product data
                      await Provider.of<ProductProvider>(context, listen: false)
                          .saveCategoryWithProduct(
                            context: context,

                        categoryId: category.name,  // Category name as ID
                        userId: currentUser.uid,  // Current user ID
                        product: product,  // Previous page product data
                      );

                      // Navigate to ProductAdd Page (Optional)
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductAdd(),
                        ),
                      );
                    }
                  },
                  child: Card(
                    elevation: 6.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(category.imageUrl),
                          radius: 50,
                          backgroundColor: Colors.transparent,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          category.name,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
