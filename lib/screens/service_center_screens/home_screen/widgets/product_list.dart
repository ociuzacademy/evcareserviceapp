import 'package:evcareserviceapp/common_utils/urls.dart';
import 'package:evcareserviceapp/screens/service_center_screens/add_to_store_screen/views/add_to_store_screen.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/models/product_model.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/services/get_products.dart';
import 'package:evcareserviceapp/screens/service_center_screens/product_details_screen/views/product_details_screen.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

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
              child: Text(
                "Error: ${snapshot.error}",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            );
          }

          // Empty Response data array
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "No products found",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            );
          }

          // Success State
          List<ProductModel> products = snapshot.data!.toList();
          return ListView.separated(
            itemBuilder: (context, index) {
              ProductModel product = products[index];
              double price = double.parse(product.price ?? "0.0");
              String imageUrl = "${Urls.baseUrl}/${product.imagePath ?? ""}";
              return InkWell(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProductDetailsScreen(
                      productName: product.name ?? "No name available",
                      productDescription:
                          product.description ?? "No description available",
                      productPrice: double.parse(product.price ?? "0.0"),
                      productQuantity: int.parse(product.quantity ?? "0"),
                      productImage: imageUrl,
                      productHeroId: "hero-${product.id}",
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
                        tag: "hero-${product.id}",
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                imageUrl,
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
                          fontSize: 15,
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
