import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile_client/locator.dart';
import 'package:mobile_client/models/gpu.dart';
import 'package:mobile_client/services/gpu_service.dart';
import 'package:mobile_client/shared/app_scaffold.dart';
import 'package:mobile_client/shared/resource_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GpuList extends StatefulWidget {
  const GpuList({super.key});

  @override
  State<GpuList> createState() => _GpuListState();
}

class _GpuListState extends State<GpuList> {
  final _gpuService = locator<GpuService>();

  List<Gpu> _gpus = [];
  bool _isLoading = false;

  Future<void> _fetchGpus() async {
    setState(() {
      _isLoading = true;
    });
    final fetchedRams = await _gpuService.fetchGpus();
    setState(() {
      _gpus = fetchedRams;
      _isLoading = false;
    });
  }

  Future<void> _deleteGpu(Gpu gpu) async {
    setState(() {
      _isLoading = true;
    });
    await _gpuService.deleteGpu(gpu);
    await _fetchGpus();
  }

  Future<void> _navigateToGpuForm(Gpu? gpu) async {
    await Navigator.pushNamed(context, '/gpu-form', arguments: gpu);
    await _fetchGpus();
  }

  @override
  void initState() {
    super.initState();
    _fetchGpus();
  }

  @override
  Widget build(BuildContext context) {
    final inversePrimaryColor = Theme.of(context).colorScheme.inversePrimary;
    final localizations = AppLocalizations.of(context)!;

    return AppScaffold(
      title: 'Gpus List',
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _navigateToGpuForm(null);
        },
      ),
      body: _isLoading
          ? SpinKitDualRing(color: Color.fromARGB(255, 0, 0, 0))
          : ListView.builder(
              itemCount: _gpus.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  child: ResourceCard(
                    title: 'Name: ${_gpus[index].name}',
                    onEdit: () => _navigateToGpuForm(_gpus[index]),
                    onDelete: () => _deleteGpu(_gpus[index]),
                    deleteDialogTitle: 'Delete GPU',
                    children: <Widget>[
                      Text('VRam Capacity [GB]: ${_gpus[index].videoRamCapacity}'),
                    ],
                  ),
                );
              },
            ),
    );
  }
}