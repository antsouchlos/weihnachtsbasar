import '/backend/api_requests/api_calls.dart';
import '/components/stand_card_shift_new/stand_card_shift_new_widget.dart';
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
  const StandCardWidget({
    Key? key,
    required this.standName,
  }) : super(key: key);

  final String? standName;

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

    _model.expandableController = ExpandableController(initialExpanded: false);
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Align(
      alignment: AlignmentDirectional(0.00, 0.00),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 20.0),
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
                        widget.standName!,
                        style:
                            FlutterFlowTheme.of(context).displaySmall.override(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.black,
                                  fontSize: 20.0,
                                ),
                      ),
                    ),
                  ),
                  collapsed: Container(),
                  expanded: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 15.0, 15.0),
                    child: FutureBuilder<ApiCallResponse>(
                      future: FFAppState().getShifts(
                        requestFn: () => GetShiftsCall.call(),
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  FlutterFlowTheme.of(context).primary,
                                ),
                              ),
                            ),
                          );
                        }
                        final columnGetShiftsResponse = snapshot.data!;
                        return Builder(
                          builder: (context) {
                            final shiftList = (GetShiftsCall.shiftTextListDE(
                                  columnGetShiftsResponse.jsonBody,
                                ) as List)
                                    .map<String>((s) => s.toString())
                                    .toList()
                                    ?.toList() ??
                                [];
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: List.generate(shiftList.length,
                                  (shiftListIndex) {
                                final shiftListItem = shiftList[shiftListIndex];
                                return Align(
                                  alignment: AlignmentDirectional(0.00, 0.00),
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.8,
                                    constraints: BoxConstraints(
                                      maxWidth: 960.0,
                                    ),
                                    decoration: BoxDecoration(),
                                    child: StandCardShiftNewWidget(
                                      key: Key(
                                          'Keyo6t_${shiftListIndex}_of_${shiftList.length}'),
                                      standname: widget.standName!,
                                      shiftText: shiftListItem,
                                    ),
                                  ),
                                );
                              }),
                            );
                          },
                        );
                      },
                    ),
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
