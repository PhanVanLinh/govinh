import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:govinh/data/model/code.dart';
import 'package:govinh/data/model/reward.dart';
import 'package:govinh/data/model/shop.dart';
import 'package:govinh/data/source/remote/service/base_client.dart';
import 'package:govinh/data/source/remote/service/gv_service.dart';

class SignUpUseCase {
  BaseClient client = BaseClient();

  Future<Either<Object, bool>> execute(SignUpInput input) async {
    return TaskEither.tryCatch(() async {
      await client.post(GVService.signUp, data: {
        "phone": input.phone,
        "name": input.name,
      });
      return true;
    }, (error, stackTrade) {
      return error.toServerException();
    }).run();
  }
}

class SignUpInput {
  final String phone;
  final String name;

  SignUpInput({required this.phone, required this.name});

}