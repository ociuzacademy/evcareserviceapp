import 'package:flutter/material.dart';

import 'package:evcareserviceapp/common_utils/urls.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/models/service_center_profile_model.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/services/get_service_centre_profile_details.dart';
import 'package:evcareserviceapp/screens/service_center_screens/home_screen/widgets/store_open_status.dart';

class ServiceCentreDetails extends StatefulWidget {
  const ServiceCentreDetails({
    super.key,
  });

  @override
  State<ServiceCentreDetails> createState() => _ServiceCentreDetailsState();
}

class _ServiceCentreDetailsState extends State<ServiceCentreDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return FutureBuilder<ServiceCentreProfileModel>(
      future: getServiceCentreProfileDetails(),
      builder: (context, snapshot) {
        // Loading State
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            ),
          );
        }

        // Error State
        if (snapshot.hasError) {
          return SliverToBoxAdapter(
            child: Center(
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
            ),
          );
        }

        // Empty Response data array
        if (!snapshot.hasData || snapshot.data == null) {
          return SliverToBoxAdapter(
            child: Center(
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
            ),
          );
        }

        // Success State
        ServiceCentreProfileModel profileModel = snapshot.data!;
        return SliverToBoxAdapter(
          child: Column(
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
              const StoreOpenStatus(),
            ],
          ),
        );
      },
    );
  }
}
