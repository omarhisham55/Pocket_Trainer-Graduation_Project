import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<String> getIPAddress() async {
  final response = await http.get(Uri.parse('https://api.ipify.org?format=json'));
  final data = jsonDecode(response.body);
  final publicIP = data['ip'];
  print(publicIP);
  return publicIP;
  // // Get a list of all network interfaces
  // final interfaces = await NetworkInterface.list();
  //
  // // Loop through each interface and find the first non-loopback IPv4 address
  // for (final interface in interfaces) {
  //   if (interface.name.toLowerCase().contains('loopback')) {
  //     continue;
  //   }
  //
  //   final address = interface.addresses
  //       .firstWhere((addr) => addr.type == InternetAddressType.IPv4);
  //
  //   if (address != null) {
  //     return address.address;
  //   }
  }

  // If no IPv4 address is found, return an empty string
  // return '';