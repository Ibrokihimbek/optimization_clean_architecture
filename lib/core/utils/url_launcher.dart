part of "utils.dart";

sealed class UrlLauncher {
  UrlLauncher._();

  static Future<void> getUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception("Could not launch $url");
    }
  }

  static Future<void> switchPhoneNumber(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: "tel", path: phoneNumber);
    try {
      await launchUrl(phoneUri);
    } on Exception catch (_) {
      throw ArgumentError("Cannot dial");
    }
  }

  static Future<void> switchMessage(String phoneNumber) async {
    final Uri smsLaunchUri = Uri(
      scheme: "sms",
      path: "0118 999 881 999 119 7253",
      queryParameters: <String, String>{
        "body": Uri.encodeComponent("Example Subject & Symbols are allowed!"),
      },
    );
    try {
      if (await canLaunchUrl(smsLaunchUri)) {
        await launchUrl(smsLaunchUri);
      }
    } on Exception catch (_) {
      throw ArgumentError("Cannot dial");
    }
  }
}
