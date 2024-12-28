import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:govinh/data/model/reward.dart';
import 'package:govinh/data/model/shop.dart';
import 'package:govinh/data/source/remote/service/base_client.dart';
import 'package:govinh/data/source/remote/service/gv_service.dart';

class GetRewardsUseCase {
  BaseClient client = BaseClient();

  Future<Either<Object, List<Reward>>> execute(GetRewardsInput input) async {
    // TODO filter rewards by shop
    return TaskEither.tryCatch(() async {
      Response response = await client.get(GVService.getRewards, queryParameters: {
        // "shop_slug": input.shopSlug
      });
      List<Reward> shops = (response.data['rewards'] as List<dynamic>).map((item) => Reward.fromJson(item)).toList();
      return shops;
    }, (error, stackTrade) {
      print(error);
      return error;
    }).run();
  }
}

class GetRewardsInput {

  GetRewardsInput();
}