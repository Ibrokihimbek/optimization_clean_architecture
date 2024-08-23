// ignore_for_file: avoid_dynamic_calls

import "dart:developer";
import "dart:io";
import "dart:isolate";
import "package:dio/dio.dart";
import "package:http_parser/http_parser.dart";

Future<String> uploadFile(
  File file, {
  required String baseUrl,
  required String token,
  required String shipperId,
}) async =>
    Isolate.run<String>(
      () async {
        try {
          RequestOptions setStreamType<T>(RequestOptions requestOptions) {
            if (T != dynamic &&
                !(requestOptions.responseType == ResponseType.bytes ||
                    requestOptions.responseType == ResponseType.stream)) {
              if (T == String) {
                requestOptions.responseType = ResponseType.plain;
              } else {
                requestOptions.responseType = ResponseType.json;
              }
            }
            return requestOptions;
          }

          final Dio dio = Dio();
          const Map<String, dynamic> extra = <String, dynamic>{};
          final FormData data = FormData();

          final String fileName = file.path.split("/").last;
          final String type = file.path.split(".").last;
          data.files.add(
            MapEntry<String, MultipartFile>(
              "file",
              MultipartFile.fromBytes(file.readAsBytesSync(), filename: fileName, contentType: getMediaType(type)),
            ),
          );
          final Response<Map<String, dynamic>> result = await dio.fetch<Map<String, dynamic>>(
            setStreamType<void>(
              Options(
                method: "POST",
                headers: <String, dynamic>{
                  "Authorization": token,
                  "shipper": shipperId,
                },
                extra: extra,
              )
                  .compose(
                    dio.options,
                    "v2/upload",
                    data: data,
                  )
                  .copyWith(
                    baseUrl: baseUrl,
                  ),
            ),
          );
          if (result.statusCode == 200 || result.statusCode == 201) {
            return result.data?["filename"];
          } else {
            return "";
          }
        } on Exception catch (e, s) {
          log("uploadFile error: $e $s");
          return "";
        }
      },
    );

MediaType getMediaType(String type) => MediaType(
      switch (type) {
        "jpg" => "image",
        "png" => "image",
        "jpeg" => "image",
        "pdf" => "application",
        "mp3" => "audio",
        "m4a" => "audio",
        "mp4" => "video",
        "ogg" => "audio",
        _ => "",
      },
      type,
    );
