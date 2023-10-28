import '/components/stand_card_entry/stand_card_entry_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'stand_card_widget.dart' show StandCardWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class StandCardModel extends FlutterFlowModel<StandCardWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for StandCardEntry component.
  late StandCardEntryModel standCardEntryModel1;
  // Model for StandCardEntry component.
  late StandCardEntryModel standCardEntryModel2;
  // Model for StandCardEntry component.
  late StandCardEntryModel standCardEntryModel3;
  // Model for StandCardEntry component.
  late StandCardEntryModel standCardEntryModel4;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    standCardEntryModel1 = createModel(context, () => StandCardEntryModel());
    standCardEntryModel2 = createModel(context, () => StandCardEntryModel());
    standCardEntryModel3 = createModel(context, () => StandCardEntryModel());
    standCardEntryModel4 = createModel(context, () => StandCardEntryModel());
  }

  void dispose() {
    standCardEntryModel1.dispose();
    standCardEntryModel2.dispose();
    standCardEntryModel3.dispose();
    standCardEntryModel4.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
