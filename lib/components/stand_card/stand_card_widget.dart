import '/components/stand_card_shift/stand_card_shift_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'stand_card_model.dart';
export 'stand_card_model.dart';

class StandCardWidget extends StatefulWidget {
  const StandCardWidget({Key? key}) : super(key: key);

  @override
  _StandCardWidgetState createState() => _StandCardWidgetState();
}

class _StandCardWidgetState extends State<StandCardWidget> {
  late StandCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StandCardModel());

    _model.expandableController = ExpandableController(initialExpanded: true);
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.00, 0.00),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 1200.0,
          ),
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).primaryBackground,
          ),
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: FlutterFlowTheme.of(context).secondaryBackground,
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: ExpandableNotifier(
                controller: _model.expandableController,
                child: ExpandablePanel(
                  header: Align(
                    alignment: AlignmentDirectional(0.00, 0.00),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          20.0, 20.0, 20.0, 20.0),
                      child: Text(
                        FFLocalizations.of(context).getText(
                          '9zqlime7' /* Standname */,
                        ),
                        style:
                            FlutterFlowTheme.of(context).displaySmall.override(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.black,
                                ),
                      ),
                    ),
                  ),
                  collapsed: Container(),
                  expanded: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      wrapWithModel(
                        model: _model.standCardShiftModel1,
                        updateCallback: () => setState(() {}),
                        child: StandCardShiftWidget(),
                      ),
                      wrapWithModel(
                        model: _model.standCardShiftModel2,
                        updateCallback: () => setState(() {}),
                        child: StandCardShiftWidget(),
                      ),
                      wrapWithModel(
                        model: _model.standCardShiftModel3,
                        updateCallback: () => setState(() {}),
                        child: StandCardShiftWidget(),
                      ),
                      wrapWithModel(
                        model: _model.standCardShiftModel4,
                        updateCallback: () => setState(() {}),
                        child: StandCardShiftWidget(),
                      ),
                      wrapWithModel(
                        model: _model.standCardShiftModel5,
                        updateCallback: () => setState(() {}),
                        child: StandCardShiftWidget(),
                      ),
                    ],
                  ),
                  theme: ExpandableThemeData(
                    tapHeaderToExpand: true,
                    tapBodyToExpand: false,
                    tapBodyToCollapse: false,
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    hasIcon: true,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
