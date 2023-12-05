import 'package:flutter/material.dart';
import 'package:sqflite_demo/Models/Product.dart';
import 'package:sqflite_demo/data/dbHelper.dart';

class ProductAdd extends StatefulWidget {
  const ProductAdd({super.key});

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  var txtName = TextEditingController();
  var txtDescription = TextEditingController();
  var txtUnitPrice = TextEditingController();
  var dbHelper = DbHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
        backgroundColor: Colors.amber,
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [buildNameField(), buildDescriptionField(), buildUnitPriceField(), buildSaveButton()],
            ),
          ),
        ),
      ),
    );
  }

  buildNameField() {
    return TextField(
      decoration: const InputDecoration(
        labelText: "Product Name",
      ),
      controller: txtName,
    );
  }

  buildDescriptionField() {
    return TextField(
      decoration: const InputDecoration(
        labelText: "Product Description",
      ),
      controller: txtDescription,
    );
  }

  buildUnitPriceField() {
    return TextField(
      decoration: const InputDecoration(
        labelText: "Product UnitPrice",
      ),
      controller: txtUnitPrice,
    );
  }

  buildSaveButton() {
    return MaterialButton(
      onPressed: () {
        addProduct();
      },
      color: Colors.red,
      splashColor: Colors.amber,
      child: const Text("Kaydet"),
    );
  }

  void addProduct() async {
    await dbHelper.insert(
      Product(
        name: txtName.text,
        description: txtDescription.text,
        unitPrice: double.tryParse(txtUnitPrice.text),
      ),
    );
    // ignore: use_build_context_synchronously
    Navigator.pop(context, true);
  }
}
