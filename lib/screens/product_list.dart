import 'package:flutter/material.dart';
import 'package:sqflite_demo/Models/Product.dart';
import 'package:sqflite_demo/data/dbHelper.dart';
import 'package:sqflite_demo/screens/product_add.dart';
import 'package:sqflite_demo/screens/product_detail.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  var dbHelper = DbHelper();
  List<Product>? products;
  int productCount = 0;

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        backgroundColor: Colors.amber,
      ),
      body: buildProductList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        splashColor: Colors.red,
        tooltip: "Add new product",
        child: const Icon(Icons.add, color: Colors.black),
        onPressed: () {
          goToProductAdd();
        },
      ),
    );
  }

//ürün bilgileri
  buildProductList() {
    return ListView.builder(
      itemCount: productCount,
      itemBuilder: (BuildContext context, int position) {
        return Padding(
          padding: const EdgeInsets.all(7.0),
          child: Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: Colors.amber,
              ),
              borderRadius: BorderRadius.circular(20.0), //<-- SEE HERE
            ),
            color: Colors.green[100],
            elevation: 5,
            child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.black12,
                  child: Text("P"),
                ),
                title: Text(
                  products![position].name.toString(),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Description: ${products![position].description.toString()}",
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Unit Price: ${products![position].unitPrice.toString()}",
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                onTap: () {
                  goToDetail(products![position]);
                }),
          ),
        );
      },
    );
  }

  void goToProductAdd() async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductAdd()));

    if (result) {
      getProducts();
    }
  }

  void goToDetail(Product product) async {
    bool? result = await Navigator.push<bool?>(
      context,
      MaterialPageRoute(builder: (context) => ProductDetail(product)),
    );

    if (result != null && result) {
      getProducts();
    }
  }

  void getProducts() async {
    var productsFuture = dbHelper.getProducts();
    productsFuture.then(
      (data) {
        //ikinci ürün silmenin hata gidermesi
        setState(() {
          products = data;
          productCount = data.length;
        });
      },
    );
  }
}
