import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello/card.dart';

import 'fake_http_client.dart';

void main() {
  Widget single(Widget w) {
    return MaterialApp(home: w);
  }

  testWidgets('dunno', (WidgetTester tester) async {
    var booking = Booking(
        title: BookingTitle("some title"),
        subtitle: BookingSubtitle("subtitle"),
        imageUri:
            "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg");

    HttpOverrides.runZoned(
      () async {
        await tester.pumpWidget(single(CardExample(booking: booking)));
        expect(find.text('some title'), findsOneWidget);
      },
      createHttpClient: (securityContext) => FakeHttpClient(
        (HttpClientRequest p0, HttpClient p1) => FakeHttpResponse(),
      ),
    );
  });
}
