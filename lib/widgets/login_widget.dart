import 'package:flutter/material.dart';
import 'package:surf_test/pages/users_sliver_page.dart';
import 'package:surf_test/pages/users_old_page.dart';
import 'package:surf_test/resources/surftest_colors.dart';
import 'package:surf_test/widgets/primary_button.dart';

import 'form_error.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({
    Key? key,
  }) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late FocusNode _focusNodeEmail;
  late FocusNode _focusNodePassword;
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  late bool validateEmail = false;
  late bool validatePassword = false;
  final List<String> errors = [];

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  void addError({required String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({required String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  final RegExp emailValidatorRegExp =
      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  void initState() {
    super.initState();
    _focusNodeEmail = FocusNode();
    _focusNodePassword = FocusNode();
    _focusNodeEmail.addListener(() {
      setState(() {});
    });
    _focusNodePassword.addListener(() {
      setState(() {});
    });

    _emailTextController.addListener(() {
      setState(() {});
    });
    _passwordTextController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _focusNodeEmail.hasFocus || _focusNodePassword.hasFocus
                  ? ""
                  : "Вход",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 60),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromRGBO(2, 28, 96, 0.2),
                    blurRadius: 20.0,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    buildTextFormFieldEmail(),
                    const SizedBox(height: 20),
                    buildTextFormFieldPassword(),
                    const SizedBox(height: 22),
                    //todo если делать кнопку активной только при валидных полях как показывать ошибки валидации...
                    errors.length > 0
                        ? FormError(errors: errors)
                        : const SizedBox(height: 0),
                    const SizedBox(height: 30),
                    PrimaryBtn(
                      text: "Войти",
                      onTap: () => isEmptyFields() ? null : _onTap(),
                      activeBtn: !isEmptyFields(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildTextFormFieldEmail() {
    return TextFormField(
      controller: _emailTextController,
      onChanged: (value) {
        if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: "Введите корректный Email");
          setState(() {
            validateEmail = true;
          });
        }
        if (!emailValidatorRegExp.hasMatch(value)) {
          setState(() {
            validateEmail = false;
          });
        }
        return null;
      },
      validator: (value) {
        if (!emailValidatorRegExp.hasMatch(value!)) {
          addError(error: "Введите корректный Email");
          return "";
        }
        return null;
      },
      obscureText: false,
      keyboardType: TextInputType.emailAddress,
      keyboardAppearance: Brightness.light,
      textInputAction: TextInputAction.go,
      focusNode: _focusNodeEmail,
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: TextStyle(
            color: _focusNodeEmail.hasFocus
                ? SurfTestColors.primaryColor
                : SurfTestColors.placeHolderTextColor,
            fontSize: 16),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: const Color(0xFF828282)),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: const Color(0xFFD8D8D8)),
        ),
      ),
    );
  }

  TextFormField buildTextFormFieldPassword() {
    return TextFormField(
      controller: _passwordTextController,
      onChanged: (value) {
        if (value.length >= 8) {
          removeError(error: "Пароль должен быть больше 8 символов");
          setState(() {
            validatePassword = true;
          });
        }
        if (value.length < 8) {
          setState(() {
            validatePassword = false;
          });
        }
        return null;
      },
      validator: (value) {
        if (value!.length < 8) {
          addError(error: "Пароль должен быть больше 8 символов");
          return "";
        }
        return null;
      },
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      keyboardAppearance: Brightness.light,
      textInputAction: TextInputAction.go,
      focusNode: _focusNodePassword,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: const Color(0xFF828282)),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: const Color(0xFFD8D8D8)),
        ),
        labelText: 'Пароль',
        labelStyle: TextStyle(
            color: _focusNodePassword.hasFocus
                ? SurfTestColors.primaryColor
                : SurfTestColors.placeHolderTextColor,
            fontSize: 16),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }

  bool isEmptyFields() {
    final checkEmpty = _emailTextController.text.isEmpty ||
        _passwordTextController.text.isEmpty;
    final checkValidate = checkEmpty || !validateEmail || !validatePassword;
    //print(validateEmail);
    return checkValidate;
  }

  void _onTap() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      KeyboardUtil.hideKeyboard(context);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => UsersSliverPage()));
    }
  }
}

class KeyboardUtil {
  static void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
