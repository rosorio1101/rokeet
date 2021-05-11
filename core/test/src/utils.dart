import 'dart:convert';
import 'dart:io';

extension ReadFile on String {
  String readFileAsString() => File(this).readAsStringSync();
}

dynamic loadJson(String fileName) => jsonDecode('test/resources/$fileName.json'.readFileAsString());

class RokeetTestUtils {

}