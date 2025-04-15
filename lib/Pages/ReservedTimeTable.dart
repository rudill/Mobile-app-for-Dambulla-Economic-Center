import 'package:flutter/material.dart';

class ReservedTimeSlots extends StatefulWidget {
  const ReservedTimeSlots({super.key});

  @override
  State<ReservedTimeSlots> createState() => _ReservedTimeSlotsState();
}

class _ReservedTimeSlotsState extends State<ReservedTimeSlots> {
  calculateTime() {
    double reservedTime = 4.0;
    while (reservedTime == 13.0) {
      reservedTime += 0.30;
      return Text(reservedTime.toString());
    }

    return const Text('N/A');
  }

  int resTime = 40;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (BuildContext context, index) {
                  return const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Text('${resTime-=2}'.toString()),
                      Text('4:00'),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ListTile(
                            tileColor: Colors.grey,
                          ),
                        ),
                      ),
                      Text('13:30'),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ListTile(
                            tileColor: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
