import 'dart:convert';
import 'dart:typed_data';
import 'package:dart_easy_json/test_models.dart';
import 'package:dart_easy_json/generated/test_models.easy.dart';
import 'package:test/test.dart';

void main() {
  group('Uint8List / Base64 serialization', () {
    test('toJson generates base64 strings', () {
      final doc = DocumentModel(
        fileData: Uint8List.fromList([1, 2, 3]),
        optionalData: Uint8List.fromList([4, 5, 6]),
      );

      final json = doc.toJson();
      expect(json['fileData'], base64Encode([1, 2, 3]));
      expect(json['optionalData'], base64Encode([4, 5, 6]));
    });

    test('fromJson reads base64 strings', () {
      final json = {
        'fileData': base64Encode([10, 20, 30]),
        'optionalData': base64Encode([40, 50, 60]),
      };

      final doc = DocumentModel.fromJson(json);
      expect(doc.fileData, [10, 20, 30]);
      expect(doc.optionalData, [40, 50, 60]);
    });

    test('fromJsonSafe provides fallbacks for invalid base64', () {
      final issues = [];
      final json = {
        'fileData': 'not-base64!', // invalid
        'optionalData': 12345, // wrong type
      };

      final doc = DocumentModel.fromJsonSafe(json, onIssue: issues.add);
      
      expect(doc.fileData.isEmpty, isTrue); // fallback is Uint8List(0)
      expect(doc.optionalData, isNull);     // fallback is null

      expect(issues.any((i) => i.path == 'fileData' && i.code == 'invalid_base64'), isTrue);
      expect(issues.any((i) => i.path == 'optionalData' && i.code == 'type_mismatch'), isTrue);
    });
    
    test('validate returns issues for invalid base64', () {
      final json = {
        'fileData': 'not-base64!',
        'optionalData': 123,
      };

      final issues = documentModelValidate(json);
      expect(issues.any((i) => i.path == 'fileData' && i.code == 'invalid_base64'), isTrue);
      expect(issues.any((i) => i.path == 'optionalData' && i.code == 'type_mismatch'), isTrue);
    });
  });
}
