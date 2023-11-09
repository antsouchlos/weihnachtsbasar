// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

/*
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
*/

import 'package:dio/dio.dart';
import 'package:mime_type/mime_type.dart';
import 'dart:html' as html;

Future downloadAnyWebFile(String? url) async {
  Dio dio = Dio();
  try {
    // Fetch the file
    Response response =
        await dio.get(url!, options: Options(responseType: ResponseType.bytes));

    // Generate a unique file name
    String? ext = (url!.split(".").last);
    String? extension = (ext.split("?").first);
    String fileName =
        'downloaded_file_${DateTime.now().millisecondsSinceEpoch.toString()}.$extension';

    // Create a download link
    final anchor = html.AnchorElement(
        href: html.Url.createObjectUrlFromBlob(html.Blob([response.data])));
    anchor.download = fileName;
    anchor.style.display = 'none';

    // Append the link to the body
    html.document.body!.children.add(anchor);

    // Trigger a click on the link
    anchor.click();

    // Remove the link from the body
    html.document.body!.children.remove(anchor);

    print('File downloaded');
  } catch (e) {
    print('Error downloading file: $e');
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
