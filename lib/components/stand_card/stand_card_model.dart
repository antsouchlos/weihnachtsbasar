import '/components/stand_card_shift/stand_card_shift_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'stand_card_widget.dart' show StandCardWidget;
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class StandCardModel extends FlutterFlowModel<StandCardWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for Expandable widget.
  late ExpandableController expandableController;

  // Model for StandCardShift component.
  late StandCardShiftModel standCardShiftModel1;
  // Model for StandCardShift component.
  late StandCardShiftModel standCardShiftModel2;
  // Model for StandCardShift component.
  late StandCardShiftModel standCardShiftModel3;
  // Model for StandCardShift component.
  late StandCardShiftModel standCardShiftModel4;
  // Model for StandCardShift component.
  late StandCardShiftModel standCardShiftModel5;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    standCardShiftModel1 = createModel(context, () => StandCardShiftModel());
    standCardShiftModel2 = createModel(context, () => StandCardShiftModel());
    standCardShiftModel3 = createModel(context, () => StandCardShiftModel());
    standCardShiftModel4 = createModel(context, () => StandCardShiftModel());
    standCardShiftModel5 = createModel(context, () => StandCardShiftModel());
  }

  void dispose() {
    expandableController.dispose();
    standCardShiftModel1.dispose();
    standCardShiftModel2.dispose();
    standCardShiftModel3.dispose();
    standCardShiftModel4.dispose();
    standCardShiftModel5.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
