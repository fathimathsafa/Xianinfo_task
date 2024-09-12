import 'package:cm_task/presentation/home_screen/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cm_task/presentation/sale_screen/controller/sale_controller.dart';
import 'package:cm_task/presentation/add_item_screen/view/add_items_screen.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SaleScreen extends StatelessWidget {
  final String _invoiceNumber;
  final String _date;
  final _formKey = GlobalKey<FormState>(); 

  SaleScreen({super.key})
      : _invoiceNumber = "${DateTime.now().millisecondsSinceEpoch}",
        _date = DateFormat('dd/MM/yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final saleProvider = Provider.of<SaleProvider>(context);
    var size = MediaQuery.sizeOf(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Sale",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          ToggleSwitch(
            customWidths: [60.0, 60.0],
            cornerRadius: 18.0,
            activeBgColors: [
              [Colors.green],
              [Colors.redAccent]
            ],
            activeFgColor: Colors.white,
            inactiveBgColor: Colors.grey,
            inactiveFgColor: Colors.white,
            totalSwitches: 2,
            labels: ['Credit', 'Cash'],
            onToggle: (index) {
              print('switched to: $index');
            },
          ),
          SizedBox(
            width: size.width * .1,
          ),
          Icon(Icons.settings_outlined),
          SizedBox(
            width: size.width * .06,
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: size.width * .22,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 12.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Row(
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
                          Divider(),
                          Row(
                            children: [
                              Text(
                                "Firm Name:",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 17),
                              ),
                              Text(
                                " Xianinfotech LLP",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17),
                              ),
                              SizedBox(
                                width: size.width * .3,
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                color: Colors.grey,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * .02),
                    Container(
                      width: double.infinity, 
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(
                            15.0),
                        child: Column(
                          children: [
                            TextFormField(
                              initialValue: saleProvider.customer,
                              decoration: InputDecoration(
                                labelText: 'Customer',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.blue),
                                ),
                              ),
                              onChanged: saleProvider.updateCustomer,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Customer name is required';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: size.height * .03,
                            ),

                            TextFormField(
                              initialValue: saleProvider.billingName,
                              decoration: InputDecoration(
                                labelText: 'Billing Name (Optional)',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.blue),
                                ),
                              ),
                              onChanged: saleProvider.updateBillingName,
                            ),
                            SizedBox(
                              height: size.height * .03,
                            ),

                            TextFormField(
                              initialValue: saleProvider.phoneNumber,
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.blue),
                                ),
                              ),
                              onChanged: saleProvider.updatePhoneNumber,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .02,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 24),
                        child: MaterialButton(
                          color: Colors.white,
                          height: 50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side:
                                const BorderSide(color: Colors.grey, width: 0),
                          ),
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddItemsScreen(),
                              ),
                            );
                            if (result != null) {
                              saleProvider.addItem(result);
                            }
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
                    ),

                    SizedBox(
                      height: size.height * .01,
                    ),

                    Container(
                      padding: const EdgeInsets.all(8.0),
                      width: double.infinity,
                      height: size.height * .25,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Total Amount: ₹${saleProvider.totalAmount.toStringAsFixed(2)}",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ),

               
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: MaterialButton(
                  height: 50,
                  shape: const RoundedRectangleBorder(),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final docRef =
                          FirebaseFirestore.instance.collection('sales').doc();
                      await docRef.set({
                        'customer': saleProvider.customer,
                        'billingName': saleProvider.billingName,
                        'phoneNumber': saleProvider.phoneNumber,
                        'items': saleProvider.items,
                        'totalAmount': saleProvider.totalAmount,
                        'invoiceNumber': _invoiceNumber,
                        'date': _date,
                      });

                      saleProvider.reset();
                    }
                  },
                  child: const Text(
                    "Save & New",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: MaterialButton(
                  height: 50,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final docRef =
                          FirebaseFirestore.instance.collection('sales').doc();
                      await docRef.set({
                        'customer': saleProvider.customer,
                        'billingName': saleProvider.billingName,
                        'phoneNumber': saleProvider.phoneNumber,
                        'items': saleProvider.items,
                        'totalAmount': saleProvider.totalAmount,
                        'invoiceNumber': _invoiceNumber,
                        'date': _date,
                      });

                      saleProvider.reset();

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    }
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
    );
  }
}
