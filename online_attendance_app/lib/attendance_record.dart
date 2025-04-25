import 'package:flutter/material.dart';

class AttendanceRecordPage extends StatelessWidget {
  const AttendanceRecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy attendance data
    final List<Map<String, String>> attendanceData = [
      {"date": "01 Oct 2023", "inTime": "09:00 AM", "outTime": "05:00 PM"},
      {"date": "02 Oct 2023", "inTime": "09:15 AM", "outTime": "05:10 PM"},
      {"date": "03 Oct 2023", "inTime": "Absent", "outTime": "Absent"},
      {"date": "04 Oct 2023", "inTime": "09:05 AM", "outTime": "05:00 PM"},
      {"date": "05 Oct 2023", "inTime": "Absent", "outTime": "Absent"},
    ];

    // Calculate total absents and working days
    final int totalWorkingDays = attendanceData.length;
    final int totalAbsents = attendanceData
        .where((record) => record["inTime"] == "Absent")
        .length;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendance Record"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Attendance for October 2023",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: attendanceData.length,
                itemBuilder: (context, index) {
                  final record = attendanceData[index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: record["inTime"] == "Absent"
                            ? Colors.red
                            : Colors.green,
                        child: Text(
                          record["date"]!.split(" ")[0],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text("Date: ${record["date"]}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("In-Time: ${record["inTime"]}"),
                          Text("Out-Time: ${record["outTime"]}"),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Working Days: $totalWorkingDays",
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      "Total Absents: $totalAbsents",
                      style: const TextStyle(fontSize: 16, color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}