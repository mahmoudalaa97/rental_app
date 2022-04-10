import 'package:flutter/material.dart';
import 'package:rental_app/domain/repository.dart';

class RepositoryProvider extends InheritedWidget {
  const RepositoryProvider(
      {Key? key, required this.repository, required Widget child})
      : super(key: key, child: child);

  final Repository repository;

  static Repository of(BuildContext context) {
    final findProvider =
        context.dependOnInheritedWidgetOfExactType<RepositoryProvider>();

    assert(findProvider != null, 'No $RepositoryProvider found in context');

    return findProvider!.repository;
  }

  @override
  bool updateShouldNotify(RepositoryProvider oldWidget) =>
      repository != oldWidget.repository;
}

extension BuildContextExt on BuildContext {
  Repository get repository => RepositoryProvider.of(this);
}
