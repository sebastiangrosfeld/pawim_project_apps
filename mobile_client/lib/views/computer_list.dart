import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile_client/locator.dart';
import 'package:mobile_client/models/computer.dart';
import 'package:mobile_client/services/computer_service.dart';
import 'package:mobile_client/shared/app_scaffold.dart';
import 'package:mobile_client/shared/resource_card.dart';

class ComputerList extends StatefulWidget {
  const ComputerList({super.key});

  @override
  State<ComputerList> createState() => _ComputerListState();
}

class _ComputerListState extends State<ComputerList> {
  final _computerService = locator<ComputerService>();

  List<Computer> _computers = [];
  bool _isLoading = false;

  Future<void> _fetchComputers() async {
    setState(() {
      _isLoading = true;
    });
    final fetchedComputers = await _computerService.fetchComputers();
    setState(() {
      _computers = fetchedComputers;
      _isLoading = false;
    });
  }

  Future<void> _deleteComputer(Computer computer) async {
    setState(() {
      _isLoading = true;
    });
    await _computerService.deleteComputer(computer);
    await _fetchComputers();
  }

  Future<void> _navigateToComputerForm(Computer? computer) async {
    await Navigator.pushNamed(context, '/computer-form', arguments: computer);
    await _fetchComputers();
  }

  @override
  void initState() {
    super.initState();
    _fetchComputers();
  }

  @override
  Widget build(BuildContext context) {

    return AppScaffold(
      title: 'Computers List',
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _navigateToComputerForm(null);
        },
      ),
      body: _isLoading
          ? SpinKitDualRing(color: Color.fromARGB(255, 0, 0, 0))
          : ListView.builder(
              itemCount: _computers.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  child: ResourceCard(
                    title: 'Name: ${_computers[index].name}',
                    onEdit: () => _navigateToComputerForm(_computers[index]),
                    onDelete: () => _deleteComputer(_computers[index]),
                    deleteDialogTitle: 'Delete Computer',
                    children: <Widget>[
                      Text('Type: ${_computers[index].type}'),
                      Text('Enclosure Name: ${_computers[index].enclosureName}'),
                      Text('CPU Name: ${_computers[index].cpuName}'),
                      Text('RAM Name: ${_computers[index].ram.name}'),
                      Text('Hard Disk Capacity [GB]: ${_computers[index].hardDiskCapacity}'),
                      Text('GPU Name: ${_computers[index].gpu.name}'),
                      Text('Power Supply [W]: ${_computers[index].powerSupply}'),
                      Text('Price: ${_computers[index].price}'),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
