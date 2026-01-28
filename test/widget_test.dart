import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:cattle_marketplace/app/app.dart';

void main() {
  testWidgets('app builds', (WidgetTester tester) async {
    await tester.pumpWidget(const CattleMarketplaceApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
