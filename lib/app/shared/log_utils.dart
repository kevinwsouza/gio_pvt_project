import 'dart:developer';

import 'package:flutter/foundation.dart';

void successLog(String message, {String? tag, Object? data}) => _safePrint('\x1B[32m\u2714 $message\x1B[0m', tag, data);
void debugLog(String message, {String? tag, Object? data}) => _safePrint('\x1B[33m\u26A0 $message\x1B[0m', tag, data);
void infoLog(String message, {String? tag, Object? data}) => _safePrint('\x1B[36m\u24D8 $message\x1B[0m', tag, data);
void errorLog(String message, {String? tag, Object? data}) => _safePrint('\x1B[31m\u2718 $message\x1B[0m', tag, data);

void completeLog(bool success, String message, {String? tag, Object? data}) =>
    success ? successLog(message, tag: tag) : errorLog(message, tag: tag, data: data);

void _safePrint(Object? o, String? tag, Object? data) {
  if (!kDebugMode) return;
  final message = _getPrefix;
  if (tag != null) message.write("\x1B[35m[$tag] ");
  message.write(o);
  if (data != null) {
    if (data is Map) {
      log(message.toString());
      return data.keys.forEach((key) {
        log("${_getPrefix.toString()}  \u25C6 $key \u25B6 \x1B[37m${data[key]}");
      });
    }
    message.write(" \u25C6 \x1B[37m$data");
  }
  log(message.toString());
}

StringBuffer get _getPrefix => StringBuffer()..write("${DateTime.now()} --\u33D2-- ");
