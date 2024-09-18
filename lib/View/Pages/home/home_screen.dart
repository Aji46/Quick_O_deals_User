import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_o_deals/Controller/Provider/like_button.dart';
import 'package:quick_o_deals/View/widget/home_widgets/ad_section_page.dart';
import 'package:quick_o_deals/View/widget/home_widgets/category_layout.dart';
import 'package:quick_o_deals/View/widget/home_widgets/horizondal_product.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LikedHiveProvider(),
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
                  AdSectionPage(),
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
}
