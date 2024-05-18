// import 'dart:io';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:hello/main.dart';
// import 'package:integration_test/integration_test.dart';
// import 'package:integration_test/integration_test_driver_extended.dart';
//
// extension HandyShit on WidgetTester {
//   Future<void> takeScreenshot() async {
//     var b = (binding as IntegrationTestWidgetsFlutterBinding);
//     if (!kIsWeb) {
//       await b.convertFlutterSurfaceToImage();
//       await pumpAndSettle();
//     }
//
//     await b.takeScreenshot("example");
//     print("I took a screenshot");
//   }
// }
//
// Future<void> main() async {
//
//   testWidgets('tap on the floating action button, verify counter',
//       (WidgetTester tester) async {
//
//     print("I am test ${tester.testDescription}");
//
//     // Load app widget.
//     await tester.pumpWidget(const MyApp());
//
//     await tester.takeScreenshot();
//
//     // Verify the counter starts at 0.
//     expect(find.text('0'), findsOneWidget);
//
//     // Finds the floating action button to tap on.
//     final fab = find.byKey(const Key('increment'));
//
//     // Emulate a tap on the floating action button.
//     await tester.tap(fab);
//
//     // Trigger a frame.
//     await tester.pumpAndSettle();
//
//     // Verify the counter increments by 1.
//     expect(find.text('0'), findsNothing);
//     expect(find.text('1'), findsOneWidget);
//   });
// }
