import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:govinh/data/model/redeem_history.dart';
import 'package:govinh/data/source/remote/service/base_client.dart';
import 'package:govinh/data/source/remote/service/gv_service.dart';

class GetReemHistoryUseCase {
  BaseClient client = BaseClient();

  Future<Either<Object, List<RedeemHistory>>> execute(GetReemHistoryInput input) async {
    return TaskEither.tryCatch(() async {
      Response response = await client.get(GVService.userCodes, queryParameters: {
        "phone": input.phone,
        "shop_slug": input.shopSlug
      });
      List<RedeemHistory> shops = (response.data['userCodes'] as List<dynamic>).map((item) => RedeemHistory.fromJson(item)).toList();
      return shops;
    }, (error, stackTrade) {
      print(error);
      return error;
    }).run();
  }
}

class GetReemHistoryInput {
  final String shopSlug;
  final String phone;

  GetReemHistoryInput(this.shopSlug, this.phone);
}