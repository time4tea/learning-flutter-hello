import 'package:flutter/material.dart';

extension type BookingTitle(String value) {}
extension type BookingSubtitle(String value) {}

class Booking {
  final BookingTitle title;
  final BookingSubtitle subtitle;
  final String imageUri;

  const Booking(
      {required this.title, required this.subtitle, required this.imageUri});
}

class BookingWidget extends StatelessWidget {
  final Booking booking;

  BookingWidget({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Semantics(
          identifier: "booking",
          label: booking.title.value,
          container: true,
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.album),
                    title: Text(booking.title.value),
                    subtitle: Text(booking.subtitle.value),
                    trailing: Image.network(booking.imageUri, excludeFromSemantics: true,)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      child: const Text('BUY TICKETS'),
                      onPressed: () {
                        /* ... */
                      },
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      child: const Text('LISTEN'),
                      onPressed: () {
                        /* ... */
                      },
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
