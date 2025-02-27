import 'package:ban_x/common/widgets/custom_standard_button.dart';
import 'package:ban_x/common/widgets/keyboard_dimiss_view.dart';
import 'package:ban_x/controllers/authentication/sign_in_controller.dart';
import 'package:ban_x/utils/constants/banx_colors.dart';
import 'package:ban_x/utils/constants/banx_sizes.dart';
import 'package:ban_x/utils/constants/banx_strings.dart';
import 'package:ban_x/utils/helpers/appbar_utils.dart';
import 'package:ban_x/utils/helpers/helper_functions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final controller = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    // final isDark = HelperFunctions.isDarkMode(context);

    return Scaffold(
        appBar: getAppbar(BanXString.appName,
            backgroundColor: BanXColors.primaryBackground),
        key: controller.scaffoldKey,
        resizeToAvoidBottomInset: true,
        backgroundColor: BanXColors.primaryBackground,
        body: GetBuilder<SignInController>(
            init: controller,
            builder: (_) => SafeArea(
                  child: buildBodyWidget(context),
                )));
  }

  Widget buildBodyWidget(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              MediaQuery.of(context).padding.bottom -
              kToolbarHeight,
        ),
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

        /// App title
        const Text(BanXString.loginTitle,
            style: TextStyle(
                color: BanXColors.primaryTextColor,
                fontSize: BanXSizes.lg,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: BanXSizes.sm),
        const Text(BanXString.loginSubTitle,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: BanXSizes.md,
                color: BanXColors.secondaryTextColor)),
      ],
    );
  }

  /// Login Form
  Widget _buildLoginForm(BuildContext context) {
    return Form(
        child: Column(children: [
      ///Email
      TextFormField(
        style: const TextStyle(color: BanXColors.primaryTextColor),
        decoration: const InputDecoration(
          prefixIcon:
              Icon(Iconsax.direct, color: BanXColors.secondaryTextColor),
          labelText: BanXString.email,
          floatingLabelStyle:
              const TextStyle(color: BanXColors.primaryTextColor),
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

      ///Password
      Obx(
        () => TextFormField(
          obscureText: !(controller.isPasswordVisible.value),
          style: const TextStyle(color: BanXColors.primaryTextColor),
          decoration: InputDecoration(
            prefixIcon: const Icon(Iconsax.password_check,
                color: BanXColors.secondaryTextColor),
            labelText: BanXString.password,
            floatingLabelStyle:
                const TextStyle(color: BanXColors.primaryTextColor),
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
                  color: BanXColors.secondaryTextColor),
              onPressed: () {
                controller.updatePasswordVisible();
              },
            ),
          ),
        ),
      ),

      const SizedBox(height: BanXSizes.spaceBtwInputFields / 2),

      ///Remember me checkbox
      Obx(() => ListTileTheme(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: 0.0,
          child: CheckboxListTile(
            fillColor: WidgetStateProperty.all(BanXColors.primaryBackground),
            visualDensity:
                const VisualDensity(horizontal: -1.0, vertical: -4.0),
            title: const Text(
              BanXString.rememberMe,
              style: TextStyle(
                  color: BanXColors.primaryTextColor,
                  fontSize: BanXSizes.fontSizeSm),
            ),
            value: controller.isRememberMe.value,
            onChanged: (newValue) {
              controller.updateRememberMe(newValue ?? false);
            },
            controlAffinity:
                ListTileControlAffinity.leading, //  <-- leading Checkbox
          ))),

      const SizedBox(height: BanXSizes.sm),

      ///Sign In Button
      customStandardBtn(BanXString.signIn, callBack: controller.onTapSignIn),
    ]));
  }

  Widget _buildDivider(BuildContext context) {
    return Column(
      children: [
        /// Don't have an account text
        RichText(
            text: TextSpan(
                text: '${BanXString.doNotHaveAnAccount} ',
                style: const TextStyle(
                    fontSize: BanXSizes.fontSizeMd,
                    color: BanXColors.secondaryTextColor,
                    fontWeight: FontWeight.bold),
                children: [
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    controller.onTapCreateText();
                  },
                text: BanXString.create,
                style: const TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: BanXSizes.fontSizeMd,
                    fontWeight: FontWeight.bold,
                    color: BanXColors.primaryTextColor),
              )
            ])),

        const SizedBox(height: BanXSizes.spaceBtwItems),

        ///Divider
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Divider(
                color: BanXColors.darkerGrey,
                thickness: 1,
                indent: 60,
                endIndent: 5,
              ),
            ),
            SizedBox(height: BanXSizes.xs),
            Text(BanXString.orSignInWith,
                style: TextStyle(
                    fontSize: BanXSizes.fontSizeMd,
                    color: BanXColors.secondaryTextColor,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: BanXSizes.xs),
            Flexible(
              child: Divider(
                color: BanXColors.darkerGrey,
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
