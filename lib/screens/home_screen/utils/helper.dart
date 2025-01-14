import 'dart:math';

class Helper {
  static DateTime generateRandomDate() {
    final random = Random();

    int year =
        random.nextInt(2025 - 2000) + 2000; // Random year between 2000 and 2025

    int month = random.nextInt(12) + 1;

    int day = random.nextInt(28) + 1;

    return DateTime(year, month, day);
  }

  static String generateKeralaVehicleNumber() {
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

  static String generateRandomEmail() {
    const String chars = "abcdefghijklmnopqrstuvwxyz0123456789";
    final rnd = Random();
    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
    String username = getRandomString(10);
    String domain = getRandomString(5);
    String tld = getRandomString(3);
    return "$username@$domain.$tld";
  }

  static String generateRandomIndianMobileNumber() {
    const List<String> prefixes = [
      "6",
      "7",
      "8",
      "9"
    ]; // Indian mobile numbers typically start with these digits
    Random random = Random();
    String prefix = prefixes[random.nextInt(prefixes.length)];
    String remainingDigits =
        List.generate(9, (index) => random.nextInt(10).toString()).join();
    return "+91$prefix$remainingDigits";
  }
}
