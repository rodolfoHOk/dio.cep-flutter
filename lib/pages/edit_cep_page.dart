import 'package:cep_flutter/models/via_cep_model.dart';
import 'package:cep_flutter/services/back4app/back4app_cep_service.dart';
import 'package:cep_flutter/shared/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class EditCEPPage extends StatefulWidget {
  final ViaCEPModel viaCEPModel;

  const EditCEPPage({super.key, required this.viaCEPModel});

  @override
  State<EditCEPPage> createState() => _EditCEPPageState();
}

class _EditCEPPageState extends State<EditCEPPage> {
  late Back4AppCEPService _back4appCEPService;

  @override
  void initState() {
    super.initState();
    _back4appCEPService = Back4AppCEPService();
  }

  @override
  Widget build(BuildContext context) {
    var viaCEP = widget.viaCEPModel;
    var cepController = TextEditingController(text: viaCEP.cep);
    var logradouroController = TextEditingController(text: viaCEP.localidade);
    var complementoController = TextEditingController(text: viaCEP.complemento);
    var bairroController = TextEditingController(text: viaCEP.bairro);
    var localidadeController = TextEditingController(text: viaCEP.localidade);
    var ufController = TextEditingController(text: viaCEP.uf);
    var ibgeController = TextEditingController(text: viaCEP.ibge);
    var giaController = TextEditingController(text: viaCEP.gia);
    var dddController = TextEditingController(text: viaCEP.ddd);
    var siafiController = TextEditingController(text: viaCEP.siafi);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Editar/Salvar CEP"),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Form(
            child: ListView(
              children: [
                const SizedBox(height: 12),
                CustomTextFormField(
                  title: 'CEP',
                  controller: cepController,
                ),
                const SizedBox(height: 12),
                CustomTextFormField(
                  title: 'Logradouro',
                  controller: logradouroController,
                ),
                const SizedBox(height: 12),
                CustomTextFormField(
                  title: 'Complemento',
                  controller: complementoController,
                ),
                const SizedBox(height: 12),
                CustomTextFormField(
                  title: 'Bairro',
                  controller: bairroController,
                ),
                const SizedBox(height: 12),
                CustomTextFormField(
                  title: 'Localidade',
                  controller: localidadeController,
                ),
                const SizedBox(height: 12),
                CustomTextFormField(
                  title: 'UF',
                  controller: ufController,
                ),
                const SizedBox(height: 12),
                CustomTextFormField(
                  title: 'IBGE',
                  controller: ibgeController,
                ),
                const SizedBox(height: 12),
                CustomTextFormField(
                  title: 'GIA',
                  controller: giaController,
                ),
                const SizedBox(height: 12),
                CustomTextFormField(
                  title: 'DDD',
                  controller: dddController,
                ),
                const SizedBox(height: 12),
                CustomTextFormField(
                  title: 'SIAFI',
                  controller: siafiController,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () async {
                    ViaCEPModel model = ViaCEPModel(
                      cepController.text,
                      logradouroController.text,
                      complementoController.text,
                      bairroController.text,
                      localidadeController.text,
                      ufController.text,
                      ibgeController.text,
                      giaController.text,
                      dddController.text,
                      siafiController.text,
                    );
                    await _back4appCEPService.create(model);
                    if (context.mounted) Navigator.of(context).pop(context);
                  },
                  child: const Text(
                    "Salvar",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
