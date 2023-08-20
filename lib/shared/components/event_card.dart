// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:buybuddy/shared/styles/colors.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final bool isPast;
  final child;
  const EventCard({super.key, required this.isPast, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(25),
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
            color: isPast ? indigoDye : indigoDye.shade100,
            borderRadius: BorderRadius.circular(15)),
        child: child);
  }
}
