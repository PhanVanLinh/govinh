import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class RedeemUseCase {

  Future<Either<Object, bool>> execute(RedeemInput input) async {

    return TaskEither.tryCatch(() async {
      final dio = Dio();
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