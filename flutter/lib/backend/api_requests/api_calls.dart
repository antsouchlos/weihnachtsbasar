import 'dart:convert';
import 'dart:typed_data';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class GetShiftsCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get shifts',
      apiUrl: 'http://weihnachtsbasar-athen-anmeldung.com:5000/api/v2/shifts',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic shiftTextListDE(dynamic response) => getJsonField(
        response,
        r'''$[:]['text_de']''',
        true,
      );
  static dynamic shiftTextListGR(dynamic response) => getJsonField(
        response,
        r'''$[:]['text_gr']''',
        true,
      );
  static dynamic shiftIdList(dynamic response) => getJsonField(
        response,
        r'''$[:]['shift_id']''',
        true,
      );
}

class GetStandsCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get stands',
      apiUrl: 'http://weihnachtsbasar-athen-anmeldung.com:5000/api/v2/stands',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic standNameListDE(dynamic response) => getJsonField(
        response,
        r'''$[:]['standname_de']''',
        true,
      );
  static dynamic standNameListGR(dynamic response) => getJsonField(
        response,
        r'''$[:]['standname_gr']''',
        true,
      );
  static dynamic standSlugList(dynamic response) => getJsonField(
        response,
        r'''$[:]['stand_slug']''',
        true,
      );
}

class AddShiftCall {
  static Future<ApiCallResponse> call({
    String? textDe = '',
    String? textGr = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Add shift',
      apiUrl: 'http://weihnachtsbasar-athen-anmeldung.com:5000/api/v2/shifts',
      callType: ApiCallType.POST,
      headers: {
        'Content-type': 'application/x-www-form-urlencoded',
      },
      params: {
        'text_de': textDe,
        'text_gr': textGr,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class RemoveShiftCall {
  static Future<ApiCallResponse> call({
    int? shiftId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Remove shift',
      apiUrl:
          'http://weihnachtsbasar-athen-anmeldung.com:5000/api/v2/shifts/${shiftId}',
      callType: ApiCallType.DELETE,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class AddStandCall {
  static Future<ApiCallResponse> call({
    String? stannameDe = '',
    String? standnameGr = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Add stand',
      apiUrl: 'http://weihnachtsbasar-athen-anmeldung.com:5000/api/v2/stands',
      callType: ApiCallType.POST,
      headers: {
        'Content-type': 'application/x-www-form-urlencoded',
      },
      params: {
        'standname_de': stannameDe,
        'standname_gr': standnameGr,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class RemoveStandCall {
  static Future<ApiCallResponse> call({
    String? standSlug = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Remove stand',
      apiUrl:
          'http://weihnachtsbasar-athen-anmeldung.com:5000/api/v2/stands/${standSlug}',
      callType: ApiCallType.DELETE,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class AddRegistrationCall {
  static Future<ApiCallResponse> call({
    String? name = '',
    String? email = '',
    String? phone = '',
    String? standname = '',
    String? shiftText = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Add registration',
      apiUrl:
          'http://weihnachtsbasar-athen-anmeldung.com:5000/api/v2/registrations',
      callType: ApiCallType.POST,
      headers: {
        'Content-type': 'application/x-www-form-urlencoded',
      },
      params: {
        'name': name,
        'email': email,
        'phone': phone,
        'standname': standname,
        'shift_text': shiftText,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class DeleteRegistrationCall {
  static Future<ApiCallResponse> call({
    String? standname = '',
    String? shiftText = '',
    String? email = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Delete registration',
      apiUrl:
          'http://weihnachtsbasar-athen-anmeldung.com:5000/api/v2/registrations/${standname}/${shiftText}/${email}',
      callType: ApiCallType.DELETE,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class GetRegistrationsCall {
  static Future<ApiCallResponse> call({
    String? standname = '',
    String? shiftText = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get registrations',
      apiUrl:
          'http://weihnachtsbasar-athen-anmeldung.com:5000/api/v2/registrations/${standname}/${shiftText}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class GetShiftsForStandCall {
  static Future<ApiCallResponse> call({
    String? standname = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get shifts for stand',
      apiUrl:
          'http://weihnachtsbasar-athen-anmeldung.com:5000/api/v2/shifts/${standname}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic shiftTextDE(dynamic response) => getJsonField(
        response,
        r'''$[:]['text_de']''',
        true,
      );
  static dynamic shiftTextGR(dynamic response) => getJsonField(
        response,
        r'''$[:]['text_gr']''',
        true,
      );
}

class DownloadRegistrationsCall {
  static Future<ApiCallResponse> call({
    String? stand = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Download registrations',
      apiUrl:
          'http://weihnachtsbasar-athen-anmeldung.com:5000/api/v2/registrations/download/${stand}',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return isList ? '[]' : '{}';
  }
}
