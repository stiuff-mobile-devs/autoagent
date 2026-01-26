import 'dart:ui';

import 'package:autoagent/app/modules/login/controller/login_controller.dart';
import 'package:autoagent/app/utils/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.darkBlueToBlackGradient(),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -120,
              right: -60,
              child: _AccentBlob(
                size: 220,
                color: AppColors.mediumBlue(alpha: 90),
              ),
            ),
            Positioned(
              bottom: -80,
              left: -40,
              child: _AccentBlob(
                size: 180,
                color: AppColors.alternativeMediumBlue(alpha: 70),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 24,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'AutoAgent',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Assistente inteligente para suas operações',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white.withOpacity(0.78),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    _GlassCard(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Entrar',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Use sua conta Google para continuar',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 42,
                                width: 42,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColors.mediumBlue(alpha: 220),
                                      AppColors.alternativeMediumBlue(
                                        alpha: 220,
                                      ),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.mediumBlue(alpha: 120),
                                      blurRadius: 18,
                                      spreadRadius: 1,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.auto_awesome,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          Obx(() {
                            final isLoading = controller.isLoading.value;
                            return SizedBox(
                              width: double.infinity,
                              height: 54,
                              child: ElevatedButton.icon(
                                onPressed: isLoading
                                    ? null
                                    : controller.trySignInWithGoogle,
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: Colors.white,
                                  foregroundColor: AppColors.darkBlue(),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                ),
                                icon: isLoading
                                    ? const SizedBox(
                                        width: 22,
                                        height: 22,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                Colors.black87,
                                              ),
                                        ),
                                      )
                                    : SizedBox(
                                        width: 22,
                                        height: 22,
                                        child: Image.asset(
                                          'assets/icons/google.png',
                                        ),
                                      ),
                                label: Text(
                                  isLoading
                                      ? 'Conectando...'
                                      : 'Continuar com Google',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            );
                          }),
                          const SizedBox(height: 14),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GlassCard extends StatelessWidget {
  const _GlassCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.15)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.35),
                blurRadius: 22,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

class _AccentBlob extends StatelessWidget {
  const _AccentBlob({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, color.withOpacity(0.05)],
          stops: const [0.2, 1],
        ),
      ),
    );
  }
}
