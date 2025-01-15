import 'package:evcareserviceapp/screens/service_center_screens/add_to_store_screen/views/add_to_store_screen.dart';
import 'package:evcareserviceapp/screens/service_center_screens/product_details_screen/views/product_details_screen.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  const ProductList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddToStoreScreen(),
          ));
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          double price = products[index]["price"];
          return InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProductDetailsScreen(
                  productName: products[index]['name'],
                  productDescription: products[index]['description'],
                  productPrice: products[index]['price'],
                  productQuantity: products[index]['quantity'],
                  productImage: products[index]['image'],
                  productHeroId: products[index]['heroId'],
                ),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.green,
                  width: 2,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Card(
                color: Colors.black,
                borderOnForeground: true,
                child: CustomListTile(
                  leading: Hero(
                    tag: products[index]["heroId"],
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            products[index]["image"],
                          ),
                          fit: BoxFit.fitHeight,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    products[index]["name"],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                  subTitle: Text(
                    "Price: ₹${price.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (_, __) => SizedBox(
          height: screenSize.height * 0.01,
        ),
        itemCount: products.length,
      ),
    );
  }
}
