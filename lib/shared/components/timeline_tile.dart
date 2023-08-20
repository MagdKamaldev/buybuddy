// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:buybuddy/shared/components/event_card.dart';
import 'package:buybuddy/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MyTimeLineTile extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final eventCard;

  const MyTimeLineTile({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.isPast,
    required this.eventCard,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.23,
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,
        beforeLineStyle:
            LineStyle(color: isPast ? indigoDye : indigoDye.shade100),
        indicatorStyle: IndicatorStyle(
            width: 35,
            color: isPast ? indigoDye : indigoDye.shade100,
            iconStyle: IconStyle(
                iconData: Icons.done,
                color: isPast ? ivory : indigoDye.shade100)),
        endChild: EventCard(
          isPast: isPast,
          child: eventCard,
        ),
      ),
    );
  }
}
