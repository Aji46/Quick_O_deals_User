import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quick_o_deals/Model/user_product/user_product.dart';



class UserProductController with ChangeNotifier {
  final UserProductModel _model;
  UserProductController(this._model);

  Stream<QuerySnapshot> fetchUserProducts(String userId) {
    return _model.fetchUserProducts(userId);
  }

  Future<void> deleteProduct(String productId) async {
    await _model.deleteProduct(productId);
    notifyListeners();
  }
}
