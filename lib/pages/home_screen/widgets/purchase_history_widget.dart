// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:evcareserviceapp/pages/home_screen/widgets/purchase_history_tile.dart';

class PurchaseHistoryWidget extends StatelessWidget {
  final List<Map<String, dynamic>> purchaseHistory;
  const PurchaseHistoryWidget({
    super.key,
    required this.purchaseHistory,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return ListView.separated(
      itemCount: purchaseHistory.length,
      itemBuilder: (context, index) {
        return PurchaseHistoryTile(
          customerName: purchaseHistory[index]['customerName'],
          productName: purchaseHistory[index]['productName'],
          purchaseDate:
              purchaseHistory[index]['purchaseDate'] ?? DateTime.now(),
          unitPrice: purchaseHistory[index]['unitPrice'] ?? 0.0,
          productCost: purchaseHistory[index]['productCost'] ?? 0.0,
          quantity: purchaseHistory[index]['quantity'] as int,
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        height: screenSize.height / 1000,
      ),
    );
  }
}
