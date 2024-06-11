import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practice/utils/popups/loaders.dart';

class YearDropdownButton extends StatefulWidget {
  const YearDropdownButton({super.key, required this.onYearChange});

  final Function(String) onYearChange;

  @override
  State<YearDropdownButton> createState() => _YearDropdownButtonState();
}

class _YearDropdownButtonState extends State<YearDropdownButton> {
  List<String> _years = ['Select Year'];
  String _selectedYear = 'Select Year';

  @override
  void initState() {
    super.initState();
    fetchYears();
  }

  // Fetch years from all documents in Firebase collection
  Future<void> fetchYears() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('client_details').get();
      Set<int> yearSet = {};

      for (var doc in snapshot.docs) {
        if (doc.exists) {
          final data = doc.data();
          if (data.containsKey('Date')) {
            String date = data['Date'];
            int year = DateTime.parse(date).year;
            yearSet.add(year);
          }
        } else {
          SLoaders.errorSnackBar(title: 'Document does not exist.');
        }
      }

      List<String> years = yearSet.map((e) => e.toString()).toList();
      years.sort();

      setState(() {
        _years = ['Select Year'] + years;
      });
    } catch (e) {
      SLoaders.errorSnackBar(title: 'Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedYear,
      items: _years.map(
              (e) => DropdownMenuItem(value: e, child: Text(e))
      ).toList(),
      onChanged: (val) {
        setState(() {
          _selectedYear = val!;
        });
        widget.onYearChange(val!);
      },
    );
  }
}
