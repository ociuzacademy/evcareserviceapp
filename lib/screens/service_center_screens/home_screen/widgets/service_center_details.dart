import 'package:evcareserviceapp/common_utils/urls.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/models/service_center_profile_model.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/services/get_service_centre_profile_details.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/widgets/store_open_status.dart';
import 'package:flutter/material.dart';

class ServiceCenterDetails extends StatelessWidget {
  const ServiceCenterDetails({
    super.key,
    required this.serviceCenterId,
  });

  final TimeOfDay openingTime = const TimeOfDay(hour: 9, minute: 0); // 9:00 AM
  final TimeOfDay closingTime = const TimeOfDay(hour: 18, minute: 0); // 6:00 PM
  final int serviceCenterId;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return FutureBuilder<ServiceCenterProfileModel>(
      future: getServiceCenterProfileDetails(serviceCentreId: serviceCenterId),
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
        if (!snapshot.hasData || snapshot.data == null) {
          return Center(
            child: Column(
              children: [
                Image.asset("assets/images/empty.png"),
                const Text(
                  "No employee profile details found.",
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
        ServiceCenterProfileModel profileModel = snapshot.data!;
        return Column(
          children: [
            profileModel.image == null
                ? Image.asset("assets/images/service_center.jpeg")
                : Image.network("${Urls.baseUrl}/${profileModel.image!}"),
            SizedBox(
              height: screenSize.height * 0.01,
            ),
            Text(
              profileModel.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              profileModel.address,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 18,
              ),
            ),
            StoreOpenStatus(
              openingTime: openingTime,
              closingTime: closingTime,
            ),
          ],
        );
      },
    );
  }
}
