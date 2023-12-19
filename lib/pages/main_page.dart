import 'package:cep_flutter/exceptions/bad_request_exception.dart';
import 'package:cep_flutter/exceptions/http_request_exception.dart';
import 'package:cep_flutter/exceptions/not_found_exception.dart';
import 'package:cep_flutter/models/cep_model.dart';
import 'package:cep_flutter/models/via_cep_model.dart';
import 'package:cep_flutter/pages/edit_cep_page.dart';
import 'package:cep_flutter/services/back4app/back4app_cep_service.dart';
import 'package:cep_flutter/shared/widget/add_cep_dialog.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Back4AppCEPService _back4appCEPService;
  var _ceps = <CEPModel>[];

  bool isLoading = false;

  void loadData() async {
    setState(() {
      isLoading = true;
    });
    try {
      _ceps = await _back4appCEPService.list();
    } catch (e) {
      if (e is HttpRequestException) {
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
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _back4appCEPService = Back4AppCEPService();
    loadData();
  }

  void delete(String objectId) async {
    try {
      await _back4appCEPService.delete(objectId);
    } catch (e) {
      if (e is HttpRequestException) {
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
      } else if (e is BadRequestException) {
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
      } else if (e is NotFoundException) {
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
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.mail),
          title: Text(widget.title),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: _ceps.length,
                  itemBuilder: (_, index) {
                    var model = _ceps[index];
                    return Dismissible(
                      key: Key(model.objectId ?? model.cep),
                      onDismissed: (_) => delete(model.objectId!),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => EditCEPPage(
                                        viaCEPModel: ViaCEPModel.fromJson(
                                            model.toJson()),
                                        objectId: model.objectId,
                                      )));
                        },
                        child: Card(
                          color: const Color.fromRGBO(48, 48, 48, 1),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  model.cep,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(model.logradouro),
                                Text(
                                    "${model.bairro} - ${model.localidade} / ${model.uf}"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (builder) {
                  return const AddCEPDialog();
                });
          },
          child: const Icon(Icons.add_location),
        ),
      ),
    );
  }
}
