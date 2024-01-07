
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile_client/locator.dart';
import 'package:mobile_client/models/gpu.dart';
import 'package:mobile_client/services/gpu_service.dart';
import 'package:mobile_client/shared/app_scaffold.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GpuForm extends StatefulWidget {
  const GpuForm({super.key, this.gpu});

  final Gpu? gpu;

  @override
  State<GpuForm> createState() => _GpuFormState();
}

class _GpuFormState extends State<GpuForm> {
  final _gpuService = locator<GpuService>();

  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _vRamCapacityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final gpu = widget.gpu;
    if (gpu != null) {
      _nameController.text = gpu.name;
      _vRamCapacityController.text = gpu.videoRamCapacity.toString();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _vRamCapacityController.dispose();
    super.dispose();
  }

  Future<void> _goToRams() async {
    Navigator.pushReplacementNamed(context, '/gpus');
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    if (widget.gpu == null) {
      await _createGpu();
    } else {
      await _updateGpu();
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _createGpu() async {
    final gpu = Gpu(
        name: _nameController.text,
        videoRamCapacity: int.parse(_vRamCapacityController.text),
    );
    await _gpuService.createGpu(gpu);
    Navigator.pop(context);
  }

  Future<void> _updateGpu() async {
    final gpu = Gpu(
        name: _nameController.text,
        videoRamCapacity: int.parse(_vRamCapacityController.text),
    );
    await _gpuService.updateGpu(widget.gpu!.name!, gpu);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;

    return AppScaffold(
      title: 'Gpu Form',
      body: _isLoading
          ? SpinKitDualRing(color: Color.fromARGB(255, 0, 0, 0))
          : Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(), // Obramowanie pola
                          focusedBorder: OutlineInputBorder(  // Obramowanie w stanie aktywnym
                          borderSide: BorderSide(color: Colors.blue),  // Kolor obramowania
                          ),
                          filled: true,  // Wypełnienie tła
                          fillColor: Colors.white,  // Kolor tła
                          hintStyle: TextStyle(color: Colors.grey),  // Styl podpowiedzi
                          contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),  // Wewnętrzny padding
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return localizations.required;
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      controller: _vRamCapacityController,
                      decoration: InputDecoration(
                        labelText: 'VRam Capacity [GB]',
                        border: OutlineInputBorder(), // Obramowanie pola
                          focusedBorder: OutlineInputBorder(  // Obramowanie w stanie aktywnym
                          borderSide: BorderSide(color: Colors.blue),  // Kolor obramowania
                          ),
                          filled: true,  // Wypełnienie tła
                          fillColor: Colors.white,  // Kolor tła
                          hintText: 'Enter your capacity',  // Podpowiedź
                          hintStyle: TextStyle(color: Colors.grey),  // Styl podpowiedzi
                          contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),  // Wewnętrzny padding
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return localizations.required;
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: _submitForm,
                          style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue), // Kolor tła przycisku
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Kolor tekstu
                        textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(fontSize: 16)), // Styl tekstu
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(14)), // Padding przycisku
                        // Możesz dostosować inne właściwości ButtonStyle według potrzeb
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5), // Dostosuj zaokrąglenie krawędzi
                            ),
                          ),
                        ),
                          child: Text('Submit'),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: _goToRams,
                          style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.grey), // Kolor tła przycisku
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Kolor tekstu
                        textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(fontSize: 16)), // Styl tekstu
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(12)), // Padding przycisku
                        // Możesz dostosować inne właściwości ButtonStyle według potrzeb
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5), // Dostosuj zaokrąglenie krawędzi
                            ),
                          ),
                        ),
                          child: Text('Cancel'),
                        ),
                      ],
                    ),
                    // ElevatedButton(
                    //   onPressed: _submitForm,
                    //   child: Text(localizations.save.toUpperCase()),
                    // ),
                  ],
                ),
              ),
            ),
    );
  }
}
