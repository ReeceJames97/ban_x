import 'package:ban_x/common/widgets/custom_standard_button.dart';
import 'package:ban_x/common/widgets/keyboard_dimiss_view.dart';
import 'package:ban_x/controllers/authentication/sign_up_controller.dart';
import 'package:ban_x/utils/constants/banx_colors.dart';
import 'package:ban_x/utils/constants/banx_sizes.dart';
import 'package:ban_x/utils/constants/banx_strings.dart';
import 'package:ban_x/utils/helpers/appbar_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppbar(BanXString.appName,
            backgroundColor: BanXColors.primaryBackground),
        key: controller.scaffoldKey,
        resizeToAvoidBottomInset: true,
        backgroundColor: BanXColors.primaryBackground,
        body: GetBuilder<SignUpController>(
            init: controller,
            builder: (_) => keyboardDismissView(
                child: buildBodyWidget(controller, context))));  
  }

  Widget buildBodyWidget(
      SignUpController controller, BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.fromLTRB(
            BanXSizes.md, 0, BanXSizes.md, BanXSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// App logo and title
            _buildLogoAndTitle(),

            const SizedBox(height: BanXSizes.spaceBtwItems),

            /// Login Form
            _buildLoginForm(context),

            const SizedBox(height: BanXSizes.spaceBtwItems),

            /// Divider and other options
            _buildDivider(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoAndTitle() {
    return Column(
      children: [
        /// App logo
        SizedBox(
          width: 180,
          height: 180,
          child: Lottie.asset('assets/lotties/hello.json',
              width: 180,
              height: 180,
              animate: true,
              repeat: true,
              fit: BoxFit.fill),
        ),

        const Text(BanXString.loginTitle,
            style: TextStyle(
                color: BanXColors.primaryTextColor,
                fontSize: BanXSizes.lg,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: BanXSizes.sm),
        const Text(BanXString.signUpTitle,
            style: TextStyle(
                fontSize: BanXSizes.md,
                fontWeight: FontWeight.bold,
                color: BanXColors.secondaryTextColor)),
      ],
    );
  }

  Widget _buildLoginForm(BuildContext context) {

    /// Login Form
    return Form(
        child: Column(children: [
      ///User Name
      TextFormField(
        style: const TextStyle(color: BanXColors.primaryTextColor),
        decoration: const InputDecoration(
          prefixIcon: Icon(Iconsax.user_edit, color: BanXColors.secondaryTextColor),
          labelText: BanXString.userName,
          floatingLabelStyle: TextStyle(color: BanXColors.primaryTextColor),
          labelStyle: TextStyle(color: BanXColors.primaryTextColor),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: BanXColors.textFieldBorderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: BanXColors.primaryTextColor),
          ),
        ),
      ),

      const SizedBox(height: BanXSizes.spaceBtwInputFields),

      TextFormField(
        style: const TextStyle(color: BanXColors.primaryTextColor),
        decoration: const InputDecoration(
          prefixIcon: Icon(Iconsax.direct_right, color: BanXColors.secondaryTextColor),
          labelText: BanXString.email,
          floatingLabelStyle: TextStyle(color: BanXColors.primaryTextColor),
          labelStyle: TextStyle(color: BanXColors.primaryTextColor),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: BanXColors.textFieldBorderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: BanXColors.primaryTextColor),
          ),
        ),
      ),

      const SizedBox(height: BanXSizes.spaceBtwInputFields),

      Obx(
        () => TextFormField(
          obscureText: !(controller.isPasswordVisible.value),
          style: const TextStyle(color: BanXColors.primaryTextColor),
          decoration: InputDecoration(
            prefixIcon: const Icon(Iconsax.password_check, color: BanXColors.secondaryTextColor),
            labelText: BanXString.password,
            floatingLabelStyle: const TextStyle(color: BanXColors.primaryTextColor),
            labelStyle: const TextStyle(color: BanXColors.primaryTextColor),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: BanXColors.textFieldBorderColor),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: BanXColors.primaryTextColor),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                controller.isPasswordVisible.value
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: BanXColors.secondaryTextColor
              ),
              onPressed: () {
                controller.updatePasswordVisible();
              },
            ),
          ),
        ),
      ),

      const SizedBox(height: BanXSizes.spaceBtwItems),

      ///Terms & Conditions checkbox
      Row(
        children: [
          SizedBox(
              width: BanXSizes.lg,
              height: BanXSizes.lg,
              child: Checkbox(
                  fillColor:
                      WidgetStateProperty.all(BanXColors.primaryBackground),
                  value: controller.isAgreeToTerms.value,
                  onChanged: (value) {
                    controller.updateAgreeToTerms(value ?? false);
                  })),
          const SizedBox(width: BanXSizes.spaceBtwItems),
          const Text.rich(TextSpan(children: [
            TextSpan(
                text: "${BanXString.agreeTo} ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                    color: BanXColors.secondaryTextColor)),
            TextSpan(
                text: "${BanXString.privacyPolicy} ",
                style: TextStyle(
                    color: BanXColors.primaryTextColor,
                    decoration: TextDecoration.underline,
                    decorationColor: BanXColors.primaryTextColor)),
            TextSpan(
                text: "and ",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: BanXColors.secondaryTextColor)),
            TextSpan(
                text: BanXString.termsOfUse,
                style: TextStyle(
                    color: BanXColors.primaryTextColor,
                    decoration: TextDecoration.underline,
                    decorationColor: BanXColors.primaryTextColor))
          ]))
        ],
      ),

      const SizedBox(height: BanXSizes.spaceBtwItems),

      ///Sign Up Button
      customStandardBtn(BanXString.signUp, callBack: controller.onTapSignUp),
    ]));
  }

  Widget _buildDivider(BuildContext context) {
    return Column(
      children: [
        /// Already have an account text
        RichText(
            text: TextSpan(
                text: '${BanXString.alreadyHaveAnAccount} ',
                style: const TextStyle(
                    fontSize: BanXSizes.fontSizeSm,
                    color: BanXColors.secondaryTextColor,
                    fontWeight: FontWeight.bold
                ),
                children: [
              TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      controller.onTapLoginText();
                    },
                text: BanXString.signIn,
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: BanXSizes.fontSizeMd,
                  fontWeight: FontWeight.bold,
                  color: BanXColors.primaryTextColor,
                ),
              )
            ])),

        const SizedBox(height: BanXSizes.spaceBtwItems),

        ///Divider
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Divider(
                color: BanXColors.secondaryTextColor,
                thickness: 1,
                indent: 60,
                endIndent: 5,
              ),
            ),
            SizedBox(height: BanXSizes.xs),
            Text(BanXString.orSignUpWith,
                style: TextStyle(
                    fontSize: BanXSizes.fontSizeMd,
                    color: BanXColors.secondaryTextColor,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: BanXSizes.xs),
            Flexible(
              child: Divider(
                color: BanXColors.secondaryTextColor,
                thickness: 1,
                indent: 5,
                endIndent: 60,
              ),
            ),
          ],
        ),

        const SizedBox(height: BanXSizes.spaceBtwItems),

        ///Google Login
        GestureDetector(
          onTap: () {
            controller.loginWithGoogle();
          },
          child: const CircleAvatar(
            maxRadius: 24,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/logos/google.png'),
          ),
        )
      ],
    );
  }
}
