import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:govinh/feature/sign_up/usecase/sign_up_usecase.dart';

class SignUpAction {}

class SignUpSuccessAction extends SignUpAction {
  final String phoneNumber;

  SignUpSuccessAction({required this.phoneNumber});
}

class SignUpUI {
  final bool isLoading;
  final String? error;
  final SignUpAction? action;

  SignUpUI({required this.isLoading, this.error, this.action});

  SignUpUI copyWith({SignUpAction? action}) {
    return SignUpUI(
      isLoading: isLoading,
      error: error,
      action: action,
    );
  }
}

class SignUpCubit extends Cubit<SignUpUI> {
  SignUpUseCase signUpUseCase = SignUpUseCase();

  SignUpCubit() : super(SignUpUI(isLoading: false));

  void signUp(String phone, String name) async {
    emit(SignUpUI(isLoading: true));
    (await signUpUseCase.execute(SignUpInput(phone: phone, name: name))).fold((error) {
      emit(SignUpUI(isLoading: false, error: error.toString()));
    }, (response) {
      emit(SignUpUI(isLoading: false, action: SignUpSuccessAction(phoneNumber: phone)));
    });
  }
}
