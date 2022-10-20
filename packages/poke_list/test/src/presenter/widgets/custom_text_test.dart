import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poke_list/src/presenter/widgets/custom_text.dart';

void main() {
  testWidgets('Custom Text working correctly', (tester) async {
    const text = 'ditto';

    await tester.pumpWidget(const MaterialApp(home: CustomText(text: text)));

    expect(find.widgetWithText(CustomText, text), findsOneWidget);
  });
}
