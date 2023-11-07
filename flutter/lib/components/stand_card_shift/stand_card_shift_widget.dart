import '/components/stand_card_entry/stand_card_entry_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'stand_card_shift_model.dart';
export 'stand_card_shift_model.dart';

class StandCardShiftWidget extends StatefulWidget {
  const StandCardShiftWidget({
    Key? key,
    this.shiftText,
  }) : super(key: key);

  final String? shiftText;

  @override
  _StandCardShiftWidgetState createState() => _StandCardShiftWidgetState();
}

class _StandCardShiftWidgetState extends State<StandCardShiftWidget> {
  late StandCardShiftModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StandCardShiftModel());

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

    return Container(
      width: MediaQuery.sizeOf(context).width * 1.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Divider(
            height: 10.0,
            thickness: 2.0,
            indent: 75.0,
            endIndent: 75.0,
            color: FlutterFlowTheme.of(context).primaryText,
          ),
          Container(
            width: MediaQuery.sizeOf(context).width * 1.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primaryBackground,
            ),
            alignment: AlignmentDirectional(0.00, 0.00),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
              child: Wrap(
                spacing: 0.0,
                runSpacing: 0.0,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.horizontal,
                runAlignment: WrapAlignment.center,
                verticalDirection: VerticalDirection.down,
                clipBehavior: Clip.none,
                children: [
                  Text(
                    FFLocalizations.of(context).getText(
                      'ddmyfj1h' /* Freitag 16:30-19:30: Aufbau */,
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Inter',
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Switch.adaptive(
                    value: _model.switchValue ??= true,
                    onChanged: (newValue) async {
                      setState(() => _model.switchValue = newValue!);
                    },
                    activeColor: FlutterFlowTheme.of(context).primary,
                    activeTrackColor: FlutterFlowTheme.of(context).accent1,
                    inactiveTrackColor: FlutterFlowTheme.of(context).alternate,
                    inactiveThumbColor:
                        FlutterFlowTheme.of(context).secondaryText,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
            child: Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryBackground,
              ),
              alignment: AlignmentDirectional(0.00, 0.00),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Builder(
                      builder: (context) {
                        final registration = List.generate(
                            random_data.randomInteger(0, 0),
                            (index) => random_data.randomString(
                                  0,
                                  0,
                                  true,
                                  true,
                                  false,
                                )).toList();
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(registration.length,
                              (registrationIndex) {
                            final registrationItem =
                                registration[registrationIndex];
                            return StandCardEntryWidget(
                              key: Key(
                                  'Keyibb_${registrationIndex}_of_${registration.length}'),
                              name: valueOrDefault<String>(
                                registrationItem,
                                '[name]',
                              ),
                              email: valueOrDefault<String>(
                                registrationItem,
                                '[email]',
                              ),
                              phone: valueOrDefault<String>(
                                registrationItem,
                                '[phone]',
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
