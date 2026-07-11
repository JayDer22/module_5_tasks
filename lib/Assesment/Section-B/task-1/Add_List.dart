import 'package:flutter/material.dart';

import 'Home_Screen.dart';

class AddList extends StatefulWidget {
  final Function(String, String, String) onAdd;

  const AddList({
    super.key,
    required this.onAdd,
  });

  @override
  State<AddList> createState() => _AddListState();
}

class _AddListState extends State<AddList> {
  TextEditingController name = TextEditingController();
  TextEditingController catagory = TextEditingController();
  TextEditingController price = TextEditingController();
  List<dynamic> Adddata = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar:
    AppBar
    (
        title: Text
        (
            "Add List"
        )
    ),
      body: Column(
        children: [
          TextField(
            controller: name,
            decoration: InputDecoration(
              labelText: "Product",
              hintText: "Enter Product Name...",
              border: OutlineInputBorder()
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: catagory,
            decoration: InputDecoration(
                labelText: "Category",
                hintText: "Enter Category Name...",
                border: OutlineInputBorder()
            ),
          ),
          SizedBox(height:10,),
          TextField(
            controller: price,
            decoration: InputDecoration(
                labelText: "Price",
                hintText: "Enter Price...",
                border: OutlineInputBorder()
            ),
          ),
          SizedBox(height: 10,),
          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              List<Map<String, String>> products = [
                {
                  "product": name.text,
                  "category": catagory.text,
                  "price": price.text,
                }
              ];

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(
                    products: products,
                  ),
                ),
              );
            },
            child: const Text("Next"),
          )
        ],
      )

    );

  }
}
