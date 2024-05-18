import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello/card.dart';

void main() {
  Widget single(Widget w) {
    return MaterialApp(home: w);
  }

  testWidgets('dunno', (WidgetTester tester) async {
    var booking = Booking(
        title: BookingTitle("some title"),
        subtitle: BookingSubtitle("subtitle"));

    await tester.pumpWidget(single(CardExample(booking: booking)));

    expect(find.text('some title'), findsOneWidget);
  });
}
