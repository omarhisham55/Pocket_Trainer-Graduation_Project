// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// // import 'package:process_run/process_run.dart';
// import 'package:path/path.dart' as path;
//
// Future<String> getIPAddress() async {
//   final response = await http.get(Uri.parse('https://api.ipify.org?format=json'));
//   final data = jsonDecode(response.body);
//   final publicIP = data['ip'];
//   print(publicIP);
//   return publicIP;
//   // // Get a list of all network interfaces
//   // final interfaces = await NetworkInterface.list();
//   //
//   // // Loop through each interface and find the first non-loopback IPv4 address
//   // for (final interface in interfaces) {
//   //   if (interface.name.toLowerCase().contains('loopback')) {
//   //     continue;
//   //   }
//   //
//   //   final address = interface.addresses
//   //       .firstWhere((addr) => addr.type == InternetAddressType.IPv4);
//   //
//   //   if (address != null) {
//   //     return address.address;
//   //   }
//   }
//
//   // If no IPv4 address is found, return an empty string
//   // return '';
//
//     final mainPath = Directory.current.path;
//     final nodePath = Directory(path.join(mainPath, 'Pocket-Trainer-Graduation-Project'));
//
// class NodeRunner {
//   static void startNodeApp() async {
//
//     if (await nodePath.exists()) {
//       try {
//         // Switch to the main folder
//         Directory.current = Directory(mainPath);
//
//         // Switch to the node folder
//         Directory.current = nodePath;
//
//         // Run the Node.js app
//         final process = await Process.start('node', ['app.js']);
//         process.stdout.transform(utf8.decoder).listen((data) {
//           print('Node App Output: $data');
//         });
//         process.stderr.transform(utf8.decoder).listen((data) {
//           print('Node App Error: $data');
//         });
//         await process.exitCode;
//
//         // Switch back to the main folder
//         Directory.current = Directory(mainPath);
//       } catch (e) {
//         print('Error: $e');
//       }
//     } else {
//       print('Node folder not found');
//     }
//   }
// }
//
//
