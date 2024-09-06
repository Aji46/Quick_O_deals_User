import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_o_deals/Controller/Provider/product_provider.dart';
import 'package:quick_o_deals/View/widget/textformfiled/coustom_text.dart';


class ProductAdd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<ProductProvider>(
          builder: (context, productProvider, child) {
            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      width: 2,
                    ),
                    color: Colors.grey[200],
                  ),
                  width: double.infinity,
                  height: 140,
                  child: Row(
                    children: [
                      Expanded(
                        child: IconButton(
                          onPressed: productProvider.selectImages,
                          icon: const Icon(Icons.add_a_photo_outlined, size: 60),
                          color: Colors.blue,
                        ),
                      ),
                      Expanded(
                        child: productProvider.selectedImages.isNotEmpty
                            ? ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: productProvider.selectedImages.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.file(
                                      File(productProvider.selectedImages[index].path),
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              )
                            : const Center(child: Text("No images selected")),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: productProvider.productNameController,
                  labelText: "Product Name",
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: productProvider.productDetailsController,
                  labelText: "Details",
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: productProvider.productPriceController,
                  labelText: "Price",
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: productProvider.productAdditionalInfoController,
                  labelText: "More (damage, features, extra fitting information)",
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 10),
               SizedBox(
  width: 10,
  child: ElevatedButton(
    onPressed: () => productProvider.saveProduct(context), // Pass context here
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    child: const Text("Save"),
  ),
),

              ],
            );
          },
        ),
      ),
    );
  }
}
