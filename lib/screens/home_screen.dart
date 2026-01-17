import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../widgets/hyperlink_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedUni = "University A";
  final List<String> universities = ["University A", "University B", "University C"];

  @override
  Widget build(BuildContext context) {
    var box = Hive.box('study_box');
    
    // Filter items based on selected University
    var filteredItems = box.values
        .where((item) => item['uni'] == selectedUni)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Study Dashboard"),
        actions: [
          DropdownButton<String>(
            value: selectedUni,
            icon: Icon(Icons.school, color: Colors.white),
            dropdownColor: Colors.indigo,
            onChanged: (String? newValue) {
              setState(() { selectedUni = newValue!; });
            },
            items: universities.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(color: Colors.white)),
              );
            }).toList(),
          ),
        ],
      ),
      body: filteredItems.isEmpty 
        ? Center(child: Text("No resources yet for $selectedUni"))
        : ListView.builder(
            itemCount: filteredItems.length,
            itemBuilder: (context, index) {
              final item = filteredItems[index];
              return HyperlinkCard(
                title: item['upwrite'],
                url: item['url'],
                subject: item['subject'],
              );
            },
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final upwriteController = TextEditingController();
    final urlController = TextEditingController();
    final subjectController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Resource to $selectedUni"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: subjectController, decoration: InputDecoration(labelText: "Subject Name")),
            TextField(controller: upwriteController, decoration: InputDecoration(labelText: "Upwrite (The Clickable Text)")),
            TextField(controller: urlController, decoration: InputDecoration(labelText: "Actual URL")),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Hive.box('study_box').add({
                'uni': selectedUni,
                'subject': subjectController.text,
                'upwrite': upwriteController.text,
                'url': urlController.text,
              });
              Navigator.pop(context);
              setState(() {});
            },
            child: Text("Save Offline"),
          )
        ],
      ),
    );
  }
}
