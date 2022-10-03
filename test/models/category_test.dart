import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/models/category.dart';

void main() {
  group('Category model test', () {
    test('should parse categories', () {
      var jsonData = '[{"name": "category 1"},{"name": "category 2"}]';
      var categories = parseCategories(json.decode(jsonData));

      var num = 1;
      for (var c in categories) {
        expect(c.name, 'category $num');
        num++;
      }
    });
  });
}