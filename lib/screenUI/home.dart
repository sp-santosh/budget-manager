import 'package:budget_manager/screenUI/calendar.dart';
import 'package:budget_manager/screenUI/dashboard.dart';
import 'package:budget_manager/screenUI/manage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pandabar/pandabar.dart';

void main(List<String> args) {
  runApp(home());
}

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  String page = 'Dashboard';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final CollectionReference _products =
      FirebaseFirestore.instance.collection('products');

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Create'),
                  onPressed: () async {
                    final String name = _nameController.text;
                    final double? price =
                        double.tryParse(_priceController.text);
                    if (price != null) {
                      await _products.add({"name": name, "price": price});

                      _nameController.text = '';
                      _priceController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Budget Manager'),
      ),
      extendBody: true,
      bottomNavigationBar: PandaBar(
        buttonData: [
          PandaBarButtonData(
            id: 'Dashboard',
            icon: Icons.dashboard,
            title: 'Dashboard',
          ),
          PandaBarButtonData(
              id: 'Calendar', icon: Icons.calendar_month, title: 'Calendar'),
          PandaBarButtonData(
              id: 'Red', icon: Icons.account_balance_wallet, title: 'Red'),
          PandaBarButtonData(
              id: 'Manage', icon: Icons.settings, title: 'Manage'),
        ],
        onChange: (id) {
          setState(() {
            page = id;
          });
        },
        onFabButtonPressed: () {
          _create();
        },
      ),
      body: Builder(
        builder: (context) {
          switch (page) {
            case 'Calendar':
              return Caldr();
            case 'Dashboard':
              return Dashboard();
            case 'Red':
              return Container(color: Colors.red.shade900);
            case 'Manage':
              return Manage();
            //return Container(color: Colors.yellow.shade700);
            default:
              return Container();
          }
        },
      ),
    );
  }
}
