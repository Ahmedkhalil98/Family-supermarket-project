import 'package:url_launcher/url_launcher.dart';

class LaunchProvider {
  Future makePhoneCall(String phoneNumber) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    "tel:$phoneNumber";
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw "Can Not Open phoneCall";
    }
  }

  makeMap(String latLong) async {
    final Uri muri = Uri();
    String mapUrl = "https://www.google.com/maps/search/?api=1&query=$latLong";
    if (await canLaunch(mapUrl)) {
      await launch(mapUrl);
    } else {
      throw "Can Not Open phoneCall";
    }
  }
}
