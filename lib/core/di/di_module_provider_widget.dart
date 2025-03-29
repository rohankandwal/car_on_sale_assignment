import 'package:assignment_car_on_sale/core/di/di_module.dart';
import 'package:flutter/material.dart';

/// DiModule provider for automatic initialization and disposing of modules
class DiModuleProviderWidget extends StatefulWidget {
  final Widget child;
  final DiModule module;

  const DiModuleProviderWidget({
    required this.child,
    required this.module,
    super.key,
  });

  @override
  State<DiModuleProviderWidget> createState() => _DiModuleProviderWidgetState();
}

class _DiModuleProviderWidgetState extends State<DiModuleProviderWidget> {
  @override
  void initState() {
    setupModule();
    super.initState();
  }

  @override
  void dispose() {
    disposeModule();
    super.dispose();
  }

  void setupModule() => widget.module.setup();

  void disposeModule() => widget.module.dispose();

  @override
  Widget build(BuildContext context) => widget.child;
}
