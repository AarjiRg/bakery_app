import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<void> addToCart({
    required String productId,
    required String productName,
    required double price,
    required int quantity,
    required String imageUrl,
  }) async {
    try {

      User? user = _auth.currentUser;
      if (user == null) {
        throw Exception("User not logged in");
      }


      CollectionReference cartCollection = _firestore
          .collection('users')
          .doc(user.uid)
          .collection('cart');


      QuerySnapshot querySnapshot = await cartCollection
          .where('productId', isEqualTo: productId)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot doc = querySnapshot.docs.first;
        int currentQuantity = doc['quantity'];
        await cartCollection.doc(doc.id).update({
          'quantity': currentQuantity + quantity,
        });
      } else {
        await cartCollection.add({
          'productId': productId,
          'productName': productName,
          'price': price,
          'quantity': quantity,
          'imageUrl': imageUrl,
          'addedAt': DateTime.now(),
        });
      }
    } catch (e) {
      throw Exception("Failed to add item to cart: $e");
    }
  }


  Future<void> removeFromCart(String cartItemId) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        throw Exception("User not logged in");
      }

      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('cart')
          .doc(cartItemId)
          .delete();
    } catch (e) {
      throw Exception("Failed to remove item from cart: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getCartItems() async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        throw Exception("User not logged in");
      }

      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('cart')
          .get();

      return querySnapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'productId': doc['productId'],
          'productName': doc['productName'],
          'price': doc['price'],
          'quantity': doc['quantity'],
          'imageUrl': doc['imageUrl'],
          'addedAt': doc['addedAt'],
        };
      }).toList();
    } catch (e) {
      throw Exception("Failed to fetch cart items: $e");
    }
  }


  Future<void> updateCartItemQuantity(String cartItemId, int newQuantity) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        throw Exception("User not logged in");
      }

      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('cart')
          .doc(cartItemId)
          .update({
        'quantity': newQuantity,
      });
    } catch (e) {
      throw Exception("Failed to update cart item quantity: $e");
    }
  }
}