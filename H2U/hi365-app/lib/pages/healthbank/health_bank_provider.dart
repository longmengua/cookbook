import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:hi365/pages/healthbank/healthbank_master_page.dart';
import 'package:hi365/utils/api_provider.dart';

class HealthBankProvider extends ApiProvider {
  final AsyncMemoizer _memoizer = AsyncMemoizer();

  Future<Response> uploadMHB(Map data) async {
    Options options = Options(
      receiveTimeout: 300000,
      // connectTimeout: 100000,
      // contentType: ContentType.json,
      followRedirects: false,
      validateStatus: (status) {
        return status < 500;
      },
    );

    var date = new DateTime.now();
    String timestamp =
        "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}T${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}:${date.second.toString().padLeft(2, '0')}+08:00";
    var formData = new Map<String, dynamic>();
    formData["applyDate"] = timestamp;
    formData["fileContent"] = data['content'];
    formData["name"] = data['fileName'];
    var body = json.encode(formData);
    return await client.post('/resource/api/user/healthBankFile/10',
        data: body, options: options);
  }

  Future<List<HealthBankMaster>> fetchHealthBank() async {
    Options options = Options(
      receiveTimeout: 200000,
      // connectTimeout: 5000,
      // contentType: ContentType.json,
    );

    return await client
        .get('/resource/api/user/healthBankMaster/full', options: options)
        .then((Response<dynamic> response) {
      HealthBankMasterPage page = HealthBankMasterPage.fromJson(response.data);
      return page.data.where((f) => f.type != 'M011').toList();
    });
  }

//  Future<List<HealthBankMaster>> fetchHealthBank() {
//    Options options = Options(
//      receiveTimeout: 200000,
//      connectTimeout: 5000,
//      contentType: ContentType.json,
//    );
//    return this._memoizer.runOnce(() async {
//      return await client
//          .get('/resource/api/user/healthBankMaster/full', options: options)
//          .then((Response<dynamic> response) {
//        HealthBankMasterPage page =
//            HealthBankMasterPage.fromJson(response.data);
//        //List<HealthBankMaster> list = new List();
//        //list.addAll(page.data);
//        //return list;
//        return page.data;
//      });
//    });
//  }

  Future<int> countMasterFile() async {
    return await client
        .get('/resource/api/user/healthBankFile/count/10')
        .then((Response<dynamic> response) => response.data);
  }
}
