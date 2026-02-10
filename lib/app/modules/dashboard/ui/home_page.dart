import 'package:autoagent/app/modules/dashboard/controller/home_controller.dart';
import 'package:autoagent/app/utils/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.darkBlueToBlackGradient(),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                backgroundColor: Colors.transparent,
                title: Row(
                  children: [
                    Icon(Icons.directions_car, color: AppColors.lightBlue()),
                    SizedBox(width: 8),
                    Text(
                      'AutoAgent',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.bluetooth, color: AppColors.lightBlue()),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.settings, color: AppColors.lightBlue()),
                    onPressed: () {},
                  ),
                ],
              ),
              SliverPadding(
                padding: EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Localização
                    _buildLocationStatusIndicator(),
                    SizedBox(height: 20),

                    // Status de Conexão
                    _buildConnectionStatus(),
                    SizedBox(height: 20),

                    // Velocidade - Destaque Principal
                    _buildSpeedometer(),
                    SizedBox(height: 20),

                    // Grid de Dados do Motor
                    _buildDataGrid(),
                    SizedBox(height: 20),

                    // Dados de Combustível e Temperatura
                    _buildFuelAndTempRow(),
                    SizedBox(height: 20),

                    // Diagnóstico
                    _buildDiagnosticCard(),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConnectionStatus() {
    return Obx(
      () => Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.mediumBlue().withOpacity(0.3),
              AppColors.darkBlue().withOpacity(0.2),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.lightBlue().withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: controller.isConnected.value
                    ? Colors.greenAccent
                    : Colors.redAccent,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: controller.isConnected.value
                        ? Colors.greenAccent.withOpacity(0.5)
                        : Colors.redAccent.withOpacity(0.5),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
            SizedBox(width: 12),
            Text(
              controller.isConnected.value
                  ? 'Conectado ao OBD2'
                  : 'Desconectado',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(),
            Text(
              controller.deviceName.value,
              style: TextStyle(color: AppColors.lightBlue(), fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpeedometer() {
    return Obx(
      () => Container(
        height: 200,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.mediumBlue().withOpacity(0.4),
              AppColors.darkBlue().withOpacity(0.3),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColors.lightBlue().withOpacity(0.4),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.mediumBlue().withOpacity(0.3),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'VELOCIDADE',
              style: TextStyle(
                color: AppColors.lightBlue(),
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 2,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  controller.speed.value.toStringAsFixed(0),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 72,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Text(
                    'km/h',
                    style: TextStyle(
                      color: AppColors.lightBlue(),
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataGrid() {
    return Obx(
      () => GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.3,
        children: [
          _buildDataCard(
            icon: Icons.speed,
            label: 'RPM',
            value: controller.rpm.value.toString(),
            unit: 'rpm',
            color: Colors.cyanAccent,
          ),
          _buildDataCard(
            icon: Icons.thermostat,
            label: 'MOTOR',
            value: controller.engineTemp.value.toString(),
            unit: '°C',
            color: Colors.orangeAccent,
          ),
          _buildDataCard(
            icon: Icons.air,
            label: 'ACELERADOR',
            value: controller.throttlePosition.value.toString(),
            unit: '%',
            color: Colors.greenAccent,
          ),
          _buildDataCard(
            icon: Icons.battery_charging_full,
            label: 'BATERIA',
            value: controller.batteryVoltage.value.toStringAsFixed(1),
            unit: 'V',
            color: Colors.lightGreenAccent,
          ),
        ],
      ),
    );
  }

  Widget _buildDataCard({
    required IconData icon,
    required String label,
    required String value,
    required String unit,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.alternativeMediumBlue().withOpacity(0.3),
            AppColors.alternativeDarkBlue().withOpacity(0.2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3), width: 1.5),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    color: AppColors.lightBlue(),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                ),
                SizedBox(width: 4),
                Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Text(
                    unit,
                    style: TextStyle(
                      color: color,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFuelAndTempRow() {
    return Obx(
      () => Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.mediumBlue().withOpacity(0.3),
                    AppColors.darkBlue().withOpacity(0.2),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.blueAccent.withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.local_gas_station,
                    color: Colors.blueAccent,
                    size: 32,
                  ),
                  SizedBox(height: 12),
                  Text(
                    '${controller.fuelLevel.value}%',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'COMBUSTÍVEL',
                    style: TextStyle(
                      color: AppColors.lightBlue(),
                      fontSize: 11,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.mediumBlue().withOpacity(0.3),
                    AppColors.darkBlue().withOpacity(0.2),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.purpleAccent.withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              child: Column(
                children: [
                  Icon(Icons.ac_unit, color: Colors.purpleAccent, size: 32),
                  SizedBox(height: 12),
                  Text(
                    '${controller.airTemp.value}°C',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'AR INTERNO',
                    style: TextStyle(
                      color: AppColors.lightBlue(),
                      fontSize: 11,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiagnosticCard() {
    return Obx(
      () => Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.mediumBlue().withOpacity(0.3),
              AppColors.darkBlue().withOpacity(0.2),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: controller.systemHealthy.value
                ? Colors.greenAccent.withOpacity(0.3)
                : Colors.redAccent.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  controller.systemHealthy.value
                      ? Icons.check_circle
                      : Icons.error_outline,
                  color: controller.systemHealthy.value
                      ? Colors.greenAccent
                      : Colors.redAccent,
                  size: 24,
                ),
                SizedBox(width: 12),
                Text(
                  'DIAGNÓSTICO',
                  style: TextStyle(
                    color: AppColors.lightBlue(),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              controller.systemHealthy.value
                  ? 'Sistema operando normalmente'
                  : 'Problemas detectados no sistema',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              '${controller.errorCodesCount.value} códigos de erro detectados',
              style: TextStyle(
                color: controller.systemHealthy.value
                    ? Colors.greenAccent
                    : Colors.redAccent,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationStatusIndicator() {
    return Obx(
      () => GestureDetector(
        onTap: () => _showLocationStatusDialog(),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.mediumBlue().withOpacity(0.3),
                AppColors.darkBlue().withOpacity(0.2),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: controller.getLocationStatusColor().withOpacity(0.5),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: controller.getLocationStatusColor().withOpacity(0.2),
                blurRadius: 12,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: controller.getLocationStatusColor(),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: controller.getLocationStatusColor().withOpacity(
                        0.6,
                      ),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12),
              Icon(
                Icons.location_on,
                color: controller.getLocationStatusColor(),
                size: 24,
              ),
              SizedBox(width: 8),
              Text(
                'Rastreamento GPS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Text(
                controller.locationStatus.value == 'success'
                    ? 'Ativo'
                    : controller.locationStatus.value == 'warning'
                    ? 'Aviso'
                    : 'Erro',
                style: TextStyle(
                  color: controller.getLocationStatusColor(),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              SizedBox(width: 8),
              Obx(() {
                final hasSelectedVehicle =
                    controller.selectedVehicle.isNotEmpty;
                return IconButton(
                  icon: Icon(
                    Icons.directions_car,
                    color: hasSelectedVehicle
                        ? controller.getLocationStatusColor()
                        : Colors.redAccent,
                    size: 20,
                  ),
                  onPressed: () => _showVehicleActionsDialog(),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                );
              }),
              SizedBox(width: 8),
              IconButton(
                icon: Icon(
                  Icons.refresh,
                  color: controller.getLocationStatusColor(),
                  size: 20,
                ),
                onPressed: () => controller.refreshLocation(),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
              ),
              SizedBox(width: 8),
              Icon(
                Icons.info_outline,
                color: controller.getLocationStatusColor(),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLocationStatusDialog() {
    String title;
    String message;
    IconData icon;
    Color color = controller.getLocationStatusColor();

    switch (controller.locationStatus.value) {
      case 'success':
        title = 'Rastreamento Ativo';
        icon = Icons.check_circle;
        message =
            'O sistema de rastreamento GPS está funcionando perfeitamente.\n\n'
            '✓ Localização sendo atualizada regularmente\n'
            '✓ Sinal GPS forte\n'
            '✓ Dados sendo enviados com sucesso\n\n'
            'Tentativas falhadas: ${controller.failedAttempts.value}';
        break;
      case 'warning':
        title = 'Atenção - Falha Detectada';
        icon = Icons.warning_amber;
        message =
            'Uma tentativa de atualização de localização falhou recentemente.\n\n'
            '⚠ Última tentativa falhou\n'
            '⚠ Sistema tentará novamente automaticamente\n'
            '⚠ Verifique sua conexão GPS\n\n'
            'Tentativas falhadas: ${controller.failedAttempts.value}\n\n'
            'Se o problema persistir, verifique se o GPS está ativado nas configurações.';
        break;
      case 'error':
        title = 'Erro - Rastreamento Comprometido';
        icon = Icons.error;
        message =
            'Múltiplas falhas foram detectadas no sistema de rastreamento.\n\n'
            '✗ ${controller.failedAttempts.value} tentativas consecutivas falharam\n'
            '✗ Sinal GPS pode estar fraco ou indisponível\n'
            '✗ Dados de localização podem estar desatualizados\n\n'
            'AÇÕES RECOMENDADAS:\n'
            '1. Verifique se o GPS está ativado\n'
            '2. Certifique-se de estar em área aberta\n'
            '3. Reinicie o aplicativo se necessário\n'
            '4. Verifique as permissões de localização';
        break;
      default:
        title = 'Status Desconhecido';
        icon = Icons.help_outline;
        message = 'Não foi possível determinar o status do rastreamento.';
    }

    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.darkBlue(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: color.withOpacity(0.5), width: 2),
        ),
        title: Row(
          children: [
            Icon(icon, color: color, size: 28),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        content: Text(
          message,
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 14,
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'ENTENDI',
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  void _showVehicleActionsDialog() {
    final color = controller.getLocationStatusColor();

    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.darkBlue(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: color.withOpacity(0.5), width: 2),
        ),
        title: Row(
          children: [
            Icon(Icons.directions_car, color: color, size: 28),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Veículos',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        content: Obx(() {
          final selectedId = controller.selectedVehicle['id'];

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selecione um veiculo',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12),
              ...controller.userVehicles.map((vehicle) {
                final name = (vehicle['name'] ?? '').toString();
                final placa = (vehicle['placa'] ?? '').toString();
                final isSelected =
                    selectedId != null && selectedId == vehicle['id'];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _buildVehicleActionButton(
                    icon: Icons.directions_car,
                    label: '$name - $placa',
                    color: color,
                    isSelected: isSelected,
                    onTap: () {
                      controller.selectVehicle(vehicle);
                      _showVehicleInfoDialog(vehicle);
                    },
                  ),
                );
              }),
              _buildVehicleActionButton(
                icon: Icons.add,
                label: 'Criar veiculo',
                color: color,
                onTap: () {
                  Get.back();
                  controller.createVehicle();
                },
              ),
            ],
          );
        }),
      ),
    );
  }

  void _showVehicleInfoDialog(Map<String, dynamic> vehicle) {
    final name = (vehicle['name'] ?? '').toString();
    final placa = (vehicle['placa'] ?? '').toString();
    final email = (vehicle['email'] ?? '').toString();
    final createdAt = (vehicle['createdAt'] ?? '').toString();

    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.darkBlue(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: AppColors.lightBlue().withOpacity(0.5),
            width: 2,
          ),
        ),
        title: Row(
          children: [
            Icon(Icons.directions_car, color: AppColors.lightBlue(), size: 24),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Veiculo selecionado',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome: $name', style: TextStyle(color: Colors.white)),
            SizedBox(height: 6),
            Text('Placa: $placa', style: TextStyle(color: Colors.white)),
            SizedBox(height: 6),
            if (email.isNotEmpty)
              Text('Email: $email', style: TextStyle(color: Colors.white)),
            if (createdAt.isNotEmpty) ...[
              SizedBox(height: 6),
              Text(
                'Criado em: $createdAt',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Fechar',
              style: TextStyle(color: AppColors.lightBlue()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
    bool isSelected = false,
  }) {
    final highlightColor = isSelected ? AppColors.lightBlue() : color;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              highlightColor.withOpacity(0.25),
              AppColors.darkBlue().withOpacity(isSelected ? 0.8 : 0.6),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: highlightColor.withOpacity(isSelected ? 0.9 : 0.5),
            width: isSelected ? 2 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: highlightColor.withOpacity(isSelected ? 0.35 : 0.2),
              blurRadius: isSelected ? 14 : 10,
              spreadRadius: isSelected ? 2 : 1,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: highlightColor, size: 20),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(
              isSelected ? Icons.check_circle : Icons.chevron_right,
              color: highlightColor,
            ),
          ],
        ),
      ),
    );
  }
}
