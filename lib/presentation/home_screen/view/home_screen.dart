import 'package:cm_task/presentation/sale_screen/view/sale_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Transaction Details",
          style: TextStyle(color: Colors.red[400]),
        ),
      ),
      body: Column(
        children: [],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SaleScreen()));
        },
        backgroundColor: Colors.red[400],
        icon: const Icon(Icons.currency_rupee, color: Colors.white),
        label:
            const Text("Add New Sale", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
