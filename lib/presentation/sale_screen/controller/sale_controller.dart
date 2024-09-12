import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SaleProvider with ChangeNotifier {
  String customer = '';
  String billingName = '';
  String phoneNumber = '';
  double totalAmount = 0.0; 
  List<Map<String, dynamic>> items = [];
  List<Map<String, dynamic>> sales = []; 

  List<Map<String, dynamic>> get salesData => sales;

  void updateCustomer(String value) {
    customer = value;
    notifyListeners();
  }

  void updateBillingName(String value) {
    billingName = value;
    notifyListeners();
  }

  void updatePhoneNumber(String value) {
    phoneNumber = value;
    notifyListeners();
  }

  void addItem(Map<String, dynamic> item) {
    double itemTotal = item['quantity'] * item['price'];
    items.add({
      'itemName': item['itemName'],
      'quantity': item['quantity'],
      'price': item['price'],
      'total': itemTotal,
    });
    updateTotalAmount();
  }

  void updateTotalAmount() {
    totalAmount = items.fold(0.0, (sum, item) => sum + item['total']);
    notifyListeners();
  }

  Future<void> saveData() async {
    final docRef = FirebaseFirestore.instance.collection('sales').doc();
    await docRef.set({
      'customer': customer,
      'billingName': billingName,
      'phoneNumber': phoneNumber,
      'totalAmount': totalAmount,
      'items': items,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> fetchSales() async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('sales').get();
      sales = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      notifyListeners();
    } catch (e) {
      print('Error fetching sales: $e');
    }
  }

  void reset() {
    customer = '';
    billingName = '';
    phoneNumber = '';
    items = [];
    totalAmount = 0.0;
    notifyListeners();
  }
}
