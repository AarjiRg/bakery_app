import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final List<Map<String, dynamic>> flavors = [
      {'name': 'Vanilla', 'color': Colors.amber.withOpacity(0.60)},
      {'name': 'Chocolate', 'color': Colors.brown.withOpacity(0.60)},
      {'name': 'Strawberry', 'color': Colors.pink.withOpacity(0.60)},
      {'name': 'Blueberry', 'color': Colors.blue.withOpacity(0.60)},
      {'name': 'Mint', 'color': Colors.green.withOpacity(0.60)},
      {'name': 'Lemon', 'color': Colors.yellow.withOpacity(0.60)},
    ];


    final List<Map<String, dynamic>> popularIceCreams = [
      {
        'name': 'Chocolate Delight',
        'image': 'images/image1.png',
        'price': '\$5.99',
        'rating': 4.5
      },
      {
        'name': 'Strawberry Bliss',
        'image': 'images/image2.png',
        'price': '\$4.99',
        'rating': 4.8
      },
      {
        'name': 'Minty Fresh',
        'image': 'images/image3.png',
        'price': '\$6.49',
        'rating': 4.2
      },
      {
        'name': 'Vanilla Classic',
        'image': 'images/image4.png',
        'price': '\$4.49',
        'rating': 4.7
      },
    ];

    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Hello! ",
                            style: TextStyle(
                              color: const Color.fromARGB(246, 110, 5, 170),
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: "User,",
                            style: TextStyle(
                              color: Colors.pink,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),

              // Search bar
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width - 50,
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: const Color.fromARGB(255, 217, 138, 233)
                              .withOpacity(.20),
                          filled: true,
                          prefixIcon: Icon(Icons.search,
                              color: const Color.fromARGB(246, 110, 5, 170)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 1,
                                color: const Color.fromARGB(255, 131, 11, 155)
                                    .withOpacity(.20)),
                          ),
                          hintText: 'Search Desserts',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  )
                ],
              ),

              // Flavours title
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Flavours",
                  style: TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
              ),

              // Horizontally scrollable list of flavors
              Container(
                height: 50, // Height for the scrollable flavor boxes
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: flavors.length,
                  itemBuilder: (context, index) {
                    final flavor = flavors[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        width: 120,
                        decoration: BoxDecoration(
                          color: flavor['color'],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            flavor['name'],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 20),
              // Popular Ice Cream heading
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Popular Ice Cream",
                  style: TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
              ),

              // Horizontally scrollable cards for popular ice creams
              Container(
                height: 220, // Adjust the height for the card content
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: popularIceCreams.length,
                  itemBuilder: (context, index) {
                    final iceCream = popularIceCreams[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Container(
                          width: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(15)),
                                child: Image.network(
                                  iceCream['image'],
                                  height: 100,
                                  width: double.infinity,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  iceCream['name'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0),
                                child: Text(
                                  iceCream['price'],
                                  style: TextStyle(
                                    color: Colors.pink,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.star,
                                        color: Colors.amber, size: 16),
                                    SizedBox(width: 4),
                                    Text(
                                      "${iceCream['rating']}",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}