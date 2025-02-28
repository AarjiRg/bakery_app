import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class NewProductController with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isLoading = false;

  Future<void> onAddingNewProduct({
    required String productName,
    required String description,
    required String price,
    required String category,
    required String expiryDate,
    required String imageUrl,
    required BuildContext context,
  }) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        throw Exception("User not logged in.");
      }

      String productId = _firestore.collection('All products').doc().id;

      Map<String, dynamic> newProductData = {
        'productId': productId,
        'productName': productName,
        'description': description,
        'price': price,
        'category': category,
        'expiryDate': expiryDate,
        'imageUrl': imageUrl,
        'addedAt': FieldValue.serverTimestamp(),
      };

      await _firestore.collection('All products').doc(productId).set(newProductData);

      notifyListeners();
    } catch (e) {
      log("Error adding product: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add product.')),
      );
    }
  }

  Future<String?> uploadImg(File imageFile) async {
    isLoading = true;
    notifyListeners();

    final FirebaseStorage storage = FirebaseStorage.instance;
    Reference folder = storage.ref().child("product_images");
    Reference imageRef =
        folder.child("${DateTime.now().millisecondsSinceEpoch}.jpg");

    try {
      await imageRef.putFile(imageFile);
      String uploadImgUrl = await imageRef.getDownloadURL();
      log("Uploaded Image URL: $uploadImgUrl");

      isLoading = false;
      notifyListeners();
      return uploadImgUrl;
    } catch (e) {
      log("Upload Error: $e");
      isLoading = false;
      notifyListeners();
      return null;
    }
  }
}
