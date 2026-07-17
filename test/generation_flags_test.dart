import 'models/test_models.dart';
import 'package:test/test.dart';

void main() {
  group('Generation Flags (fromJson, toJson)', () {
    test('ReadOnlyModel should have fromJson and fromJsonSafe', () {
      final json = {'id': 1, 'name': 'Read'};
      final model1 = ReadOnlyModel.fromJson(json);
      final model2 = ReadOnlyModel.fromJsonSafe(json);

      expect(model1.id, 1);
      expect(model1.name, 'Read');
      
      expect(model2.id, 1);
      expect(model2.name, 'Read');

      // Note: We cannot test that toJson doesn't exist dynamically without reflection, 
      // but the fact that this compiles and runs means build_runner succeeded.
      // If toJson was generated but without the Mixin, it wouldn't hurt.
      // But we verified the generator doesn't emit it.
    });

    test('WriteOnlyModel should have toJson', () {
      final model = WriteOnlyModel(id: 2, name: 'Write');
      final json = model.toJson();

      expect(json, containsPair('id', 2));
      expect(json, containsPair('name', 'Write'));
    });
  });
}
