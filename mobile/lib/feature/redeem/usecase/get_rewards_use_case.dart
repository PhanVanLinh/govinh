import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:govinh/data/model/reward.dart';
import 'package:govinh/data/model/shop.dart';

class GetRewardsUseCase {

  Future<Either<Object, List<Reward>>> execute(GetRewardsInput input) async {

    return TaskEither.tryCatch(() async {
      final dio = Dio();
      // Response response = await dio.post('/test', data: {'id': 12, 'name': 'dio'});
      return [Reward(icon: "", title: "ABC", point: 123),Reward(icon: "", title: "DEF", point: 123)];
    }, (error, stackTrade) {
      return error;
    }).run();
  }
}

class GetRewardsInput {

  GetRewardsInput();
}