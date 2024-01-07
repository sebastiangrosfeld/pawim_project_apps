import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile_client/locator.dart';
import 'package:mobile_client/models/ram.dart';
import 'package:mobile_client/services/ram_service.dart';
import 'package:mobile_client/shared/app_scaffold.dart';
import 'package:mobile_client/shared/resource_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RamList extends StatefulWidget {
  const RamList({super.key});

  @override
  State<RamList> createState() => _RamListState();
}

class _RamListState extends State<RamList> {
  final _ramService = locator<RamService>();

  List<Ram> _rams = [];
  bool _isLoading = false;

  Future<void> _fetchRams() async {
    setState(() {
      _isLoading = true;
    });
    final fetchedRams = await _ramService.fetchRams();
    setState(() {
      _rams = fetchedRams;
      _isLoading = false;
    });
  }

  Future<void> _deleteRam(Ram ram) async {
    setState(() {
      _isLoading = true;
    });
    await _ramService.deleteRam(ram);
    await _fetchRams();
  }

  Future<void> _navigateToRamForm(Ram? ram) async {
    await Navigator.pushNamed(context, '/ram-form', arguments: ram);
    await _fetchRams();
  }

  @override
  void initState() {
    super.initState();
    _fetchRams();
  }

  @override
  Widget build(BuildContext context) {

    return AppScaffold(
      title: 'Rams List',
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _navigateToRamForm(null);
        },
      ),
      body: _isLoading
          ? SpinKitDualRing(color: Color.fromARGB(255, 0, 0, 0))
          : ListView.builder(
              itemCount: _rams.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  child: ResourceCard(
                    title: 'Name: ${_rams[index].name}',
                    onEdit: () => _navigateToRamForm(_rams[index]),
                    onDelete: () => _deleteRam(_rams[index]),
                    deleteDialogTitle: 'Delete RAM',
                    children: <Widget>[
                      Text('Ram Capacity [GB]: ${_rams[index].ramCapacity}'),
                      Text('Memory Rate [MHz]: ${_rams[index].memoryRate}'),
                    ],
                  ),
                );
              },
            ),
    );
  }
}