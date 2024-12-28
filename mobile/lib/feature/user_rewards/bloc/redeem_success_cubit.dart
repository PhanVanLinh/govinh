import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:govinh/data/model/redeem_history.dart';
import 'package:govinh/data/model/reward.dart';
import 'package:govinh/feature/redeem/usecase/get_redeem_history_usecase.dart';
import 'package:govinh/feature/redeem/usecase/get_rewards_use_case.dart';
import 'package:govinh/feature/user_rewards/usecase/get_user_info_usecase.dart';

class RedeemSuccessAction {}

class GoSuccessAction extends RedeemSuccessAction {
  final String phoneNumber;

  GoSuccessAction({required this.phoneNumber});
}

class RedeemSuccessUI {
  final bool isLoading;
  final String? name;
  final String? phoneNumber;
  final int? points;
  final int? earnPoints;
  final String? error;
  final List<Reward>? rewards;
  final List<RedeemHistory>? redeemHistories;
  final RedeemSuccessAction? action;

  RedeemSuccessUI(
      {required this.isLoading,
      this.name,
      this.phoneNumber,
      this.points,
      this.earnPoints,
      this.rewards,
      this.redeemHistories,
      this.error,
      this.action});

  RedeemSuccessUI copyWith({
    bool? isLoading,
    String? name,
    RedeemSuccessAction? action,
    String? phoneNumber,
    int? points,
    int? earnPoints,
    List<Reward>? rewards,
    List<RedeemHistory>? redeemHistories,
  }) {
    return RedeemSuccessUI(
      isLoading: isLoading ?? this.isLoading,
      name: name ?? this.name,
      error: error,
      action: action,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      points: points ?? this.points,
      earnPoints: earnPoints ?? this.earnPoints,
      rewards: rewards ?? this.rewards,
      redeemHistories: redeemHistories ?? this.redeemHistories,
    );
  }
}

class RedeemSuccessCubit extends Cubit<RedeemSuccessUI> {
  GetRewardsUseCase getRewardsUseCase = GetRewardsUseCase();
  GetReemHistoryUseCase getReemHistoryUseCase = GetReemHistoryUseCase();
  GetUserInfoUseCase getUserInfoUseCase = GetUserInfoUseCase();

  RedeemSuccessCubit()
      : super(RedeemSuccessUI(
          isLoading: false,
        ));

  void init(String shopSlug, String phoneNumber) async {
    emit(RedeemSuccessUI(isLoading: false, phoneNumber: phoneNumber));
    (await getUserInfoUseCase.execute(GetUserInfoInput(phoneNumber))).fold((error) {

    }, (user) {
      emit(state.copyWith(
          isLoading: false,
          name: user.name,
          points: user.point
      ));
    });
    (await getReemHistoryUseCase.execute(GetReemHistoryInput(shopSlug, phoneNumber))).fold((error) {

    }, (response) {
      emit(state.copyWith(
          isLoading: false,
          phoneNumber: phoneNumber,
          redeemHistories: response
      ));
    });
    (await getRewardsUseCase.execute(GetRewardsInput())).fold((error) {
    }, (response) {
      emit(state.copyWith(
          isLoading: false,
          phoneNumber: phoneNumber,
          rewards: response
      ));
    });
  }
}
