import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/request_manager.dart';

import 'stand_card_shift_new_widget.dart' show StandCardShiftNewWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class StandCardShiftNewModel extends FlutterFlowModel<StandCardShiftNewWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for Switch widget.
  bool? switchValue;
  // Stores action output result for [Backend Call - API (Set registration status)] action in Switch widget.
  ApiCallResponse? apiResultqy1;
  // Stores action output result for [Backend Call - API (Set registration status)] action in Switch widget.
  ApiCallResponse? apiResultjho;
  // Stores action output result for [Backend Call - API (Delete registration)] action in IconButton widget.
  ApiCallResponse? apiResultkb3;

  /// Query cache managers for this widget.

  final _getRegistrationsManager = FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> getRegistrations({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _getRegistrationsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearGetRegistrationsCache() => _getRegistrationsManager.clear();
  void clearGetRegistrationsCacheKey(String? uniqueKey) =>
      _getRegistrationsManager.clearRequest(uniqueKey);

  final _getRegistrationStatusManager = FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> getRegistrationStatus({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _getRegistrationStatusManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearGetRegistrationStatusCache() =>
      _getRegistrationStatusManager.clear();
  void clearGetRegistrationStatusCacheKey(String? uniqueKey) =>
      _getRegistrationStatusManager.clearRequest(uniqueKey);

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    /// Dispose query cache managers for this widget.

    clearGetRegistrationsCache();

    clearGetRegistrationStatusCache();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
