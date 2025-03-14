import 'package:evcareserviceapp/common_models/service_center_profile_model.dart';
import 'package:evcareserviceapp/common_services/get_service_centre_profile_details.dart';
import 'package:evcareserviceapp/screens/service_center_screens/edit_profile_screen/widget/edit_profile_form.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Edit Service Centre"),
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
      body: FutureBuilder(
        future: getServiceCentreProfileDetails(),
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

          ServiceCentreProfileModel profileModel = snapshot.data!;

          return EditProfileForm(profileModel: profileModel);
        },
      ),
    );
  }
}
