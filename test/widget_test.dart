import 'package:flutter_test/flutter_test.dart';
import 'package:baliculture_app/main.dart';

void main() {
  testWidgets('App renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const BaliCultureApp());
    expect(find.text('BaliCulture'), findsOneWidget);
  });
}