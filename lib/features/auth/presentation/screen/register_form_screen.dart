import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../common/colors/custom_color.dart';
import '../cubit/auth/auth_page_cubit.dart';
import '../cubit/register/register_cubit.dart';
import '../cubit/register/register_state.dart';
import '../widget/custom_button.dart';
import '../widget/custom_text_field.dart'; // Import Widget Baru
import 'choose_role_screen.dart';
import '../cubit/choose_role/state.dart';

class RegisterFormScreen extends StatelessWidget {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  RegisterFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Helper kecil untuk Label agar tetap rapi
    Widget label(String text) => Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          color: const Color(0xFF225555),
        ),
      ),
    );

    // role is selected on ChooseRoleScreen

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Text(
              "Register your account now",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),

            // --- FULL NAME ---
            label("Full Name"),
            CustomTextField(
              controller: _nameController,
              hintText: "Enter your Full Name",
            ),

            // --- EMAIL ---
            label("Email"),
            CustomTextField(
              controller: _emailController,
              hintText: "Enter your email address",
              keyboardType: TextInputType.emailAddress,
            ),

            // --- PHONE ---
            label("Phone Number"),
            CustomTextField(
              controller: _phoneController,
              hintText: "Enter your phone number (e.g. 0812...)",
              keyboardType: TextInputType.phone,
            ),

            // --- ROLE SELECTION REMOVED: will be chosen on next screen ---

            // --- PASSWORD ---
            label("Password"),
            BlocBuilder<RegisterCubit, RegisterState>(
              builder: (context, state) {
                return CustomTextField(
                  controller: _passwordController,
                  hintText: "Enter your password",
                  obscureText: !state.isPasswordVisible,
                  suffixIcon: IconButton(
                    icon: Icon(
                      state.isPasswordVisible
                          ? LucideIcons.eye
                          : LucideIcons.eyeOff,
                      color: const Color(0xFF225555),
                    ),
                    onPressed: () => context
                        .read<RegisterCubit>()
                        .togglePasswordVisibility(),
                  ),
                );
              },
            ),

            // --- CONFIRM PASSWORD ---
            label("Confirm Password"),
            BlocBuilder<RegisterCubit, RegisterState>(
              builder: (context, state) {
                return CustomTextField(
                  controller: _confirmPasswordController,
                  hintText: "Re-enter your password",
                  obscureText: !state.isConfirmPasswordVisible,
                  suffixIcon: IconButton(
                    icon: Icon(
                      state.isConfirmPasswordVisible
                          ? LucideIcons.eye
                          : LucideIcons.eyeOff,
                      color: const Color(0xFF225555),
                    ),
                    onPressed: () => context
                        .read<RegisterCubit>()
                        .toggleConfirmPasswordVisibility(),
                  ),
                );
              },
            ),

            const SizedBox(height: 40),

            // --- NEXT BUTTON ---
            BlocConsumer<RegisterCubit, RegisterState>(
              listener: (context, state) {
                if (state.status == RegisterStatus.success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Registration Successful! Please Login."),
                    ),
                  );
                  context.read<AuthPageCubit>().showLogin();
                } else if (state.status == RegisterStatus.failure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errorMessage ?? "Error")),
                  );
                }
              },
              builder: (context, state) {
                return CustomButton(
                  text: "Next",
                  isLoading: state.status == RegisterStatus.loading,
                  onTap: () async {
                    // Navigate to choose role screen, then submit with selected role
                    final result = await Navigator.push<UserRole?>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ChooseRoleScreen(),
                      ),
                    );

                    if (result == null) return;
                    final roleString = result == UserRole.tenant
                        ? 'TENANT'
                        : 'LANDLORD';

                    // update role into state, then submit
                    context.read<RegisterCubit>().updateRole(roleString);
                    await context.read<RegisterCubit>().submitRegister(
                      name: _nameController.text,
                      email: _emailController.text,
                      phone: _phoneController.text,
                      password: _passwordController.text,
                      confirmPassword: _confirmPasswordController.text,
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 16),

            // --- LOGIN LINK --- (kept as-is; image variant may differ)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: GoogleFonts.poppins(color: Colors.grey),
                ),
                GestureDetector(
                  onTap: () => context.read<AuthPageCubit>().showLogin(),
                  child: Text(
                    "Sign in",
                    style: GoogleFonts.poppins(
                      color: appSecondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
