
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_o_deals/Controller/Provider/like_button.dart';
import 'package:quick_o_deals/View/widget/home_widgets/category_layout.dart';
import 'package:quick_o_deals/View/widget/home_widgets/horizondal_product.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LikedHiveProvider (),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text('Accessories', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const Text('Gulberg Phase 4, Lahore', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 20),
                  const Text('Browse Categories', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  CategoryListView(),
                  const SizedBox(height: 20),
                  _sectionTitle('Featured'),
                  HorizontalProductList(),
                  const SizedBox(height: 20),
                  _adSection(),
                  const SizedBox(height: 20),
                  _sectionTitle('Most Viewed'),
                  HorizontalProductList(),
                  const SizedBox(height: 20),
                  _sectionTitle('MotorBikes'),
                  HorizontalProductList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget _sectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text('See more', style: TextStyle(color: Colors.blue)),
      ],
    );
  }

  Widget _adSection() {
     return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('user_products').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text("No Ads Available"));
        }

        final ads = snapshot.data!.docs;
        final PageController pageController = PageController();
        Timer.periodic(Duration(seconds: 3), (Timer timer) {
          if (pageController.hasClients) {
            int nextPage = pageController.page!.toInt() + 1;
            if (nextPage >= ads.length) {
              nextPage = 0;
            }
            pageController.animateToPage(
              nextPage,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeIn,
            );
          }
        });

        return SizedBox(
          height: 200,
          child: PageView.builder(
            controller: pageController,
            itemCount: ads.length,
            itemBuilder: (context, index) {
              var adData = ads[index].data() as Map<String, dynamic>;
              String productName = adData['productName'];
              String productPrice = adData['productPrice'];
              List<dynamic> images = adData['images'];
              String imageUrl = images.isNotEmpty ? images[0] : 'assets/placeholder.png';

              return Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: imageUrl.startsWith('http')
                            ? NetworkImage(imageUrl)
                            : AssetImage(imageUrl) as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18,
                            shadows: [Shadow(blurRadius: 10, color: Colors.black)],
                          ),
                        ),
                        Text(
                          'Rs $productPrice',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            shadows: [Shadow(blurRadius: 10, color: Colors.black)],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}