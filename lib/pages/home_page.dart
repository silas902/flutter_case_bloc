import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final textController = TextEditingController();
  var isLoading = false;
  String? error;
  var cepResult = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('CEP Search'),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            Row(children: [
              ActionChip(
                label: const Text('01001000'),
                onPressed: () {
                  textController.text = '01001000';
                  searchCEP(textController.text);
                },
              ),
              const SizedBox(width: 8),
              ActionChip(
                label: const Text('01001001'),
                onPressed: () {
                  textController.text = '01001001';
                  searchCEP(textController.text);
                },
              ),
              const SizedBox(width: 8),
              ActionChip(
                label: const Text('01001010'),
                onPressed: () {
                  textController.text = '01001010';
                  searchCEP(textController.text);
                },
              ),
            ]),
            const SizedBox(height: 16),
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'CEP',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                searchCEP(textController.text);
              },
              child: const Text('Search'),
            ),
            const SizedBox(height: 16),
            if (isLoading) const CircularProgressIndicator(),
            if (error != null) Text(error!),
            if (cepResult.isNotEmpty)
              Column(
                children: [
                  Text('CEP: ${cepResult['cep']}'),
                  Text('Logradouro: ${cepResult['logradouro']}'),
                  Text('Complemento: ${cepResult['complemento']}'),
                  Text('Bairro: ${cepResult['bairro']}'),
                  Text('Localidade: ${cepResult['localidade']}'),
                  Text('UF: ${cepResult['uf']}'),
                  Text('IBGE: ${cepResult['ibge']}'),
                  Text('GIA: ${cepResult['gia']}'),
                  Text('DDD: ${cepResult['ddd']}'),
                  Text('SIAFI: ${cepResult['siafi']}'),
                ],
              ),
          ]),
        ));
  }

  Future<void> searchCEP(String cep) async {
    try {
      cepResult = {};
      error = null;
      setState(() {
        isLoading = true;
      });
      final response = await Dio().get('https://viacep.com.br/ws/$cep/json/');
      setState(() {
        cepResult = response.data;
      });
    } catch (e) {
      error = 'Error: $e';
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
