import 'package:evcareserviceapp/screens/service_center_screens/feedback_list_screen/models/feedback_model.dart';
import 'package:evcareserviceapp/screens/service_center_screens/feedback_list_screen/widgets/feedback_column_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FeedbackContainer extends StatelessWidget {
  const FeedbackContainer({
    super.key,
    required this.feedbackItem,
  });

  final FeedbackModel feedbackItem;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final dateFormat = DateFormat("dd/MM/yyyy");
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenSize.width * 0.05,
        vertical: screenSize.height * 0.009,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.green,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FeedbackColumnWidget(
                title: "Customer Name",
                value: feedbackItem.userName,
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
              FeedbackColumnWidget(
                title: "Date",
                value: dateFormat.format(feedbackItem.date),
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
              FeedbackColumnWidget(
                title: "Repair ID",
                value: feedbackItem.repair.toString(),
                crossAxisAlignment: CrossAxisAlignment.end,
              ),
            ],
          ),
          const Divider(
            color: Colors.green,
          ),
          FeedbackColumnWidget(
            title: "Feedback",
            value: feedbackItem.feedback,
            crossAxisAlignment: CrossAxisAlignment.stretch,
          ),
        ],
      ),
    );
  }
}
