import 'package:flutter_test/flutter_test.dart';
import 'package:nusa_kampus/app.dart';

void main() {
  testWidgets('NusaKampus menampilkan empat tab navigasi', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const NusaKampusApp());

    await tester.pumpAndSettle(
      const Duration(seconds: 3),
    );

    expect(find.text('NusaKampus'), findsOneWidget);
    expect(find.text('Beranda'), findsOneWidget);
    expect(find.text('Jadwal'), findsOneWidget);
    expect(find.text('Tugas'), findsOneWidget);
    expect(find.text('Pengumuman'), findsOneWidget);
  });
}
