
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flipkart Wishlist",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WishlistScreen(),
    );
  }
}

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  List<Map<String, dynamic>> products = [
    {
      "name": "iPhone 16 Pro",
      "price": "₹1,19,900",
      "rating": "4.8",
       "image":  "assets/img.png",
    },
    {
      "name": "Nike Air Max",
      "price": "₹6,999",
      "rating": "4.6",
      "image":  "assets/img_1.png"
    },
    {
      "name": "boAt Rockerz 450",
      "price": "₹1,999",
      "rating": "4.4",
      "image": "assets/img_2.png"},
    {
      "name": "HP Pavilion Laptop",
      "price": "₹59,999",
      "rating": "4.5",
      "image" : "assets/img_3.png"

    },
  ];

  List<Map<String, dynamic>> wishlist = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,

      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Flipkart Wishlist",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          WishlistPage(wishlist: wishlist),
                    ),
                  );
                },
              ),

              if (wishlist.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(
                    radius: 9,
                    backgroundColor: Colors.white,
                    child: Text(
                      wishlist.length.toString(),
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          )
        ],
      ),

      body: GridView.builder(
        padding: const EdgeInsets.all(10),

        itemCount: products.length,

        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .62,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),

        itemBuilder: (context, index) {

          bool isFav =
          wishlist.contains(products[index]);

          return Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Expanded(
                  flex: 5,
                  child: ClipRRect(
                    borderRadius:
                    const BorderRadius.vertical(
                      top: Radius.circular(15),
                    ),
                    child: Image.network(
                      products[index]["image"],
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Expanded(
                  flex: 4,
                  child: Padding(
                    padding:
                    const EdgeInsets.all(8.0),

                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        Text(
                          products[index]["name"],
                          style: const TextStyle(
                            fontWeight:
                            FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          products[index]["price"],
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight:
                            FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Row(
                          children: [

                            Container(
                              padding:
                              const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2),

                              decoration:
                              BoxDecoration(
                                color: Colors.green,
                                borderRadius:
                                BorderRadius.circular(
                                    5),
                              ),

                              child: Row(
                                children: [
                                  Text(
                                    products[index]
                                    ["rating"],
                                    style:
                                    const TextStyle(
                                      color:
                                      Colors.white,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.star,
                                    size: 14,
                                    color:
                                    Colors.white,
                                  )
                                ],
                              ),
                            ),

                            const Spacer(),

                            IconButton(
                              onPressed: () {

                                setState(() {

                                  if (isFav) {
                                    wishlist.remove(
                                        products[
                                        index]);
                                  } else {
                                    wishlist.add(
                                        products[
                                        index]);
                                  }

                                });

                              },

                              icon: Icon(
                                isFav
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.red,
                              ),
                            )

                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class WishlistPage extends StatefulWidget {
  final List<Map<String, dynamic>> wishlist;

  const WishlistPage({
    super.key,
    required this.wishlist,
  });

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,

      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "My Wishlist",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),

      body: widget.wishlist.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 90,
              color: Colors.grey,
            ),
            SizedBox(height: 15),
            Text(
              "Your Wishlist is Empty",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Tap ❤️ on any product to add it here.",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      )

          : ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: widget.wishlist.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),

              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.wishlist[index]["image"],
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),

              title: Text(
                widget.wishlist[index]["name"],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),

                  Text(
                    widget.wishlist[index]["price"],
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius:
                          BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            Text(
                              widget.wishlist[index]["rating"],
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            const Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              trailing: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  setState(() {
                    widget.wishlist.removeAt(index);
                  });

                  if (widget.wishlist.isEmpty) {
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
