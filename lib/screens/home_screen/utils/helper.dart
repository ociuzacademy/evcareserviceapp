import 'dart:math';

DateTime generateRandomDate() {
  final random = Random();

  int year =
      random.nextInt(2025 - 2000) + 2000; // Random year between 2000 and 2025

  int month = random.nextInt(12) + 1;

  int day = random.nextInt(28) + 1;

  return DateTime(year, month, day);
}

String generateKeralaVehicleNumber() {
  final random = Random();

  // Generate district code (01 to 99)
  final districtCode = random.nextInt(86) + 1; // 1 to 86
  final districtCodeFormatted = districtCode.toString().padLeft(2, '0');

  // Generate alphabetical series (AA to ZZ)
  const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  final series = String.fromCharCodes([
    alphabet.codeUnitAt(random.nextInt(26)), // Random first letter
    alphabet.codeUnitAt(random.nextInt(26)), // Random second letter
  ]);

  // Generate vehicle number (0001 to 9999)
  final vehicleNumber = random.nextInt(9999) + 1; // 1 to 9999
  final vehicleNumberFormatted = vehicleNumber.toString().padLeft(4, '0');

  // Combine all parts to form the registration number
  return 'KL-$districtCodeFormatted-$series-$vehicleNumberFormatted';
}
