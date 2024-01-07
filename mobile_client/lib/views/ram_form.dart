import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile_client/locator.dart';
import 'package:mobile_client/models/ram.dart';
import 'package:mobile_client/services/ram_service.dart';
import 'package:mobile_client/shared/app_scaffold.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RamForm extends StatefulWidget {
  const RamForm({super.key, this.ram});

  final Ram? ram;

  @override
  State<RamForm> createState() => _RamFormState();
}

class _RamFormState extends State<RamForm> {
  final _ramService = locator<RamService>();

  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ramCapacityController = TextEditingController();
  final _memoryRateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final ram = widget.ram;
    if (ram != null) {
      _nameController.text = ram.name;
      _ramCapacityController.text = ram.ramCapacity.toString();
      _memoryRateController.text = ram.memoryRate.toString();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ramCapacityController.dispose();
    _memoryRateController.dispose();
    super.dispose();
  }

  Future<void> _goToRams() async {
    Navigator.pushReplacementNamed(context, '/rams');
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    if (widget.ram == null) {
      await _createRam();
    } else {
      await _updateRam();
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _createRam() async {
    final ram = Ram(
        name: _nameController.text,
        ramCapacity: int.parse(_ramCapacityController.text),
        memoryRate: int.parse(_memoryRateController.text),
    );
    await _ramService.createRam(ram);
    Navigator.pop(context);
  }

  Future<void> _updateRam() async {
    final ram = Ram(
        name: _nameController.text,
        ramCapacity: int.parse(_ramCapacityController.text),
        memoryRate: int.parse(_memoryRateController.text),
    );
    await _ramService.updateRam(widget.ram!.name!, ram);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;

    return AppScaffold(
      title: 'Ram Form',
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
                      controller: _ramCapacityController,
                      decoration: InputDecoration(
                        labelText: 'Ram Capacity [GB]',
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
                    const SizedBox(height: 18),
                    TextFormField(
                      controller: _memoryRateController,
                      decoration: InputDecoration(
                        labelText: 'Memory Rate [MHz]',
                        border: OutlineInputBorder(), // Obramowanie pola
                          focusedBorder: OutlineInputBorder(  // Obramowanie w stanie aktywnym
                          borderSide: BorderSide(color: Colors.blue),  // Kolor obramowania
                          ),
                          filled: true,  // Wypełnienie tła
                          fillColor: Colors.white,  // Kolor tła
                          hintText: 'Enter your mem rate',  // Podpowiedź
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
