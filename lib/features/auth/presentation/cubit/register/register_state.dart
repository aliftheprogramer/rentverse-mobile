// lib/features/auth/presentation/cubit/register/register_state.dart
import 'package:equatable/equatable.dart';

enum RegisterStatus { initial, loading, success, failure }

class RegisterState extends Equatable {
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final RegisterStatus status;
  final String? errorMessage;
  final String role; // <--- Properti Baru untuk Role

  const RegisterState({
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.status = RegisterStatus.initial,
    this.errorMessage,
    this.role = "TENANT", // Default Value
  });

  RegisterState copyWith({
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    RegisterStatus? status,
    String? errorMessage,
    String? role, // <--- Add CopyWith
  }) {
    return RegisterState(
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible:
          isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      role: role ?? this.role,
    );
  }

  @override
  List<Object?> get props => [
    isPasswordVisible,
    isConfirmPasswordVisible,
    status,
    errorMessage,
    role,
  ];
}
