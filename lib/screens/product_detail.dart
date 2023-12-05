import 'package:flutter/material.dart';
import 'package:sqflite_demo/Models/Product.dart';
import 'package:sqflite_demo/data/dbHelper.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  const ProductDetail(this.product, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<ProductDetail> createState() => _ProductDetailState(product);
}

enum Options { delete, update }

class _ProductDetailState extends State<ProductDetail> {
  final Product product;
  _ProductDetailState(this.product);
  var txtName = TextEditingController();
  var txtDescription = TextEditingController();
  var txtUnitPrice = TextEditingController();
  var dbHelper = DbHelper();

  @override
  void initState() {
    txtName.text = product.name!;
    txtDescription.text = product.description!;
    txtUnitPrice.text = product.unitPrice!.toString();
    super.initState();
  }

  //silme güncelleme için
//PopupMenuEntry girdisi
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name.toString()),
        actions: <Widget>[
          PopupMenuButton<Options>(
            onSelected: selectProcess,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Options>>[
              const PopupMenuItem<Options>(
                value: Options.delete,
                child: Text("Delete"),
              ),
              const PopupMenuItem<Options>(
                value: Options.update,
                child: Text("Update"),
              ),
            ],
          )
        ],
        backgroundColor: Colors.amber,
      ),
      body: buildProductDetail(),
    );
  }

  buildProductDetail() {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [buildNameField(), buildDescriptionField(), buildUnitPriceField()],
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

//işlem seçme
  void selectProcess(Options options) async {
    // print(value);
    //silme
    switch (options) {
      case Options.delete:
        if (product.id != null) {
          await dbHelper.delete(product.id!);
          // ignore: use_build_context_synchronously
          Navigator.pop(context, true);
        }
        break;
      case Options.update:
        if (product.id != null) {
          await dbHelper.update(Product.withId(
            id: product.id,
            name: txtName.text,
            description: txtDescription.text,
            unitPrice: double.tryParse(txtUnitPrice.text),
          ));
          // ignore: use_build_context_synchronously
          Navigator.pop(context, true);
        }
        break;
      default:
    }
  }
}
