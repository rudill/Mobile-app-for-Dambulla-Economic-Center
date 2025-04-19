import 'package:dec_app/Hive/HiveBase.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReservedTimeSlots extends StatefulWidget {
  const ReservedTimeSlots({super.key});

  @override
  State<ReservedTimeSlots> createState() => _ReservedTimeSlotsState();
}

class _ReservedTimeSlotsState extends State<ReservedTimeSlots> {
  int itemCount = 38;

  final ScrollController _scrollController = ScrollController();

  final DateTime _startTime = DateTime(0, 1, 1, 4, 0);

  String _formatTime(int index) {
    final DateTime time = _startTime.add(Duration(minutes: index * 30));
    return DateFormat('HH:mm').format(time);
  }

  @override
  Widget build(BuildContext context) {
    int halfItemCount = (itemCount / 2).ceil();
    return SafeArea(
      child: Scaffold(
        body: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
         //   ElevatedButton(onPressed: () {}, child: Text('Add')),
            Expanded(
              child: ListView.builder(
                itemCount: halfItemCount,
                controller: _scrollController,
                itemBuilder: (BuildContext context, index) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_formatTime(index)),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ListTile(
                            tileColor:
                                HiveArchive(timeSlot: index).addColorToCells(),
                            title: Text(
                              HiveArchive(timeSlot: index).reservedName(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: itemCount - halfItemCount,
                controller: _scrollController,
                itemBuilder: (BuildContext context, index) {
                  int actualIndex = index + halfItemCount;
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_formatTime(actualIndex)),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ListTile(
                            tileColor:
                                HiveArchive(
                                  timeSlot: actualIndex,
                                ).addColorToCells(),
                            title: Text(
                              HiveArchive(timeSlot: actualIndex).reservedName(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
