import 'dart:convert';
import 'dart:io';
import 'data.dart';

main(List<String> args) async {
  var requestServer = await HttpServer.bind("192.168.1.100", 8080);
  print("http服务器已启动");
  //处理起请求，有并发
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
  var aciton = request.uri.queryParameters["action"];
  if (aciton == "getProducts") {
    request.response
      ..statusCode = HttpStatus.ok
      ..write(json.encode(products))
      ..close();
  }
  if (aciton == "news") {
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
