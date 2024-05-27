// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello/main.dart';

import '../test/fake_http_client.dart';

Widget single(Widget w) {
  return MaterialApp(home: w);
}

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    try {
      HttpOverrides.runZoned(() async {
        // Build our app and trigger a frame.
        var myApp = MyApp();
        await tester.pumpWidget(myApp);
        var ensureSemantics = tester.ensureSemantics();

        // Verify that our counter starts at 0.

        await tester.pumpAndSettle();
        try {
          // debugDumpApp();
          debugDumpSemanticsTree();

          // expect(find.bySemanticsLabel((r"booking")), findsOne);

          expect(find.text('0'), findsOne);
          expect(find.text('1'), findsNothing);

          // Tap the '+' icon and trigger a frame.
          tester.semantics.tap(find.semantics.byLabel(RegExp("Increment Counter")));
          await tester.pump();

          // Verify that our counter has incremented.
          expect(find.text('0'), findsNothing);
          expect(find.text('1'), findsOneWidget);
        } finally {
          ensureSemantics.dispose();
        }
      },
          createHttpClient: (securityContext) => FakeHttpClient(
                (HttpClientRequest p0, HttpClient p1) => FakeHttpResponse(
                    body: File(
                            "/home/richja/Pictures/GettyImages-80471741-15d0f8c6753843b2aeb4a34b1e176929-3349558499.jpg")
                        .readAsBytesSync()),
              ));
    } finally {}
  });
}

extension SemanticsIdentifiers on CommonSemanticsFinders {
  SemanticsFinder byIdentifier(String identifier) {
    return byPredicate(
      (node) {
        return node.identifier == identifier;
      },
      describeMatch: (p) => p.triviallyPlural("SemanticsIdentifier", "of $identifier"),
    );
  }
}

extension PluralityExplanation on Plurality {
  String triviallyPlural(String word, String rest) {
    return '${switch (this) {
      Plurality.one => word,
      Plurality.zero || Plurality.many => '${word}s',
    }} ${rest}';
  }
}
