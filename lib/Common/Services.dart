import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_jini_adminapp/Common/Constant.dart';
import 'package:xml2json/xml2json.dart';

import 'Classlist.dart';

Dio dio = new Dio();
Xml2Json xml2json = new Xml2Json();

class Services {
  static Future<ResponseDataClass> responseHandler(
      {@required apiName, body}) async {
    String url = API_URL + "$apiName";
    var header = Options(
      headers: {
        "authorization": "$Access_Token" // set content-length
      },
    );
    var response;
    try {
      if (body == null) {
        response = await dio.post(url, options: header);
      } else {
        response = await dio.post(url, data: body, options: header);
      }
      if (response.statusCode == 200) {
        ResponseDataClass responseData = new ResponseDataClass(
            Message: "No Data", IsSuccess: false, Data: "");
        var data = response.data;
        responseData.Message = data["Message"];
        responseData.IsSuccess = data["IsSuccess"];
        responseData.Data = data["Data"];

        return responseData;
      } else {
        print("error ->" + response.data.toString());
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("Catch error -> ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  static Future<List<stateClass>> GetState() async {
    String url = API_URL + "GetStates";
    print("GetState url = " + url);
    try {
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        List<stateClass> list = [];
        print("GetState Response: " + response.data.toString());
        var responseData = response.data;
        if (responseData["IsSuccess"] == true) {
          final jsonResponse = response.data;
          stateClassData stateclassdata =
              new stateClassData.fromJson(jsonResponse);

          list = stateclassdata.data;

          return list;
        }
      }
    } catch (e) {
      print("GetState error" + e);
      throw Exception(e);
    }
  }

  static Future<List<cityClass>> GetCity(String stateId) async {
    String url = API_URL + "GetCity?StateId=$stateId";
    print("GetCity url = " + url);
    try {
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        List<cityClass> list = [];
        print("GetCity Response: " + response.data.toString());
        var responseData = response.data;
        if (responseData["IsSuccess"] == true) {
          final jsonResponse = response.data;
          cityClassData cityclassdata =
              new cityClassData.fromJson(jsonResponse);
          list = cityclassdata.data;

          return list;
        }
      }
    } catch (e) {
      print("GetCity error" + e);
      throw Exception(e);
    }
  }

  static Future<List> GetWingData(String SocietyId) async {
    String url = API_URL + 'GetMemberCountByWingId?societyId=$SocietyId';
    print("GetWingData url : " + url);
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        List list = [];
        print("GetWingData Response: " + response.data.toString());
        var responseData = response.data;
        if (responseData["IsSuccess"] == true) {
          list = responseData["Data"];
        } else {
          list = [];
        }
        return list;
      } else {
        print("Error GetWingData");
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("Error GetWingData   : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  static Future<List> GetFamilyMember(String parentId, String MemberId) async {
    String url =
        API_URL + 'GetFamilyMember?parentId=$parentId&memberId=$MemberId';
    print("FamilyMemberData url : " + url);
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        List list = [];
        print("FamilyMemberData Response: " + response.data.toString());
        var responseData = response.data;
        if (responseData["IsSuccess"] == true) {
          list = responseData["Data"];
        } else {
          list = [];
        }
        return list;
      } else {
        print("Error FamilyMemberData");
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("Error FamilyMemberData   : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  static Future<List> GetVehicleData(String MemberId) async {
    String url = API_URL + 'GetMemberVehicleDetail?memberId=$MemberId';
    print("VehicleData url : " + url);
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        List list = [];
        print("VehicleData Response: " + response.data.toString());
        var responseData = response.data;
        if (responseData["IsSuccess"] == true) {
          list = responseData["Data"];
        } else {
          list = [];
        }
        return list;
      } else {
        print("Error VehicleData");
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("Error VehicleData   : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  static Future<String> GetVcardofMember(String MemberId) async {
    String url = API_URL + 'VcfFile?memberId=$MemberId';
    print("Vcard url : " + url);
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        String Vcard = "";
        print("Vcard Response: " + response.data.toString());
        var VisitorData = response.data;
        if (VisitorData["IsSuccess"] == true) {
          Vcard = VisitorData["Data"];
        } else {
          Vcard = "";
        }
        return Vcard;
      } else {
        print("Error Vcard");
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("Error Vcard   : ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  static Future<List> GetMemberByWing(String SocietyId, String WingId) async {
    String url =
        API_URL + 'GetMemberByWing?societyId=$SocietyId&wingId=$WingId';
    print("GetMemberByWing url : " + url);
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        List list = [];
        print("GetMemberByWing Response: " + response.data.toString());
        var RulesData = response.data;
        if (RulesData["IsSuccess"] == true) {
          list = RulesData["Data"];
        } else {
          list = [];
        }
        return list;
      } else {
        print("Error GetMemberByWing");
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("Error GetMemberByWing   : ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
