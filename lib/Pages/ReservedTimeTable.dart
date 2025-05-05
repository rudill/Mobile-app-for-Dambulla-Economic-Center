import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dec_app/Hive/HiveBase.dart';
import '../Hive/add_to_hive.dart';
import 'package:provider/provider.dart';
import 'language_provider.dart';
import 'trans.dart';

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
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      HiveArchive(); // Refresh logic can be extended here
    });
  }

  @override
  Widget build(BuildContext context) {
    int halfItemCount = (itemCount / 2).ceil();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: FutureBuilder<String>(
            future: translate(context, 'Reserved Time Table'),
            builder: (context, snapshot) {
              return Text(
                snapshot.data ?? 'Reserved Time Table',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              );
            },
          ),
          backgroundColor: const Color(0xFF208A43),
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
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HiveForm()),
              );
            },
            child: FutureBuilder<String>(
              future: translate(context, 'නව ඇතුළත් කිරීමක් එක් කරන්න'),
              builder: (context, snapshot) {
                return Text(snapshot.data ?? 'Add New Entry');
              },
            ),
          ),
        ),
        ElevatedButton(
          onPressed: HiveArchive().clearHiveBox,
          child: FutureBuilder<String>(
            future: translate(context, 'වගුව හිස් කරන්න'),
            builder: (context, snapshot) {
              return Text(snapshot.data ?? 'Clear Table');
            },
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: halfItemCount,
                  controller: _scrollController,
                  itemBuilder: (BuildContext context, index) {
                    return rowTile(index);
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: itemCount - halfItemCount,
                  controller: _scrollController,
                  itemBuilder: (BuildContext context, index) {
                    int actualIndex = index + halfItemCount;
                    return rowTile(actualIndex);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget rowTile(int index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(_formatTime(index)),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              tileColor: HiveArchive().addColorToCells(index),
              title: Text(HiveArchive().returnName(index)),
            ),
          ),
        ),
      ],
    );
  }
}