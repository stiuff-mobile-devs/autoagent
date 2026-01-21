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
}
