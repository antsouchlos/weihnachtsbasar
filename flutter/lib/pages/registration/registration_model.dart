import '/backend/api_requests/api_calls.dart';
import '/components/footer/footer_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'registration_widget.dart' show RegistrationWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RegistrationModel extends FlutterFlowModel<RegistrationWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  // State field(s) for NameField widget.
  FocusNode? nameFieldFocusNode;
  TextEditingController? nameFieldController;
  String? Function(BuildContext, String?)? nameFieldControllerValidator;
  String? _nameFieldControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'cymx9cck' /* Field is required */,
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
        '99niuziz' /* Field is required */,
      );
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Has to be a valid email address.';
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
        's4g8lots' /* Field is required */,
      );
    }

    return null;
  }

  // State field(s) for StandDropdown widget.
  String? standDropdownValue;
  FormFieldController<String>? standDropdownValueController;
  // State field(s) for ShiftDropdown widget.
  String? shiftDropdownValue;
  FormFieldController<String>? shiftDropdownValueController;
  // Stores action output result for [Backend Call - API (Add registration)] action in Button widget.
  ApiCallResponse? apiResultsc0;
  // Model for Footer component.
  late FooterModel footerModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    nameFieldControllerValidator = _nameFieldControllerValidator;
    emailFieldControllerValidator = _emailFieldControllerValidator;
    phoneFieldControllerValidator = _phoneFieldControllerValidator;
    footerModel = createModel(context, () => FooterModel());
  }

  void dispose() {
    unfocusNode.dispose();
    nameFieldFocusNode?.dispose();
    nameFieldController?.dispose();

    emailFieldFocusNode?.dispose();
    emailFieldController?.dispose();

    phoneFieldFocusNode?.dispose();
    phoneFieldController?.dispose();

    footerModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
