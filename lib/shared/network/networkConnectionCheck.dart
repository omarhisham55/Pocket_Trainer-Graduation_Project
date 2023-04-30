import 'dart:io';

Future<String> getIPAddress() async {
  // Get a list of all network interfaces
  final interfaces = await NetworkInterface.list();

  // Loop through each interface and find the first non-loopback IPv4 address
  for (final interface in interfaces) {
    if (interface.name.toLowerCase().contains('loopback')) {
      continue;
    }

    final address = interface.addresses
        .firstWhere((addr) => addr.type == InternetAddressType.IPv4);

    if (address != null) {
      return address.address;
    }
  }

  // If no IPv4 address is found, return an empty string
  return '';
}