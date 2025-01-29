import 'package:evcareserviceapp/common_utils/local_storage.dart';
import 'package:evcareserviceapp/screens/service_center_screens/feedback_list_screen/models/feedback_model.dart';
import 'package:evcareserviceapp/screens/service_center_screens/feedback_list_screen/services/get_user_feedacks.dart';
import 'package:evcareserviceapp/screens/service_center_screens/feedback_list_screen/widgets/feedback_container.dart';
import 'package:flutter/material.dart';

class FeedbackListScreen extends StatefulWidget {
  const FeedbackListScreen({super.key});

  @override
  State<FeedbackListScreen> createState() => _FeedbackListScreenState();
}

class _FeedbackListScreenState extends State<FeedbackListScreen> {
  late int _serviceCentreId;

  @override
  void initState() {
    super.initState();
    _getServiceCentreId();
  }

  Future<void> _getServiceCentreId() async {
    final userId = await LocalStorage.getServiceCentreId();
    setState(() {
      _serviceCentreId = userId;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Feedbacks"),
        backgroundColor: Colors.black,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: FutureBuilder<List<FeedbackModel>>(
        future: getUserFeedbacks(serviceCentreId: _serviceCentreId),
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
                    "No feedbacks found",
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
          List<FeedbackModel> feedbacks = snapshot.data!;
          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
            itemBuilder: (context, index) {
              FeedbackModel feedbackItem = feedbacks[index];
              return FeedbackContainer(
                feedbackItem: feedbackItem,
              );
            },
            separatorBuilder: (_, __) => SizedBox(
              height: screenSize.height * 0.01,
            ),
            itemCount: feedbacks.length,
          );
        },
      ),
    );
  }
}
