import 'dart:async';

/// DiModule to allow auto setup and dispose of all dependencies of module
abstract class DiModule {
  FutureOr<void> setup();

  void dispose();
}
