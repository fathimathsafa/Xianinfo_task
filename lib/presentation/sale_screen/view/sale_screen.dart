import 'package:cm_task/presentation/add_item_screen/view/add_items_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SaleScreen extends StatefulWidget {
  const SaleScreen({super.key});

  @override
  State<SaleScreen> createState() => _SaleScreenState();
}

class _SaleScreenState extends State<SaleScreen> {
  String _invoiceNumber = '';
  String _date = '';

  @override
  void initState() {
    super.initState();
    _generateInvoiceDetails(); // Generate invoice number and date when the screen opens
  }

  void _generateInvoiceDetails() {
    final now = DateTime.now();
    _invoiceNumber = "${now.millisecondsSinceEpoch}";
    _date = DateFormat('dd/MM/yyyy').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Sale"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // Align buttons at the bottom
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Invoice Number and Date Row with Divider
                    Container(
                      width: double.infinity,
                      height: 60,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 12.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Invoice Number: $_invoiceNumber"),
                          Container(
                            height: 20,
                            width: 1,
                            color: Colors.grey,
                          ),
                          Text("Date: $_date"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Customer TextFormField
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Customer',
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    // Billing Name TextFormField
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Billing Name (Optional)',
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    // Phone Number TextFormField
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    // Add Items Button
                    Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      child: MaterialButton(
                        color: Colors.white,
                        height: 50,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Colors.grey, width: 0),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddItemsScreen()),
                          );
                        },
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.add_box_rounded, color: Colors.blue),
                              SizedBox(width: 8),
                              Text("Add Items",
                                  style: TextStyle(color: Colors.blue)),
                              SizedBox(width: 8),
                              Text("(Optional)",
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Container with Total Text
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16.0),
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          "Total: \$0.00",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Save and Cancel Buttons at the bottom
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: MaterialButton(
                    height: 50,
                    shape: const RoundedRectangleBorder(),
                    onPressed: () {
                      // Save action
                    },
                    child: const Text(
                      "Save & New",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: MaterialButton(
                    height: 50,
                    onPressed: () {
                      // Cancel action
                    },
                    shape: const RoundedRectangleBorder(),
                    color: Colors.blue,
                    child: const Text(
                      "Save",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
