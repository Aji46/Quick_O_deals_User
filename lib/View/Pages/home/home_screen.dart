
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _categoryItem('Mobiles', Icons.phone_android),
                    _categoryItem('Property', Icons.home),
                    _categoryItem('Vehicles', Icons.directions_car),
                    _categoryItem('Bikes', Icons.motorcycle),
                  ],
                ),
                const SizedBox(height: 20),
                _sectionTitle('Featured'),
                _horizontalProductList(),
                const SizedBox(height: 20),
                _adSection(),
                const SizedBox(height: 20),
                _sectionTitle('Most Viewed'),
                _horizontalProductList(),
                const SizedBox(height: 20),
                _sectionTitle('MotorBikes'),
                _horizontalProductList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _categoryItem(String title, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 30),
        ),
        const SizedBox(height: 5),
        Text(title, style: TextStyle(fontSize: 12)),
      ],
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

  Widget _horizontalProductList() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            width: 150,
            margin: const EdgeInsets.only(right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(child: Text('Product Image')),
                ),
                const SizedBox(height: 5),
                const Text('Iphone 14 Pro Max', style: TextStyle(fontWeight: FontWeight.bold)),
                const Text('Rs 400,000', style: TextStyle(color: Colors.green)),
                const Text('New 10/10', style: TextStyle(color: Colors.grey)),
                const Text('Gulberg Phase 4, Lah... 22 Sep', style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _adSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nike', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Free Metcon'),
                SizedBox(height: 5),
                Text('\$ 120.99', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Container(
            width: 80,
            height: 80,
            color: Colors.grey[300],
            child: const Center(child: Text('Ad Image')),
          ),
        ],
      ),
    );
  }
}