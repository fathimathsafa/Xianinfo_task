import 'package:cm_task/presentation/sale_screen/view/sale_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Sale Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('sales').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
                child: Text('Error fetching data: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No sales data available.'));
          }

          final sales = snapshot.data!.docs;

          return ListView.builder(
            itemCount: sales.length,
            itemBuilder: (context, index) {
              final sale = sales[index].data() as Map<String, dynamic>;
              final invoiceNumber =
                  sale['invoiceNumber'] ?? 'No Invoice Number';
              final customer = sale['customer'] ?? 'No Customer Name';
              final totalAmount = sale['totalAmount'] ?? 0.0;
              final dateString = sale['date'] as String?;
              final date = dateString != null ? dateString : 'No Date';

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              customer,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('$invoiceNumber'),
                              Text('$date'),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * .001),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 12,
                        ),
                        decoration: ShapeDecoration(
                          shape: const StadiumBorder(),
                          color: Colors.green[100],
                        ),
                        child: const Text(
                          'SALE',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * .02),
                    ],
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Text("Total"),
                                Text(' ${totalAmount.toStringAsFixed(2)}'),
                              ],
                            ),
                            SizedBox(width: size.width * .1),
                            Column(
                              children: [
                                Text("Balance"),
                                Text('${totalAmount.toStringAsFixed(2)}'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.print, color: Colors.grey),
                          SizedBox(width: size.width * .03),
                          Icon(Icons.share_rounded, color: Colors.grey),
                          SizedBox(width: size.width * .03),
                          Icon(
                            Icons.more_vert,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SaleScreen()),
          );
        },
        backgroundColor: Colors.red[400],
        icon: const Icon(Icons.currency_rupee, color: Colors.white),
        label: const Text("Add Sale", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
