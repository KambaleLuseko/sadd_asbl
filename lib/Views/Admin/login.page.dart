// lib/Views/Admin/login.page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sadd_asbl/Resources/Components/button.dart';
import 'package:sadd_asbl/Resources/Components/text_fields.dart';
import 'package:sadd_asbl/Resources/Components/texts.dart';
import 'package:sadd_asbl/Resources/Constants/global_variables.dart';
import 'package:sadd_asbl/Views/Admin/controller/admin.provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kScaffoldColor,
      body: Center(
        child: Container(
          width: 500,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextWidgets.textBold(
                title: 'Login',
                fontSize: 24,
                textColor: AppColors.kWhiteColor,
                align: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextFormFieldWidget(
                textColor: AppColors.kWhiteColor,
                backColor: AppColors.kTextFormWhiteColor,
                editCtrller: _usernameController,
                labelText: 'Username',
                hintText: 'Enter your username',
              ),
              const SizedBox(height: 10),
              TextFormFieldWidget(
                textColor: AppColors.kWhiteColor,
                backColor: AppColors.kTextFormWhiteColor,
                editCtrller: _passwordController,
                labelText: 'Password',
                hintText: 'Enter your password',
                isObsCured: true,
              ),
              const SizedBox(height: 20),
              CustomButton(
                  canSync: true,
                  text: "Login",
                  backColor: AppColors.kSecondaryColor,
                  textColor: AppColors.kBlackColor,
                  callback: () {
                    context.read<AdminProvider>().login(
                        email: _usernameController.text.trim(),
                        password: _passwordController.text.trim());
                  })
            ],
          ),
        ),
      ),
    );
  }
}
