import 'dart:convert';
import 'dart:io';
import 'data.dart';

/**
 * 请求地址：
 * http://192.168.1.100:8080?action=getProducts
 * http://192.168.1.100:8080?action=news
 */

main(List<String> args) async {
  var requestServer = await HttpServer.bind("192.168.1.100", 8080);
  print("http服务器已启动");
  await for (HttpRequest request in requestServer) {
    handleMessage(request);
  }
}

void handleMessage(HttpRequest request) {
  try {
    if (request.method == "GET") {
      handleGET(request);
    } else if (request.method == "POST") {
      handleGET(request);
    }
  } catch (e) {
    print("异常");
  }
}

void handleGET(HttpRequest request) {
  print("request.uri = ${request.uri}");
  var action = request.uri.queryParameters["action"];
  if (action == "getProducts") {
    var page = request.uri.queryParameters["page"];
    print("第${page}也数据" + json.encode(page));
    request.response
      ..statusCode = HttpStatus.ok
      ..write(json.encode(products))
      ..close();
  }
  if (action == "news") {
    request.response
      ..statusCode = HttpStatus.ok
      ..write(json.encode(news))
      ..close();
  }
}

void handlePOST(HttpRequest request) {
  request.response
    ..write("request success ......")
    ..close();
}
