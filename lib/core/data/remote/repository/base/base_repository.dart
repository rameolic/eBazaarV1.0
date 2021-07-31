import 'dart:io';

import 'package:thought_factory/core/data/remote/network/network_provider.dart';

class BaseRepository {
  final networkProvider = NetworkProvider();
  final headerAccept = {
    HttpHeaders.acceptHeader: "application/json",
  };
  final headerContentTypeAndAcceptPayment = {
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.acceptHeader: "application/json",

  };
  final headerContentTypeAndAccept = {
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.acceptHeader: "application/json"
  };
  final Map<String, String> mapAuthHeader = {
    HttpHeaders.authorizationHeader: 'Bearer nhl8gwc8vtee0bookm2vbkw31enngxhj'
  };

  Map<String, String> buildDefaultHeaderWithToken(String token) {
    Map<String, String> header = headerContentTypeAndAccept;
    header.remove(HttpHeaders.authorizationHeader);
    header.putIfAbsent(HttpHeaders.authorizationHeader, () => getFormattedToken(token));
    return header;
  }

  Map<String, String> buildDefaultHeaderWithXRequest() {
    Map<String, String> header = headerContentTypeAndAccept;
    header.remove(HttpHeaders.authorizationHeader);
    header.putIfAbsent("X-Requested-With", () => getHeaderValue("XMLHttpRequest"));
    return header;
  }

  Map<String, String> buildDefaultHeaderWithTokenCookie(String token, String cookieId) {
    Map<String, String> header = headerContentTypeAndAccept;
    header.remove(HttpHeaders.authorizationHeader);
    header.remove(HttpHeaders.cookieHeader);
    header.putIfAbsent(HttpHeaders.authorizationHeader, () => getFormattedToken(token));
    header.putIfAbsent(HttpHeaders.cookieHeader, () => getCookie(cookieId));
    print("header mowa:$header");
    return header;
  }

  Map<String, String> buildOnlyHeaderWithToken(String token) {
    Map<String, String> header = {};
    header.remove(HttpHeaders.authorizationHeader);
    header.putIfAbsent(HttpHeaders.authorizationHeader, () => getFormattedToken(token));
    return header;
  }

  Map<String, String> buildHeaderWithAdminToken({String adminToken}) {
    Map<String, String> header = headerContentTypeAndAccept;
    header.remove(HttpHeaders.authorizationHeader);
    header.putIfAbsent(HttpHeaders.authorizationHeader, () => getFormattedToken(adminToken));
    return header;
  }

  String getFormattedToken(String token) {
    return 'Bearer $token';
  }

  String getCookie(String cookieId) {
    return cookieId;
  }

  String getHeaderValue(String s) {
    return s;
  }
}
