// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evcareserviceapp/common_utils/local_storage.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/models/purchase_history_model.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/services/get_purchase_history.dart';
import 'package:flutter/material.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/widgets/purchase_history_tile.dart';

class PurchaseHistoryWidget extends StatefulWidget {
  const PurchaseHistoryWidget({
    super.key,
  });

  @override
  State<PurchaseHistoryWidget> createState() => _PurchaseHistoryWidgetState();
}

class _PurchaseHistoryWidgetState extends State<PurchaseHistoryWidget> {
  int? _serviceCentreId;

  @override
  void initState() {
    super.initState();
    _getServiceCentreId();
  }

  Future<void> _getServiceCentreId() async {
    final userId = await LocalStorage.getServiceCentreId();
    if (mounted) {
      setState(() {
        _serviceCentreId = userId;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return _serviceCentreId == null
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          )
        : FutureBuilder<List<PurchaseHistoryModel>>(
            future: getPurchaseHistory(serviceCentreId: _serviceCentreId!),
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
                        "No purchase history found",
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
              List<PurchaseHistoryModel> purchases = snapshot.data!.toList();
              return ListView.separated(
                itemCount: purchases.length,
                itemBuilder: (context, index) {
                  PurchaseHistoryModel purchaseEntry = purchases[index];
                  // print("Unit price: ${purchaseEntry.unitPrice}");
                  // print("Price: ${purchaseEntry.price}");
                  // print("Quantity: ${purchaseEntry.quantity}");
                  return PurchaseHistoryTile(
                    customerName: purchaseEntry.userName ?? "Name empty",
                    productName:
                        purchaseEntry.productName ?? "Product name empty",
                    purchaseDate: purchaseEntry.date ?? DateTime.now(),
                    unitPrice: double.parse(purchaseEntry.unitPrice ?? "0.0"),
                    productCost: double.parse(purchaseEntry.price ?? "0.0"),
                    quantity: purchaseEntry.quantity ?? 0,
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: screenSize.height / 1000,
                ),
              );
            },
          );
  }
}

/**
 * 
 */
