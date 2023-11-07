import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'stand_card_shift_new_model.dart';
export 'stand_card_shift_new_model.dart';

class StandCardShiftNewWidget extends StatefulWidget {
  const StandCardShiftNewWidget({
    super.key,
    this.parameter1,
  });

  final dynamic parameter1;

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
          indent: 75.0,
          endIndent: 75.0,
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
              widget.parameter1!.toString(),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Inter',
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Switch.adaptive(
              value: _model.switchValue ??= true,
              onChanged: (newValue) async {
                setState(() => _model.switchValue = newValue);
              },
              activeColor: FlutterFlowTheme.of(context).primary,
              activeTrackColor: FlutterFlowTheme.of(context).accent1,
              inactiveTrackColor: FlutterFlowTheme.of(context).alternate,
              inactiveThumbColor: FlutterFlowTheme.of(context).secondaryText,
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
          child: Align(
            alignment: const AlignmentDirectional(0.00, 0.00),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Builder(
                    builder: (context) {
                      final namesList = List.generate(
                              random_data.randomInteger(5, 0),
                              (index) => random_data.randomName(true, true))
                          .toList();
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        children:
                            List.generate(namesList.length, (namesListIndex) {
                          final namesListItem = namesList[namesListIndex];
                          return Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                namesListItem,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      fontSize: 16.0,
                                    ),
                              ),
                              SizedBox(
                                height: 20.0,
                                child: VerticalDivider(
                                  thickness: 2.0,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                              ),
                              Text(
                                FFLocalizations.of(context).getText(
                                  '013io14o' /* Email */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      fontSize: 16.0,
                                    ),
                              ),
                              SizedBox(
                                height: 20.0,
                                child: VerticalDivider(
                                  thickness: 2.0,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                              ),
                              Text(
                                FFLocalizations.of(context).getText(
                                  'onmb2g1s' /* Phone */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      fontSize: 16.0,
                                    ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    10.0, 5.0, 0.0, 5.0),
                                child: FlutterFlowIconButton(
                                  borderColor:
                                      FlutterFlowTheme.of(context).primary,
                                  borderRadius: 20.0,
                                  borderWidth: 1.0,
                                  buttonSize: 40.0,
                                  fillColor:
                                      FlutterFlowTheme.of(context).accent1,
                                  icon: Icon(
                                    Icons.delete,
                                    color: FlutterFlowTheme.of(context).error,
                                    size: 24.0,
                                  ),
                                  onPressed: () {
                                    print('IconButton pressed ...');
                                  },
                                ),
                              ),
                            ].divide(const SizedBox(width: 5.0)),
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
    );
  }
}
