import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'stand_card_shift_new_model.dart';
export 'stand_card_shift_new_model.dart';

class StandCardShiftNewWidget extends StatefulWidget {
  const StandCardShiftNewWidget({
    Key? key,
    required this.standname,
    required this.shiftText,
  }) : super(key: key);

  final String? standname;
  final String? shiftText;

  @override
  _StandCardShiftNewWidgetState createState() =>
      _StandCardShiftNewWidgetState();
}

class _StandCardShiftNewWidgetState extends State<StandCardShiftNewWidget> {
  late StandCardShiftNewModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StandCardShiftNewModel());

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

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Divider(
          height: 10.0,
          thickness: 2.0,
          color: FlutterFlowTheme.of(context).primaryText,
        ),
        Wrap(
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
              widget.shiftText!,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Inter',
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            FutureBuilder<ApiCallResponse>(
              future: _model.getRegistrationStatus(
                requestFn: () => GetRegistrationStatusCall.call(
                  standname: widget.standname,
                  shiftText: widget.shiftText,
                  authString: functions.getAuthHeaderContent(
                      FFAppState().username, FFAppState().password),
                ),
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
                final switchGetRegistrationStatusResponse = snapshot.data!;
                return Switch.adaptive(
                  value: _model.switchValue ??=
                      GetRegistrationStatusCall.status(
                            switchGetRegistrationStatusResponse.jsonBody,
                          ).toString() ==
                          'open',
                  onChanged: (newValue) async {
                    setState(() => _model.switchValue = newValue!);
                    if (newValue!) {
                      _model.apiResultqy1 =
                          await SetRegistrationStatusCall.call(
                        status: true,
                        standname: widget.standname,
                        shiftText: widget.shiftText,
                        authString: functions.getAuthHeaderContent(
                            FFAppState().username, FFAppState().password),
                      );
                      if (!(_model.apiResultqy1?.succeeded ?? true)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'An error occurred',
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                            duration: Duration(milliseconds: 4000),
                            backgroundColor: FlutterFlowTheme.of(context).error,
                          ),
                        );
                      }

                      setState(() {});
                    } else {
                      _model.apiResultjho =
                          await SetRegistrationStatusCall.call(
                        status: false,
                        standname: widget.standname,
                        shiftText: widget.shiftText,
                        authString: functions.getAuthHeaderContent(
                            FFAppState().username, FFAppState().password),
                      );
                      if (!(_model.apiResultjho?.succeeded ?? true)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'An error occurred',
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                            duration: Duration(milliseconds: 4000),
                            backgroundColor: FlutterFlowTheme.of(context).error,
                          ),
                        );
                      }

                      setState(() {});
                    }
                  },
                  activeColor: FlutterFlowTheme.of(context).primary,
                  activeTrackColor: FlutterFlowTheme.of(context).accent1,
                  inactiveTrackColor: FlutterFlowTheme.of(context).alternate,
                  inactiveThumbColor:
                      FlutterFlowTheme.of(context).secondaryText,
                );
              },
            ),
          ],
        ),
        FutureBuilder<ApiCallResponse>(
          future: _model.getRegistrations(
            requestFn: () => GetRegistrationsCall.call(
              standname: widget.standname,
              shiftText: widget.shiftText,
              authString: functions.getAuthHeaderContent(
                  FFAppState().username, FFAppState().password),
            ),
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
            final registrationColumnGetRegistrationsResponse = snapshot.data!;
            return Builder(
              builder: (context) {
                final registrationList =
                    registrationColumnGetRegistrationsResponse.jsonBody
                        .toList();
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: List.generate(registrationList.length,
                      (registrationListIndex) {
                    final registrationListItem =
                        registrationList[registrationListIndex];
                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: AlignmentDirectional(0.00, 0.00),
                            child: Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SelectionArea(
                                        child: Text(
                                      getJsonField(
                                        registrationListItem,
                                        r'''$['name']''',
                                      ).toString(),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            fontSize: 16.0,
                                          ),
                                    )),
                                    SizedBox(
                                      height: 20.0,
                                      child: VerticalDivider(
                                        thickness: 2.0,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                      ),
                                    ),
                                    SelectionArea(
                                        child: Text(
                                      getJsonField(
                                        registrationListItem,
                                        r'''$['email']''',
                                      ).toString(),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            fontSize: 16.0,
                                          ),
                                    )),
                                    SizedBox(
                                      height: 20.0,
                                      child: VerticalDivider(
                                        thickness: 2.0,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                      ),
                                    ),
                                    SelectionArea(
                                        child: Text(
                                      getJsonField(
                                        registrationListItem,
                                        r'''$['phone']''',
                                      ).toString(),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            fontSize: 16.0,
                                          ),
                                    )),
                                  ].divide(SizedBox(width: 5.0)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              10.0, 10.0, 10.0, 10.0),
                          child: FlutterFlowIconButton(
                            borderColor: FlutterFlowTheme.of(context).primary,
                            borderRadius: 20.0,
                            borderWidth: 1.0,
                            buttonSize: 40.0,
                            fillColor: FlutterFlowTheme.of(context).accent1,
                            icon: Icon(
                              Icons.delete,
                              color: FlutterFlowTheme.of(context).error,
                              size: 24.0,
                            ),
                            onPressed: () async {
                              var confirmDialogResponse =
                                  await showDialog<bool>(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: Text('Delete Registration'),
                                            content: Text(
                                                'This action cannot be undone. Are you sure you want to continue?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, false),
                                                child: Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, true),
                                                child: Text('Confirm'),
                                              ),
                                            ],
                                          );
                                        },
                                      ) ??
                                      false;
                              if (confirmDialogResponse) {
                                _model.apiResultkb3 =
                                    await DeleteRegistrationCall.call(
                                  standname: widget.standname,
                                  shiftText: widget.shiftText,
                                  email: getJsonField(
                                    registrationListItem,
                                    r'''$['email']''',
                                  ).toString(),
                                  authString: functions.getAuthHeaderContent(
                                      FFAppState().username,
                                      FFAppState().password),
                                );
                                if (!(_model.apiResultkb3?.succeeded ?? true)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'An error occurred',
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                        ),
                                      ),
                                      duration: Duration(milliseconds: 4000),
                                      backgroundColor:
                                          FlutterFlowTheme.of(context).error,
                                    ),
                                  );
                                }
                              }
                              _model.clearGetRegistrationsCache();

                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    );
                  }),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
