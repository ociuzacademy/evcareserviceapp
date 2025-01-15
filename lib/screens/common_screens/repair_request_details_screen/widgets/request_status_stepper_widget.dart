// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';

class RequestStatusStepperWidget extends StatelessWidget {
  const RequestStatusStepperWidget({
    super.key,
    required this.currentStatus,
  });

  final String currentStatus;

  @override
  Widget build(BuildContext context) {
    final int activeStep = currentStatus == "Repair Requested"
        ? 1
        : currentStatus == "Mechanic Assigned"
            ? 2
            : currentStatus == "Repair Completed"
                ? 3
                : 4;

    return EasyStepper(
      activeStep: activeStep,
      lineStyle: const LineStyle(
        lineLength: 50,
        lineType: LineType.normal,
        lineThickness: 3,
        lineSpace: 1,
        lineWidth: 10,
        unreachedLineType: LineType.dashed,
      ),
      stepShape: StepShape.rRectangle,
      stepBorderRadius: 15,
      borderThickness: 2,
      internalPadding: 25,
      stepRadius: 28,
      finishedStepBorderColor: Colors.green,
      finishedStepTextColor: Colors.green,
      finishedStepBackgroundColor: Colors.green,
      activeStepIconColor: Colors.green,
      showLoadingAnimation: false,
      steps: [
        EasyStep(
          customStep: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Opacity(
              opacity: activeStep >= 0 ? 1 : 0.3,
              child: Image.asset(
                "assets/icons/icons8-car-breakdown-66.png",
              ),
            ),
          ),
          customTitle: Text(
            "Repair Requested",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: activeStep >= 0 ? Colors.white : Colors.grey,
            ),
          ),
        ),
        EasyStep(
          customStep: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Opacity(
              opacity: activeStep >= 1 ? 1 : 0.3,
              child: Image.asset(
                "assets/icons/icons8-car-repair-66.png",
              ),
            ),
          ),
          customTitle: Text(
            "Mechanic Assigned",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: activeStep >= 0 ? Colors.white : Colors.grey,
            ),
          ),
        ),
        EasyStep(
          customStep: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Opacity(
              opacity: activeStep >= 2 ? 1 : 0.3,
              child: Image.asset(
                "assets/icons/icons8-task-completed-66.png",
              ),
            ),
          ),
          customTitle: Text(
            "Repair Completed",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: activeStep >= 0 ? Colors.white : Colors.grey,
            ),
          ),
        ),
        EasyStep(
          customStep: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Opacity(
              opacity: activeStep >= 3 ? 1 : 0.3,
              child: Image.asset(
                "assets/icons/icons8-bill-66.png",
              ),
            ),
          ),
          customTitle: Text(
            "Vehicle Delivered",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: activeStep >= 0 ? Colors.white : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
