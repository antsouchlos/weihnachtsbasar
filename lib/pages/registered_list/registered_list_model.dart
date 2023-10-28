import '/components/footer/footer_widget.dart';
import '/components/stand_card/stand_card_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'registered_list_widget.dart' show RegisteredListWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RegisteredListModel extends FlutterFlowModel<RegisteredListWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for StandCard component.
  late StandCardModel standCardModel1;
  // Model for StandCard component.
  late StandCardModel standCardModel2;
  // Model for StandCard component.
  late StandCardModel standCardModel3;
  // Model for StandCard component.
  late StandCardModel standCardModel4;
  // Model for StandCard component.
  late StandCardModel standCardModel5;
  // Model for Footer component.
  late FooterModel footerModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    standCardModel1 = createModel(context, () => StandCardModel());
    standCardModel2 = createModel(context, () => StandCardModel());
    standCardModel3 = createModel(context, () => StandCardModel());
    standCardModel4 = createModel(context, () => StandCardModel());
    standCardModel5 = createModel(context, () => StandCardModel());
    footerModel = createModel(context, () => FooterModel());
  }

  void dispose() {
    unfocusNode.dispose();
    standCardModel1.dispose();
    standCardModel2.dispose();
    standCardModel3.dispose();
    standCardModel4.dispose();
    standCardModel5.dispose();
    footerModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
