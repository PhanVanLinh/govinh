import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:govinh/data/model/code.dart';
import 'package:govinh/data/model/reward.dart';
import 'package:govinh/data/model/shop.dart';
import 'package:govinh/data/source/remote/service/base_client.dart';
import 'package:govinh/data/source/remote/service/gv_service.dart';

class GetCodesUseCase {
  BaseClient client = BaseClient();

  Future<Either<Object, List<Code>>> execute(GetCodesInput input) async {
    return TaskEither.tryCatch(() async {
      Response response = await client.get(GVService.getCodes, queryParameters: {
        "start": input.start,
        "end": input.end,
        "shop": input.shopId,
        "key": input.adminKey,
      });
      List<Code> shops = (response.data['codes'] as List<dynamic>).map((item) => Code.fromJson(item)).toList();
      return shops;
    }, (error, stackTrade) {
      return error.toServerException();
    }).run();
  }
}

class GetCodesInput {
  final int? start;
  final int? end;
  final String shopId;
  final String adminKey;

  GetCodesInput({required this.start, required this.end, required this.shopId, required this.adminKey});

}