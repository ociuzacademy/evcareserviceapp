// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evcareserviceapp/screens/home_screen/widgets/purchase_history_tile_content.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PurchaseHistoryTile extends StatelessWidget {
  final String customerName;
  final String productName;
  final double unitPrice;
  final int quantity;
  final double productCost;
  final DateTime purchaseDate;
  const PurchaseHistoryTile({
    super.key,
    required this.customerName,
    required this.productName,
    required this.unitPrice,
    required this.quantity,
    required this.productCost,
    required this.purchaseDate,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final dateFormat = DateFormat("dd/MM/yyyy");

    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      height: screenSize.height * 0.13,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.green,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PurchaseHistoryTileContent(
                crossAxisAlignment: CrossAxisAlignment.start,
                item: "Customer Name",
                value: customerName,
              ),
              PurchaseHistoryTileContent(
                crossAxisAlignment: CrossAxisAlignment.end,
                item: "Purchase Date",
                value: dateFormat.format(purchaseDate),
              ),
            ],
          ),
          const Divider(
            color: Colors.green,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PurchaseHistoryTileContent(
                crossAxisAlignment: CrossAxisAlignment.start,
                item: "Product Name",
                value: productName,
              ),
              PurchaseHistoryTileContent(
                crossAxisAlignment: CrossAxisAlignment.center,
                item: "Unit Price",
                value: "₹${unitPrice.toStringAsFixed(2)}",
              ),
              PurchaseHistoryTileContent(
                item: "Quantity",
                value: quantity.toString(),
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
              PurchaseHistoryTileContent(
                value: "₹${productCost.toStringAsFixed(2)}",
                item: "Product Cost",
                crossAxisAlignment: CrossAxisAlignment.end,
              )
            ],
          )
        ],
      ),
    );
  }
}
