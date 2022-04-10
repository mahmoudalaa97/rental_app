import 'package:flutter/material.dart';

import '../data/model/property.dart';
import '../domain/repository.dart';

abstract class BaseDataController<T, Param> extends ChangeNotifier {
  ConnectionState _state = ConnectionState.none;

  T? data;
  String? error;

  set state(ConnectionState newState) {
    if (newState == _state) return;
    _state = newState;
    notifyListeners();
  }

  ConnectionState get state => _state;

  void fetch({Param param});

  bool get isLoading => state == ConnectionState.waiting;
}

class PropertiesDataController
    extends BaseDataController<List<Property>, String?> {
  PropertiesDataController({required this.repository});

  final Repository repository;

  @override
  void fetch({String? param}) async {
    state = ConnectionState.waiting;
    final response = await repository.fetchProperties(query: param);

    response.fold(
      (left) => error = left,
      (right) => data = right,
    );
    state = ConnectionState.done;
  }
}
