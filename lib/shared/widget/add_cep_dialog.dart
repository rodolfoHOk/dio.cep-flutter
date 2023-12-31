import 'package:cep_flutter/exceptions/bad_request_exception.dart';
import 'package:cep_flutter/exceptions/http_request_exception.dart';
import 'package:cep_flutter/pages/edit_cep_page.dart';
import 'package:cep_flutter/services/viacep/via_cep_service.dart';
import 'package:cep_flutter/shared/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class AddCEPDialog extends StatefulWidget {
  const AddCEPDialog({super.key});

  @override
  State<AddCEPDialog> createState() => _AddCEPDialogState();
}

class _AddCEPDialogState extends State<AddCEPDialog> {
  var cepController = TextEditingController(text: "");
  late ViaCEPService _viaCEPService;

  var isLoading = false;

  @override
  void initState() {
    super.initState();
    _viaCEPService = ViaCEPService();
  }

  void confirm() async {
    setState(() {
      isLoading = true;
    });
    try {
      var viaCepModel = await _viaCEPService.getByCEP(cepController.text);
      if (context.mounted) {
        Navigator.of(context).pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) => EditCEPPage(viaCEPModel: viaCepModel)));
      }
    } catch (e) {
      if (e is BadRequestException) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                e.message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        }
      } else if (e is HttpRequestException) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                e.message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        }
      } else {
        rethrow;
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromRGBO(0, 32, 0, 1),
      title: const Center(
        child: Text("Adicionar CEP"),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextFormField(
            title: "Cep: (apenas números)",
            keyboardType: TextInputType.number,
            controller: cepController,
          )
        ],
      ),
      actions: [
        FilledButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancelar"),
        ),
        FilledButton(
          onPressed: () => confirm(),
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                )
              : const Text("Confirmar"),
        ),
      ],
    );
  }
}
