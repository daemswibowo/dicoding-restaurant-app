import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/widgets/atoms/menu_title.dart';

Widget createContainer(title) =>
    MaterialApp(home: Scaffold(
      body: MenuTitle(title: title),
    ));

void main() {
  group('MenuTitle widget test', () {
    testWidgets('should displaying the given title correctly',
            (WidgetTester tester) async {
          var title = 'lorem ipsum';
          await tester.pumpWidget(createContainer(title));
          expect(find.textContaining(title), findsOneWidget);
        });
  });
}
