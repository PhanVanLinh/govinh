import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:govinh/data/model/shop.dart';

class HomeUseCase {

  Future<Either<Object, List<Shop>>> execute(HomeInput input) async {

    return TaskEither.tryCatch(() async {
      final dio = Dio();
      // Response response = await dio.post('/test', data: {'id': 12, 'name': 'dio'});
      return [Shop(name: "Banh canh", link: "/redeem/123")];
    }, (error, stackTrade) {
      return error;
    }).run();
  }
}

class HomeInput {

  HomeInput();
}