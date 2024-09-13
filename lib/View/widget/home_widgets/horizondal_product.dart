// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:quick_o_deals/Controller/Provider/like_button.dart';

// class HorizontalProductList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection('user_products').snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         }

//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return Center(child: Text("No Products Available"));
//         }

//         final products = snapshot.data!.docs;

//         return SizedBox(
//           height: 200,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: products.length,
//             itemBuilder: (context, index) {
//               var productData = products[index].data() as Map<String, dynamic>;
//               String productId = products[index].id;
//               String productName = productData['productName'];
//               String productPrice = productData['productPrice'];
//               String productDetails = productData['productDetails'];
//               String productAdditionalInfo = productData['productAdditionalInfo'];
//               List<dynamic> images = productData['images'];
//               String imageUrl = images.isNotEmpty ? images[0] : 'assets/placeholder.png';

//               return Consumer<LikedHiveProvider>(
//                 builder: (context, likedProductsProvider, child) {
//                   bool isLiked = likedProductsProvider.isProductLiked(productId);

//                   return Container(
//                     width: 150,
//                     margin: const EdgeInsets.only(right: 10),
//                     child: Stack(
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               height: 100,
//                               decoration: BoxDecoration(
//                                 color: Colors.grey[300],
//                                 borderRadius: BorderRadius.circular(10),
//                                 image: DecorationImage(
//                                   image: imageUrl.startsWith('http')
//                                       ? NetworkImage(imageUrl)
//                                       : AssetImage(imageUrl) as ImageProvider,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 5),
//                             Text(
//                               productName,
//                               style: const TextStyle(fontWeight: FontWeight.bold),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             Text(
//                               'Rs $productPrice',
//                               style: const TextStyle(color: Colors.green),
//                             ),
//                             Text(
//                               productDetails,
//                               style: const TextStyle(color: Colors.grey),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             Text(
//                               productAdditionalInfo,
//                               style: const TextStyle(fontSize: 12, color: Colors.grey),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ],
//                         ),
//                         Positioned(
//                           top: 5,
//                           right: 5,
//                           child: IconButton(
//                             icon: Icon(
//                               isLiked ? Icons.favorite : Icons.favorite_border,
//                               color: isLiked ? Colors.red : Colors.white,
//                             ),
//                             onPressed: () {
//                               likedProductsProvider.toggleLike(productId);
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }







import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_o_deals/Controller/Provider/like_button.dart';
import 'package:quick_o_deals/View/Pages/product_detailes/product_detailes.dart';
// Import the Product Details Page

class HorizontalProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('user_products').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text("No Products Available"));
        }

        final products = snapshot.data!.docs;

        return SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              var productData = products[index].data() as Map<String, dynamic>;
              String productId = products[index].id;
              String productName = productData['productName'];
              String productPrice = productData['productPrice'];
              String productDetails = productData['productDetails'];
              String productAdditionalInfo = productData['productAdditionalInfo'];
              List<dynamic> images = productData['images'];
              String imageUrl = images.isNotEmpty ? images[0] : 'assets/placeholder.jpeg';

              return Consumer<LikedHiveProvider>(
                builder: (context, likedProductsProvider, child) {
                  bool isLiked = likedProductsProvider.isProductLiked(productId);

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsPage(productId: productId),
                        ),
                      );
                    },
                    child: Container(
                      width: 150,
                      margin: const EdgeInsets.only(right: 10),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: imageUrl.startsWith('http')
                                        ? NetworkImage(imageUrl)
                                        : AssetImage(imageUrl) as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                productName,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Rs $productPrice',
                                style: const TextStyle(color: Colors.green),
                              ),
                              Text(
                                productDetails,
                                style: const TextStyle(color: Colors.grey),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                productAdditionalInfo,
                                style: const TextStyle(fontSize: 12, color: Colors.grey),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          Positioned(
                            top: 5,
                            right: 5,
                            child: IconButton(
                              icon: Icon(
                                isLiked ? Icons.favorite : Icons.favorite_border,
                                color: isLiked ? Colors.red : Colors.white,
                              ),
                              onPressed: () {
                                likedProductsProvider.toggleLike(productId);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}