import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cm_task/presentation/sale_screen/controller/sale_controller.dart';

class AddItemsScreen extends StatefulWidget {
  const AddItemsScreen({super.key});

  @override
  State<AddItemsScreen> createState() => _AddItemsScreenState();
}

class _AddItemsScreenState extends State<AddItemsScreen> {
  String selectedUnit = 'Select Unit';
  String selectedTax = 'Select Tax';
  List<int> units = List.generate(5, (index) => index + 1);

  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  void showUnitsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Unit'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: units.map((unit) {
              return ListTile(
                title: Text('$unit Unit(s)'),
                onTap: () {
                  setState(() {
                    selectedUnit = '$unit Unit(s)';
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void showTaxDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Tax'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('With Tax'),
                onTap: () {
                  setState(() {
                    selectedTax = 'With Tax';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Without Tax'),
                onTap: () {
                  setState(() {
                    selectedTax = 'Without Tax';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void saveItem() async {
    final saleProvider = Provider.of<SaleProvider>(context, listen: false);
    final itemName = itemNameController.text;
    final quantity = int.tryParse(quantityController.text) ?? 0;
    final price = double.tryParse(priceController.text) ?? 0.0;

    if (itemName.isNotEmpty && quantity > 0 && price > 0.0) {
      final totalAmount = quantity * price;

      final item = {
        'itemName': itemName,
        'quantity': quantity,
        'price': price,
        'unit': selectedUnit,
        'tax': selectedTax,
        'total': totalAmount,
      };

      Navigator.pop(context, item);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Add Items to Sale',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          const Icon(Icons.settings_outlined),
          SizedBox(
            width: size.width * .05,
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                TextField(
                  controller: itemNameController,
                  decoration: InputDecoration(
                    labelText: 'Item Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: size.height * .01),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: quantityController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Quantity',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * .04),
                    Expanded(
                      child: GestureDetector(
                        onTap: showUnitsDialog,
                        child: InputDecorator(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                selectedUnit,
                                style: TextStyle(
                                  color: selectedUnit == 'Select Unit'
                                      ? Colors.black
                                      : Colors.black,
                                ),
                              ),
                              Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * .01),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: priceController,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: InputDecoration(
                          labelText: 'Price',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: GestureDetector(
                        onTap: showTaxDialog,
                        child: InputDecorator(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                selectedTax,
                                style: TextStyle(
                                  color: selectedTax == 'Select Tax'
                                      ? Colors.black
                                      : Colors.black,
                                ),
                              ),
                              Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * .567,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: MaterialButton(
                  height: size.height * .056,
                  shape: const RoundedRectangleBorder(),
                  onPressed: () {},
                  child: const Text(
                    "Save & New",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
              SizedBox(width: size.width * .01),
              Expanded(
                child: MaterialButton(
                  height: size.height * .056,
                  onPressed: saveItem,
                  shape: const RoundedRectangleBorder(),
                  color: Colors.red,
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
