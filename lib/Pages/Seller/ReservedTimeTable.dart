import 'package:dec_app/Hive/HiveBase.dart';
import 'package:dec_app/Pages/Seller/reservation_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'notifications.dart';

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

  Future<void> _refreshTable() async {
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      HiveArchive();
    });
  }

  @override
  Widget build(BuildContext context) {
    int halfItemCount = (itemCount / 2).ceil();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Reserved Time Table',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          backgroundColor: Color(0xFF208A43),
        ),
        body: RefreshIndicator(
          onRefresh: _refreshTable,
          child: tableView(context, halfItemCount),
        ),
      ),
    );
  }

  Column tableView(BuildContext context, int halfItemCount) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: HiveArchive().clearHiveBox,
                child: Text('Clear Table'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationsFromFireStore(),
                    ),
                  );
                },
                child: Text('Notifications'),
              ),
            ],
          ),
        ),

        SizedBox(height: 20),
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: halfItemCount,
                  controller: _scrollController,
                  itemBuilder: (BuildContext context, index) {
                    final reservation = HiveArchive().getReservationDetails(
                      index,
                    );

                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(_formatTime(index)),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: GestureDetector(
                              child: ListTile(
                                tileColor: HiveArchive().addColorToCells(index),
                                title: Text(reservation?['farmerName'] ?? ''),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReservationInfo(index: index,),
                                  ),
                                );
                              },
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

                    final reservation = HiveArchive().getReservationDetails(
                      actualIndex,
                    );

                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(_formatTime(actualIndex)),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: GestureDetector(
                              child: ListTile(
                                tileColor: HiveArchive().addColorToCells(
                                  actualIndex,
                                ),
                                title: Text(reservation?['farmerName'] ?? ''),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReservationInfo(index: actualIndex,),
                                  ),
                                );
                              },
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
      ],
    );
  }
}
