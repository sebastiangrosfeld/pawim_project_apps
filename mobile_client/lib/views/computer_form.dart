import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile_client/locator.dart';
import 'package:mobile_client/models/computer.dart';
import 'package:mobile_client/models/gpu.dart';
import 'package:mobile_client/models/ram.dart';
import 'package:mobile_client/services/computer_service.dart';
import 'package:mobile_client/services/gpu_service.dart';
import 'package:mobile_client/services/ram_service.dart';
import 'package:mobile_client/shared/app_scaffold.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ComputerForm extends StatefulWidget {
  const ComputerForm({super.key, this.computer});

  final Computer? computer;

  @override
  State<ComputerForm> createState() => _ComputerFormState();
}

class _ComputerFormState extends State<ComputerForm> {
  final _computerService = locator<ComputerService>();
  final _ramService = locator<RamService>();
  final _gpuService = locator<GpuService>();

  List<Ram> _rams = [];
  List<Gpu> _gpus = [];
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _colorController = TextEditingController();
  final _typeController = TextEditingController();
  final _enclosureNameController = TextEditingController();
  final _cpuNameController = TextEditingController();
  final _hardDiskCapacityController = TextEditingController();
  final _powerSupplyController = TextEditingController();
  final _priceController = TextEditingController();
  final _ramController = SingleValueDropDownController();
  final _gpuController = SingleValueDropDownController();
  final _equipmentOptionsController = MultiValueDropDownController();

  @override
  void initState() {
    super.initState();
    final computer = widget.computer;
    if (computer != null) {
      _nameController.text = computer.name;
      _typeController.text = computer.type;
      _enclosureNameController.text = computer.enclosureName;
      _cpuNameController.text = computer.cpuName;
      _ramController.dropDownValue = DropDownValueModel(name: computer.ram.name, value: computer.ram);
      _hardDiskCapacityController.text = computer.hardDiskCapacity.toString();
      _gpuController.dropDownValue = DropDownValueModel(name: computer.gpu.name, value: computer.gpu);
      _powerSupplyController.text = computer.powerSupply.toString();
      _priceController.text = computer.price.toString();
    }
    _fetchData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _colorController.dispose();
    _typeController.dispose();
    _enclosureNameController.dispose();
    _ramController.dispose();
    _hardDiskCapacityController.dispose();
    _gpuController.dispose();
    _powerSupplyController.dispose();
    _priceController.dispose();
    _equipmentOptionsController.dispose();
    super.dispose();
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    await _fetchRams();
    await _fetchGpus();

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _fetchRams() async {
    final fetchedRams = await _ramService.fetchRams();
    setState(() {
      _rams = fetchedRams;
    });
  }

  Future<void> _goToComputers() async {
    Navigator.pushReplacementNamed(context, '/computers');
  }

  Future<void> _fetchGpus() async {
    final fetchedGpus = await _gpuService.fetchGpus();
    setState(() {
      _gpus = fetchedGpus;
    });
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    if (widget.computer == null) {
      await _createComputer();
    } else {
      await _updateComputer();
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _createComputer() async {
    final computer = Computer(
        name: _nameController.text,
        type: _typeController.text,
        enclosureName: _enclosureNameController.text,
        cpuName: _cpuNameController.text,
        ram: _ramController.dropDownValue!.value as Ram,
        hardDiskCapacity: int.parse(_hardDiskCapacityController.text),
        gpu: _gpuController.dropDownValue!.value as Gpu,
        powerSupply: int.parse(_powerSupplyController.text),
        price: int.parse(_priceController.text),
    );
    await _computerService.createComputer(computer);
    Navigator.pop(context);
  }

  Future<void> _updateComputer() async {
    final computer = Computer(
        name: _nameController.text,
        type: _typeController.text,
        enclosureName: _enclosureNameController.text,
        cpuName: _cpuNameController.text,
        ram: _ramController.dropDownValue!.value as Ram,
        hardDiskCapacity: int.parse(_hardDiskCapacityController.text),
        gpu: _gpuController.dropDownValue!.value as Gpu,
        powerSupply: int.parse(_powerSupplyController.text),
        price: int.parse(_priceController.text),
    );
    await _computerService.updateComputer(widget.computer!.name!, computer);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;

    return AppScaffold(
      title: 'Computer Form',
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
                          hintText: 'Enter your name',  // Podpowiedź
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
                      controller: _typeController,
                      decoration: InputDecoration(
                        labelText: 'Type',
                        border: OutlineInputBorder(), // Obramowanie pola
                          focusedBorder: OutlineInputBorder(  // Obramowanie w stanie aktywnym
                          borderSide: BorderSide(color: Colors.blue),  // Kolor obramowania
                          ),
                          filled: true,  // Wypełnienie tła
                          fillColor: Colors.white,  // Kolor tła
                          hintText: 'Enter your name',  // Podpowiedź
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
                      controller: _enclosureNameController,
                      decoration: InputDecoration(
                        labelText: 'Enclosure Name',
                        border: OutlineInputBorder(), // Obramowanie pola
                          focusedBorder: OutlineInputBorder(  // Obramowanie w stanie aktywnym
                          borderSide: BorderSide(color: Colors.blue),  // Kolor obramowania
                          ),
                          filled: true,  // Wypełnienie tła
                          fillColor: Colors.white,  // Kolor tła
                          hintText: 'Enter your name',  // Podpowiedź
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
                    DropDownTextField(
                      controller: _ramController,
                      dropDownItemCount: _rams.length,
                      dropDownList: _rams.map((ram) => DropDownValueModel(name: ram.name, value: ram)).toList(),
                      validator: (value) {
                        if (value == null) {
                          return localizations.required;
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      controller: _hardDiskCapacityController,
                      decoration: InputDecoration(
                        labelText: 'Hard Disk Capacity [GB]',
                        border: OutlineInputBorder(), // Obramowanie pola
                          focusedBorder: OutlineInputBorder(  // Obramowanie w stanie aktywnym
                          borderSide: BorderSide(color: Colors.blue),  // Kolor obramowania
                          ),
                          filled: true,  // Wypełnienie tła
                          fillColor: Colors.white,  // Kolor tła
                          hintText: 'Enter your username',  // Podpowiedź
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
                     DropDownTextField(
                      controller: _gpuController,
                      dropDownItemCount: _gpus.length,
                      dropDownList: _gpus.map((gpu) => DropDownValueModel(name: gpu.name, value: gpu)).toList(),
                      validator: (value) {
                        if (value == null) {
                          return localizations.required;
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      controller: _powerSupplyController,
                      decoration: InputDecoration(
                        labelText: 'Power Supply [W]',
                        border: OutlineInputBorder(), // Obramowanie pola
                          focusedBorder: OutlineInputBorder(  // Obramowanie w stanie aktywnym
                          borderSide: BorderSide(color: Colors.blue),  // Kolor obramowania
                          ),
                          filled: true,  // Wypełnienie tła
                          fillColor: Colors.white,  // Kolor tła
                          hintText: 'Enter your username',  // Podpowiedź
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
                      controller: _priceController,
                      decoration: InputDecoration(
                        labelText: 'Price',
                        border: OutlineInputBorder(), // Obramowanie pola
                          focusedBorder: OutlineInputBorder(  // Obramowanie w stanie aktywnym
                          borderSide: BorderSide(color: Colors.blue),  // Kolor obramowania
                          ),
                          filled: true,  // Wypełnienie tła
                          fillColor: Colors.white,  // Kolor tła
                          hintText: 'Enter your username',  // Podpowiedź
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
                          onPressed: _goToComputers,
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
