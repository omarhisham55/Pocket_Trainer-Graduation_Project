import 'package:flutter_qjs/flutter_qjs.dart';
import 'package:http/http.dart' as http;
// Future<void> startDetection() async {
//   final qjs = Qjs();
//   final result = await qjs.evalFile('python_scripts/myscript.py');
//   print('Python script execution result: $result');
//   await qjs.release();
// }

void startDetection() async{
  final response = await http.get(Uri.parse('http://your-server-url/execute-python-script'));
  if (response.statusCode == 200) {
    // Python script executed successfully
    print(response.body);
  } else {
    print('Error executing Python script: ${response.statusCode}');
  }
}