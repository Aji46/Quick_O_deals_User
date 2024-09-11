import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:quick_o_deals/Controller/auth/provider/loding_provider.dart';
import 'package:quick_o_deals/Model/add_product/product.dart';
import 'package:quick_o_deals/View/Pages/category/category.dart';
import 'package:quick_o_deals/View/widget/bottom_nav_bar/bottom%20_navigation_bar.dart';

class ProductProvider with ChangeNotifier {
  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Firebase Storage instance
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // TextEditingControllers for managing form inputs
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productDetailsController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  final TextEditingController productAdditionalInfoController = TextEditingController();

  // List to store selected images
  List<XFile> _selectedImages = [];
  List<XFile> get selectedImages => _selectedImages;

  // List to store image URLs after upload
  List<String> _imageUrls = [];

  // Loading state
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Select images from gallery
  void selectImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? images = await picker.pickMultiImage();
    if (images != null) {
      _selectedImages = images;
      notifyListeners();
    }
  }

Future<void> saveProduct(BuildContext context) async {
  // Access LoadingProvider and set loading to true
  final loadingProvider = Provider.of<LoadingProvider>(context, listen: false);
  loadingProvider.setLoading(true);

  try {
    if (_selectedImages.isNotEmpty) {
      for (var image in _selectedImages) {
        String imageUrl = await _uploadImageToFirebase(image);
        _imageUrls.add(imageUrl);
      }

      Product newProduct = Product(
        name: productNameController.text,
        details: productDetailsController.text,
        price: productPriceController.text,
        additionalInfo: productAdditionalInfoController.text,
        images: _imageUrls,
      );

      await _saveProductToFirestore(newProduct);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CategoryPage(product: newProduct),
        ),
      );
    }
  } finally {
    // Once everything is done, set loading to false
    loadingProvider.setLoading(false);
  }
}


  // Helper function to upload image to Firebase Storage and get download URL
  Future<String> _uploadImageToFirebase(XFile image) async {
    try {
      // Create a reference for the image file in Firebase Storage
      Reference storageRef = _storage.ref().child('product_images/${image.name}');
      
      // Upload the image file
      UploadTask uploadTask = storageRef.putFile(File(image.path));
      TaskSnapshot snapshot = await uploadTask;

      // Get the download URL
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }

  // Helper function to save product to Firestore
  Future<void> _saveProductToFirestore(Product product) async {
    try {
      await _firestore.collection('products').add({
        'productName': product.name,
        'productDetails': product.details,
        'productPrice': product.price,
        'productAdditionalInfo': product.additionalInfo,
        'images': product.images, // Save image URLs
        'timestamp': FieldValue.serverTimestamp(),
      });
      print("Product saved successfully");
    } catch (e) {
      print('Error saving product to Firestore: $e');
    }
  }

  // Save category with product
  Future<void> saveCategoryWithProduct({
    required BuildContext context,
    required String categoryId,
    required String userId,
    required Product product,
  }) async {
    try {
      // Set loading state to true
      _isLoading = true;
      notifyListeners();

      // Store the selected category, product data, and user credentials in Firestore
      await _firestore.collection('user_products').add({
        'categoryId': categoryId,
        'userId': userId,
        'productName': product.name,
        'productDetails': product.details,
        'productPrice': product.price,
        'productAdditionalInfo': product.additionalInfo,
        'images': product.images, // Save image URLs
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Show a success popup
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('Product added successfully!'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        ),
      );

      // Clear the form fields
      productNameController.clear();
      productDetailsController.clear();
      productPriceController.clear();
      productAdditionalInfoController.clear();
      _selectedImages.clear();
      _imageUrls.clear();

      // Navigate to MyHomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    } catch (e) {
      print('Error saving product with category: $e');
    } finally {
      // Set loading state to false
      _isLoading = false;
      notifyListeners();
    }
  }
}
