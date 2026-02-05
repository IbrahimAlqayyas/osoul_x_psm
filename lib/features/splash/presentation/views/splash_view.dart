import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osoul_x_psm/core/app/version.dart';
import 'package:osoul_x_psm/core/logging/logging.dart';
import 'package:osoul_x_psm/core/preferences/preferences.dart';
import 'package:osoul_x_psm/core/shared_widgets/logo.dart';
import 'package:osoul_x_psm/core/theme/colors.dart';
import 'package:osoul_x_psm/features/auth/views/login_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late AnimationController _shineController;
  late AnimationController _fadeController;
  late Animation<double> _shineAnimation;
  late Animation<double> _fadeAnimation;

  Future<void> startNavigation() async {
    // /// check for saved token
    // UserModel? savedUser = await Preferences().getSavedUser();
    // kLog('savedUser');
    // kLog(savedUser);

    // if (savedUser != null) {
    //   Future.delayed(const Duration(seconds: 5), () => Get.to(() => HomeView()));
    // } else {
    //   /// no saved login data
    //   Future.delayed(const Duration(seconds: 5), () => Get.to(() => LoginView()));
    // }

    Future.delayed(const Duration(seconds: 5), () => Get.to(() => LoginView()));
  }

  @override
  void initState() {
    super.initState();
    // Initialize shine animation
    _shineController = AnimationController(duration: const Duration(seconds: 5), vsync: this)
      ..repeat();
    _shineAnimation = Tween<double>(
      begin: -1.0,
      end: 2.0,
    ).animate(CurvedAnimation(parent: _shineController, curve: Curves.linearToEaseOut));
    // Initialize fade animation
    _fadeController = AnimationController(duration: const Duration(seconds: 5), vsync: this);
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));
    _fadeController.forward();
    startNavigation();
  }

  @override
  void dispose() {
    _shineController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          /// logo
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: Listenable.merge([_shineAnimation, _fadeAnimation]),
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _fadeAnimation,
                      child: ShaderMask(
                        shaderCallback: (bounds) {
                          return LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: const [0.0, 0.3, 0.7, 1.0],
                            colors: [
                              Colors.transparent,
                              Colors.white.withAlpha(opacityToAlpha(0.4)),
                              Colors.white.withAlpha(opacityToAlpha(0.4)),
                              Colors.transparent,
                            ],
                            transform: _SlidingGradientTransform(_shineAnimation.value),
                          ).createShader(bounds);
                        },
                        blendMode: BlendMode.srcATop,
                        child: const LogoWidget(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          /// footer
          // const FooterWidget(),

          /// version
          Padding(
            padding: const EdgeInsets.only(bottom: 17),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(AppVersion.getVersion(), style: const TextStyle(color: kPrimaryColor)),
            ),
          ),
        ],
      ),
    );
  }
}

/// Helper class to move the gradient
class _SlidingGradientTransform extends GradientTransform {
  final double slidePercent;

  const _SlidingGradientTransform(this.slidePercent);

  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}
