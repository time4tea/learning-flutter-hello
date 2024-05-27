import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

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

    var content = File("/home/richja/Pictures/GettyImages-80471741-15d0f8c6753843b2aeb4a34b1e176929-3349558499.jpg").readAsBytesSync();

    HttpOverrides.runZoned(
      () async {
        await tester.pumpWidget(single(BookingWidget(booking: booking)));

        var image = await captureImage(find.byType(BookingWidget).evaluate().single);

        final ByteData? bytes = await image.toByteData(format: ImageByteFormat.png);

        print("hello");

        var asUint8List = bytes?.buffer.asUint8List();
        print(asUint8List?.length);

        expect(find.text('some title'), findsOneWidget);
      },
      createHttpClient: (securityContext) => FakeHttpClient(
        (HttpClientRequest p0, HttpClient p1) => FakeHttpResponse(body:content),
      ),
    );
  });
}
