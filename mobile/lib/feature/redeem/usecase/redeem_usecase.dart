import 'package:fpdart/fpdart.dart';
import 'package:govinh/data/source/remote/service/base_client.dart';

class RedeemUseCase {
  BaseClient client = BaseClient();
  
  Future<Either<Object, bool>> execute(RedeemInput input) async {

    return TaskEither.tryCatch(() async {
      client.post("api/user-codes/", data: {});
      // Response response = await dio.post('/test', data: {'id': 12, 'name': 'dio'});
      await Future.delayed(Duration(seconds: 2));
      return true;
    }, (error, stackTrade) {
      return error;
    }).run();
  }
}

class RedeemInput {
  final String phoneNumber;
  final String code;

  RedeemInput({required this.phoneNumber, required this.code});
}