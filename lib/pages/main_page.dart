import 'package:cep_flutter/services/viacep/via_cep_service.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          children: [
            FilledButton(
              onPressed: () async {
                ViaCEPService service = ViaCEPService();
                var response = await service.getByCEP("01001000");
                debugPrint(response.toString());
              },
              child: const Text("Teste Via CEP"),
            ),
          ],
        ),
      ),
    );
  }
}
