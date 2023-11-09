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
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController3;
  String? Function(BuildContext, String?)? textController3Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController4;
  String? Function(BuildContext, String?)? textController4Validator;
  String? _textController4Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'ieivauvc' /* Field is required */,
      );
    }

    return null;
  }

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode3;
  TextEditingController? textController5;
  String? Function(BuildContext, String?)? textController5Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode4;
  TextEditingController? textController6;
  String? Function(BuildContext, String?)? textController6Validator;
  String? _textController6Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'en1eqln8' /* Field is required */,
      );
    }

    return null;
  }

  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
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
    textController4Validator = _textController4Validator;
    textController6Validator = _textController6Validator;
  }

  void dispose() {
    unfocusNode.dispose();
    tabBarController?.dispose();
    standNameDEFocusNode?.dispose();
    standNameDEController?.dispose();

    standnameGRFocusNode?.dispose();
    standnameGRController?.dispose();

    textFieldFocusNode1?.dispose();
    textController3?.dispose();

    textFieldFocusNode2?.dispose();
    textController4?.dispose();

    textFieldFocusNode3?.dispose();
    textController5?.dispose();

    textFieldFocusNode4?.dispose();
    textController6?.dispose();

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
