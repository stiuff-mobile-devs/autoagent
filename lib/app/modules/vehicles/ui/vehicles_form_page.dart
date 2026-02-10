import 'package:autoagent/app/modules/vehicles/controller/vehicles_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VehiclesFormPage extends GetView<VehiclesFormController> {
  const VehiclesFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Novo veiculo')),
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFormField(
                controller: controller.nameController,
                decoration: const InputDecoration(labelText: 'Nome'),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe o nome';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: controller.placaController,
                decoration: const InputDecoration(labelText: 'Placa'),
                textInputAction: TextInputAction.done,
                textCapitalization: TextCapitalization.characters,
                /*validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe a placa';
                  }
                  return null;
                },*/
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: controller.submitVehicle,
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
