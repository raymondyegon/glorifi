import 'dart:convert';

List<int> numbersFromJson(String str) =>
    List<int>.from(json.decode(str).map((x) => x));

String numbersToJson(List<int> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x)));
