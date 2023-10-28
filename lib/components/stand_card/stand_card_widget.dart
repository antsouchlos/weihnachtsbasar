import '/components/stand_card_entry/stand_card_entry_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
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
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: AlignmentDirectional(0.00, 0.00),
              child: Container(
                width: 1200.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 10.0, 20.0, 20.0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            'j2fc7dvr' /* Standname */,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Inter',
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          wrapWithModel(
                            model: _model.standCardEntryModel1,
                            updateCallback: () => setState(() {}),
                            child: StandCardEntryWidget(),
                          ),
                          wrapWithModel(
                            model: _model.standCardEntryModel2,
                            updateCallback: () => setState(() {}),
                            child: StandCardEntryWidget(),
                          ),
                          wrapWithModel(
                            model: _model.standCardEntryModel3,
                            updateCallback: () => setState(() {}),
                            child: StandCardEntryWidget(),
                          ),
                          wrapWithModel(
                            model: _model.standCardEntryModel4,
                            updateCallback: () => setState(() {}),
                            child: StandCardEntryWidget(),
                          ),
                        ].divide(SizedBox(height: 2.0)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
