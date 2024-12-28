import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:govinh/data/model/user.dart';
import 'package:govinh/data/source/remote/service/base_client.dart';
import 'package:govinh/data/source/remote/service/gv_service.dart';

class GetUserInfoUseCase {
  BaseClient client = BaseClient();

  Future<Either<Object, User>> execute(GetUserInfoInput input) async {

    return TaskEither.tryCatch(() async {
      // TODO apply API
      // Response response = await client.get(GVService.userInfo, queryParameters: {
      //   // "shop_slug": input.shopSlug
      // });
      final jsonString = '{"name": "John Doe", "phone": "+1234567890", "point": 100}';
      final jsonData = jsonDecode(jsonString);
      return User.fromJson(jsonData);
    }, (error, stackTrade) {
      print(error);
      return error;
    }).run();
  }
}

class GetUserInfoInput {
  final String phone;

  GetUserInfoInput(this.phone);
}