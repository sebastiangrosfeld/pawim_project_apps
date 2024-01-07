import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_client/models/computer.dart';
import 'package:mobile_client/shared/app_scaffold.dart';
import 'package:mobile_client/shared/resource_card.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class Scanner extends StatefulWidget {
  const Scanner({super.key});

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  Computer? _computer;

  @override
  Widget build(BuildContext context) {

    return AppScaffold(
      title: 'Scanner',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 32),
              height: 400,
              width: double.infinity,
              child: MobileScanner(
                onDetect: (capture) {
                  final barcode = capture.barcodes.first;
                  final value = barcode.rawValue;

                  if (value == null) {
                    return;
                  }

                  setState(() {
                    _computer = Computer.fromJson(json.decode(value));
                  });
                },
              ),
            ),
            _computer != null
                ? ResourceCard(
                    readonly: true,
                    title: 'Name: ${_computer!.name}',
                    children: <Widget>[
                      Text('Type: ${_computer?.type}'),
                      Text('Enclosure Name: ${_computer?.enclosureName}'),
                      Text('CPU Name: ${_computer?.cpuName}'),
                      Text('RAM Name: ${_computer?.ram.name}'),
                      Text('Hard Disk Capacity [GB]: ${_computer?.hardDiskCapacity}'),
                      Text('GPU Name: ${_computer?.gpu.name}'),
                      Text('Power Supply [W]: ${_computer?.powerSupply}'),
                      Text('Price: ${_computer?.price}'),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
