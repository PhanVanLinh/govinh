import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:govinh/data/model/shop.dart';
import 'package:govinh/data/source/remote/service/base_client.dart';
import 'package:govinh/data/source/remote/service/gv_service.dart';

class HomeUseCase {

  BaseClient client = BaseClient();

  Future<Either<Object, List<Shop>>> execute(HomeInput input) async {

    return TaskEither.tryCatch(() async {
      Response response = await client.get(GVService.getShops);
      List<Shop> shops = (response.data['shops'] as List<dynamic>).map((item) => Shop.fromJson(item)).toList();
      return shops;
    }, (error, stackTrade) {
      return error;
    }).run();
  }
}

class HomeInput {

  HomeInput();
}