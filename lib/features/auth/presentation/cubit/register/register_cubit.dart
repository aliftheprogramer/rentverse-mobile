// lib/features/auth/presentation/cubit/register/register_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentverse/core/resources/data_state.dart';
import 'package:rentverse/features/auth/domain/entity/register_request_enity.dart';
import 'package:rentverse/features/auth/domain/usecase/register_usecase.dart';

import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUsecase _registerUseCase;

  RegisterCubit(this._registerUseCase) : super(const RegisterState());

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void toggleConfirmPasswordVisibility() {
    emit(
      state.copyWith(isConfirmPasswordVisible: !state.isConfirmPasswordVisible),
    );
  }

  // METHOD BARU: Update Role
  void updateRole(String role) {
    emit(state.copyWith(role: role));
  }

  // Update Parameter: Hapus 'role' dari parameter karena kita ambil dari State
  Future<void> submitRegister({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
  }) async {
    if (password != confirmPassword) {
      emit(
        state.copyWith(
          status: RegisterStatus.failure,
          errorMessage: "Passwords do not match",
        ),
      );
      return;
    }

    emit(state.copyWith(status: RegisterStatus.loading));

    final result = await _registerUseCase(
      param: RegisterRequestEntity(
        email: email,
        password: password,
        name: name,
        phone: phone,
        role: state.role, // <--- AMBIL DARI STATE
      ),
    );

    if (result is DataSuccess) {
      emit(state.copyWith(status: RegisterStatus.success));
    } else if (result is DataFailed) {
      final errorMsg =
          result.error?.message ??
          result.error?.response?.data['message'] ??
          "Registration Failed";

      emit(
        state.copyWith(status: RegisterStatus.failure, errorMessage: errorMsg),
      );
    }
  }
}
