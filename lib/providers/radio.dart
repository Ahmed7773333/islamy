import 'package:flutter/material.dart';

import '../models/radio_model.dart';

class RadioProvider with ChangeNotifier {
  List<RadioStation> _radioStations = [];
  bool _isLoading = false;

  List<RadioStation> get radioStations => _radioStations;
  bool get isLoading => _isLoading;

  Future<void> fetchRadioStations() async {
    _isLoading = true;
    notifyListeners();

    _radioStations = await RadioService().fetchRadioStations();

    _isLoading = false;
    notifyListeners();
  }
}
