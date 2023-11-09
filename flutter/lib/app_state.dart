import 'package:flutter/material.dart';
import 'flutter_flow/request_manager.dart';
import 'backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  String _username = '';
  String get username => _username;
  set username(String _value) {
    _username = _value;
  }

  String _password = '';
  String get password => _password;
  set password(String _value) {
    _password = _value;
  }

  String _language = 'de';
  String get language => _language;
  set language(String _value) {
    _language = _value;
  }

  final _getStandsManager = FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> getStands({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _getStandsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearGetStandsCache() => _getStandsManager.clear();
  void clearGetStandsCacheKey(String? uniqueKey) =>
      _getStandsManager.clearRequest(uniqueKey);

  final _getShiftsManager = FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> getShifts({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _getShiftsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearGetShiftsCache() => _getShiftsManager.clear();
  void clearGetShiftsCacheKey(String? uniqueKey) =>
      _getShiftsManager.clearRequest(uniqueKey);

  final _getUsersManager = FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> getUsers({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _getUsersManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearGetUsersCache() => _getUsersManager.clear();
  void clearGetUsersCacheKey(String? uniqueKey) =>
      _getUsersManager.clearRequest(uniqueKey);
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
