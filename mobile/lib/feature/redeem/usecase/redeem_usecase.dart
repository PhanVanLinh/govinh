import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:govinh/data/source/remote/service/base_client.dart';
import 'package:govinh/data/source/remote/service/gv_service.dart';

class RedeemUseCase {
  BaseClient client = BaseClient();
  
  Future<Either<Object, bool>> execute(RedeemInput input) async {

    return TaskEither.tryCatch(() async {
      Response response = await client.post(GVService.redeem, data: {
        "shop_slug": input.shopSlug,
        "code": input.code,
        "user_phone": input.phoneNumber,
      });
      return true;
    }, (error, stackTrade) {
      return error.toServerException();
    }).run();
  }
}

class RedeemInput {
  final String shopSlug;
  final String phoneNumber;
  final String code;

  RedeemInput({required this.shopSlug, required this.phoneNumber, required this.code});
}