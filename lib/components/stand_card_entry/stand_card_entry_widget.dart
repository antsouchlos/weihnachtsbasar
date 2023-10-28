import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'stand_card_entry_model.dart';
export 'stand_card_entry_model.dart';

class StandCardEntryWidget extends StatefulWidget {
  const StandCardEntryWidget({Key? key}) : super(key: key);

  @override
  _StandCardEntryWidgetState createState() => _StandCardEntryWidgetState();
}

class _StandCardEntryWidgetState extends State<StandCardEntryWidget> {
  late StandCardEntryModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StandCardEntryModel());

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
      alignment: AlignmentDirectional(0.00, -1.00),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 0.0,
              color: Color(0x33000000),
              offset: Offset(0.0, 1.0),
            )
          ],
        ),
        alignment: AlignmentDirectional(0.00, -1.00),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SelectionArea(
                    child: Text(
                  FFLocalizations.of(context).getText(
                    'p1j4stwb' /* Max Mustermann */,
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        fontSize: 20.0,
                      ),
                )),
                SizedBox(
                  height: 30.0,
                  child: VerticalDivider(
                    thickness: 2.0,
                    color: FlutterFlowTheme.of(context).primaryText,
                  ),
                ),
                SelectionArea(
                    child: Text(
                  FFLocalizations.of(context).getText(
                    'ekhggy4l' /* max.mustermann@gmail.com */,
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        fontSize: 20.0,
                      ),
                )),
                SizedBox(
                  height: 30.0,
                  child: VerticalDivider(
                    thickness: 2.0,
                    color: FlutterFlowTheme.of(context).primaryText,
                  ),
                ),
                SelectionArea(
                    child: Text(
                  FFLocalizations.of(context).getText(
                    'a07l1ucx' /* +49 000 00000000 */,
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        fontSize: 20.0,
                      ),
                )),
                SizedBox(
                  height: 30.0,
                  child: VerticalDivider(
                    thickness: 2.0,
                    color: FlutterFlowTheme.of(context).primaryText,
                  ),
                ),
                SelectionArea(
                    child: Text(
                  FFLocalizations.of(context).getText(
                    '46wdoh7i' /* Freitag 16:30 - 19:30: Aufbau */,
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        fontSize: 20.0,
                      ),
                )),
              ].divide(SizedBox(width: 20.0)),
            ),
          ),
        ),
      ),
    );
  }
}
