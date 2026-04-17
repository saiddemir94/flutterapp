import 'package:flutter_test/flutter_test.dart';
import 'package:mini_katalog/main.dart';

void main() {
  testWidgets('Mini katalog basligi gorunur', (tester) async {
    await tester.pumpWidget(const MiniKatalogApp());
    await tester.pumpAndSettle();

    expect(find.text('Mini Katalog'), findsOneWidget);
    expect(find.text('Haftanin secili urunleri'), findsOneWidget);
  });
}
