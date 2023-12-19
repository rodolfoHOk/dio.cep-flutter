import 'package:cep_flutter/models/via_cep_model.dart';
import 'package:flutter/material.dart';

class EditCEPPage extends StatefulWidget {
  final ViaCEPModel viaCEPModel;

  const EditCEPPage({super.key, required this.viaCEPModel});

  @override
  State<EditCEPPage> createState() => _EditCEPPageState();
}

class _EditCEPPageState extends State<EditCEPPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Editar CEP"),
        ),
        body: Text(widget.viaCEPModel.cep),
      ),
    );
  }
}
