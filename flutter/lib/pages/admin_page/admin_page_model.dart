import '/backend/api_requests/api_calls.dart';
import '/components/stand_card/stand_card_widget.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/actions/index.dart' as actions;
import 'admin_page_widget.dart' show AdminPageWidget;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AdminPageModel extends FlutterFlowModel<AdminPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  bool apiRequestCompleted1 = false;
  String? apiRequestLastUniqueKey1;
  // Stores action output result for [Backend Call - API (Remove stand)] action in IconButton widget.
  ApiCallResponse? apiResult60s;
  // State field(s) for StandNameDE widget.
  FocusNode? standNameDEFocusNode;
  TextEditingController? standNameDEController;
  String? Function(BuildContext, String?)? standNameDEControllerValidator;
  // State field(s) for StandnameGR widget.
  FocusNode? standnameGRFocusNode;
  TextEditingController? standnameGRController;
  String? Function(BuildContext, String?)? standnameGRControllerValidator;
  // Stores action output result for [Backend Call - API (Add stand)] action in IconButton widget.
  ApiCallResponse? apiResultkn2;
  // Stores action output result for [Backend Call - API (Delete user)] action in IconButton widget.
  ApiCallResponse? apiResultzyj;
  // State field(s) for NameField widget.
  FocusNode? nameFieldFocusNode;
  TextEditingController? nameFieldController;
  String? Function(BuildContext, String?)? nameFieldControllerValidator;
  String? _nameFieldControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'v57fpinr' /* Field is required */,
      );
    }

    return null;
  }

  // State field(s) for EmailField widget.
  FocusNode? emailFieldFocusNode;
  TextEditingController? emailFieldController;
  String? Function(BuildContext, String?)? emailFieldControllerValidator;
  String? _emailFieldControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'ieivauvc' /* Field is required */,
      );
    }

    return null;
  }

  // State field(s) for PhoneField widget.
  FocusNode? phoneFieldFocusNode;
  TextEditingController? phoneFieldController;
  String? Function(BuildContext, String?)? phoneFieldControllerValidator;
  String? _phoneFieldControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'ian8ggsx' /* Field is required */,
      );
    }

    return null;
  }

  // State field(s) for PasswordField widget.
  FocusNode? passwordFieldFocusNode;
  TextEditingController? passwordFieldController;
  late bool passwordFieldVisibility;
  String? Function(BuildContext, String?)? passwordFieldControllerValidator;
  String? _passwordFieldControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'en1eqln8' /* Field is required */,
      );
    }

    return null;
  }

  // State field(s) for StandDropDown widget.
  String? standDropDownValue;
  FormFieldController<String>? standDropDownValueController;
  // Stores action output result for [Backend Call - API (Add user)] action in IconButton widget.
  ApiCallResponse? apiResultkzs;
  bool apiRequestCompleted2 = false;
  String? apiRequestLastUniqueKey2;
  // Stores action output result for [Backend Call - API (Remove shift)] action in IconButton widget.
  ApiCallResponse? apiResults7h;
  // State field(s) for ShiftTextDE widget.
  FocusNode? shiftTextDEFocusNode;
  TextEditingController? shiftTextDEController;
  String? Function(BuildContext, String?)? shiftTextDEControllerValidator;
  // State field(s) for ShiftTextGR widget.
  FocusNode? shiftTextGRFocusNode;
  TextEditingController? shiftTextGRController;
  String? Function(BuildContext, String?)? shiftTextGRControllerValidator;
  // Stores action output result for [Backend Call - API (Add shift)] action in IconButton widget.
  ApiCallResponse? apiResultdsv;
  bool apiRequestCompleted3 = false;
  String? apiRequestLastUniqueKey3;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    nameFieldControllerValidator = _nameFieldControllerValidator;
    emailFieldControllerValidator = _emailFieldControllerValidator;
    phoneFieldControllerValidator = _phoneFieldControllerValidator;
    passwordFieldVisibility = false;
    passwordFieldControllerValidator = _passwordFieldControllerValidator;
  }

  void dispose() {
    unfocusNode.dispose();
    tabBarController?.dispose();
    standNameDEFocusNode?.dispose();
    standNameDEController?.dispose();

    standnameGRFocusNode?.dispose();
    standnameGRController?.dispose();

    nameFieldFocusNode?.dispose();
    nameFieldController?.dispose();

    emailFieldFocusNode?.dispose();
    emailFieldController?.dispose();

    phoneFieldFocusNode?.dispose();
    phoneFieldController?.dispose();

    passwordFieldFocusNode?.dispose();
    passwordFieldController?.dispose();

    shiftTextDEFocusNode?.dispose();
    shiftTextDEController?.dispose();

    shiftTextGRFocusNode?.dispose();
    shiftTextGRController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.

  Future waitForApiRequestCompleted1({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleted1;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }

  Future waitForApiRequestCompleted2({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleted2;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }

  Future waitForApiRequestCompleted3({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleted3;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
