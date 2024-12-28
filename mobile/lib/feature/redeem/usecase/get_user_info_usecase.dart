import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:govinh/data/model/reward.dart';
import 'package:govinh/data/model/shop.dart';

class GetUserInfoUseCase {

  Future<Either<Object, List<Reward>?>> execute(GetRewardsInput input) async {

    return TaskEither.tryCatch(() async {
      final dio = Dio();
      // Response response = await dio.post('/test', data: {'id': 12, 'name': 'dio'});
      return null;
    }, (error, stackTrade) {
      return error;
    }).run();
  }
}

class GetRewardsInput {

  GetRewardsInput();
}