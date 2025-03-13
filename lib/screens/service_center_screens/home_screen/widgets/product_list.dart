import 'package:flutter/material.dart';

import 'package:evcareserviceapp/common_utils/urls.dart';
import 'package:evcareserviceapp/screens/service_center_screens/add_to_store_screen/views/add_to_store_screen.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/models/product_model.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/services/get_products.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/widgets/custom_list_tile.dart';
import 'package:evcareserviceapp/screens/service_center_screens/product_details_screen/views/product_details_screen.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    super.initState();
  }

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
      body: FutureBuilder<List<ProductModel>>(
        future: getProducts(),
        builder: (context, snapshot) {
          // Loading State
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            );
          }

          // Error State
          if (snapshot.hasError) {
            return Center(
              child: Column(
                children: [
                  Image.asset("assets/images/error_image.png"),
                  Text(
                    "${snapshot.error}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            );
          }

          // Empty Response data array
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                children: [
                  Image.asset("assets/images/empty.png"),
                  const Text(
                    "No products found",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            );
          }

          // Success State
          List<ProductModel> products = snapshot.data!.toList();
          return ListView.separated(
            padding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.025,
            ),
            itemBuilder: (context, index) {
              ProductModel product = products[index];
              double price = double.parse(product.price ?? "0.0");
              // print(product.image == null);
              String imageUrl = product.image == null
                  ? "assets/images/no_image_available.jpg"
                  : "${Urls.baseUrl}${product.image ?? ""}";
              return InkWell(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProductDetailsScreen(
                      productId: product.id ?? 0,
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
                  padding: const EdgeInsets.all(8),
                  child: Card(
                    color: Colors.black,
                    borderOnForeground: true,
                    child: CustomListTile(
                      leading: Hero(
                        tag: "hero-${product.id}",
                        child: Container(
                          height: screenSize.height * 0.25,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: product.image == null
                                  ? AssetImage(imageUrl)
                                  : NetworkImage(imageUrl), // Corrected here
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
                        product.name ?? "No name available",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      subTitle: Text(
                        "Price: ₹${price.toStringAsFixed(2)}",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
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
          );
        },
      ),
    );
  }
}
