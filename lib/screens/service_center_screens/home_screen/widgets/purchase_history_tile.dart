// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:evcareserviceapp/common_widgets/custom_column_widget.dart';

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
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.01),
      width: double.infinity,
      height: screenSize.height * 0.15,
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
              CustomColumnWidget(
                crossAxisAlignment: CrossAxisAlignment.start,
                title: "Customer Name",
                value: customerName,
                titleStyle: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                valueStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
                truncateLength: 20,
              ),
              CustomColumnWidget(
                crossAxisAlignment: CrossAxisAlignment.end,
                title: "Purchase Date",
                value: dateFormat.format(purchaseDate),
                titleStyle: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                valueStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
                truncateLength: 20,
              ),
            ],
          ),
          const Divider(
            color: Colors.green,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomColumnWidget(
                crossAxisAlignment: CrossAxisAlignment.start,
                title: "Product Name",
                value: productName,
                titleStyle: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                valueStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
                truncateLength: 20,
              ),
              CustomColumnWidget(
                crossAxisAlignment: CrossAxisAlignment.center,
                title: "Unit Price",
                value: "₹${unitPrice.toStringAsFixed(2)}",
                titleStyle: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                valueStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
                truncateLength: 20,
              ),
              CustomColumnWidget(
                title: "Quantity",
                value: quantity.toString(),
                crossAxisAlignment: CrossAxisAlignment.center,
                titleStyle: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                valueStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
                truncateLength: 20,
              ),
              CustomColumnWidget(
                value: "₹${productCost.toStringAsFixed(2)}",
                title: "Product Cost",
                crossAxisAlignment: CrossAxisAlignment.end,
                titleStyle: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                valueStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
                truncateLength: 20,
              ),
            ],
          )
        ],
      ),
    );
  }
}
