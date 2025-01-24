import 'package:ban_x/common/widgets/custom_standard_button.dart';
import 'package:ban_x/common/widgets/keyboard_dimiss_view.dart';
import 'package:ban_x/controllers/authentication/sign_up_controller.dart';
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

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);

    return Scaffold(
        appBar: getAppbar(BanXString.appName),
        key: controller.scaffoldKey,
        resizeToAvoidBottomInset: true,
        body: GetBuilder<SignUpController>(
            init: controller,
            builder: (_) => keyboardDismissView(
                child: buildBodyWidget(controller, context, isDark))));
  }

  Widget buildBodyWidget(
      SignUpController controller, BuildContext context, bool isDark) {
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
            _buildLoginForm(context, isDark),

            const SizedBox(height: BanXSizes.spaceBtwItems),

            /// Divider and other options
            _buildDivider(context, isDark),
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

        Text(BanXString.loginTitle,
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: BanXSizes.sm),
        Text(BanXString.signUpTitle,
            style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }

  Widget _buildLoginForm(BuildContext context, bool isDark) {
    /// Login Form
    return Form(
        child: Column(children: [
      ///User Name
      TextFormField(
        decoration: const InputDecoration(
          prefixIcon: Icon(Iconsax.user_edit),
          labelText: BanXString.userName,
        ),
      ),

      const SizedBox(height: BanXSizes.spaceBtwInputFields),

      ///Email
      TextFormField(
        decoration: const InputDecoration(
          prefixIcon: Icon(Iconsax.direct_right),
          labelText: BanXString.email,
        ),
      ),

      const SizedBox(height: BanXSizes.spaceBtwInputFields),

      ///Password
      Obx(
        () => TextFormField(
          obscureText: !(controller.isPasswordVisible.value),
          decoration: InputDecoration(
            prefixIcon: const Icon(Iconsax.password_check),
            labelText: BanXString.password,
            suffixIcon: IconButton(
              icon: Icon(
                controller.isPasswordVisible.value
                    ? Icons.visibility
                    : Icons.visibility_off,
                // color: AppColors.standardBtnColor
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
                  value: controller.isAgreeToTerms.value,
                  onChanged: (value) {
                    controller.updateAgreeToTerms(value ?? false);
                  })),
          const SizedBox(width: BanXSizes.spaceBtwItems),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "${BanXString.agreeTo} ",
                style: Theme.of(context).textTheme.bodySmall),
            TextSpan(
                text: "${BanXString.privacyPolicy} ",
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: isDark ? Colors.white : BanXColors.primaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor:
                        isDark ? Colors.white : BanXColors.primaryColor)),
            TextSpan(
                text: "and ", style: Theme.of(context).textTheme.bodySmall),
            TextSpan(
                text: BanXString.termsOfUse,
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: isDark ? Colors.white : BanXColors.primaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor:
                        isDark ? Colors.white : BanXColors.primaryColor))
          ]))
        ],
      ),

      const SizedBox(height: BanXSizes.spaceBtwItems),

      ///Sign Up Button
      customStandardBtn(BanXString.signUp, callBack: controller.onTapSignUp),
    ]));
  }

  Widget _buildDivider(BuildContext context, bool isDark) {
    return Column(
      children: [
        /// Already have an account text
        RichText(
            text: TextSpan(
                text: '${BanXString.alreadyHaveAnAccount} ',
                style: TextStyle(
                    fontSize: BanXSizes.fontSizeSm,
                    color: isDark ? BanXColors.darkerGrey : BanXColors.darkGrey,
                    fontWeight: FontWeight.normal
                    // fontFamily: "NexaBold"
                    ),
                children: [
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    controller.onTapLoginText();
                  },
                text: BanXString.signIn,
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: BanXSizes.fontSizeMd,
                  fontWeight: FontWeight.bold,
                  // color: Colors.black
                  color: isDark ? BanXColors.darkerGrey : BanXColors.black,
                  // fontFamily: "NexaBold"
                ),
              )
            ])),

        const SizedBox(height: BanXSizes.spaceBtwItems),

        ///Divider
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Divider(
                color: isDark ? BanXColors.darkerGrey : BanXColors.darkGrey,
                thickness: 1,
                indent: 60,
                endIndent: 5,
              ),
            ),
            const SizedBox(height: BanXSizes.xs),
            Text(BanXString.orSignUpWith,
                style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: BanXSizes.xs),
            Flexible(
              child: Divider(
                color: isDark ? BanXColors.darkerGrey : BanXColors.darkGrey,
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
            // controller.loginWithGoogle();
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
