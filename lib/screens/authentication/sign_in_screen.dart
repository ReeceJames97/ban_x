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
    final isDark = HelperFunctions.isDarkMode(context);

    return Scaffold(
        appBar: getAppbar(BanXString.appName),
        key: controller.scaffoldKey,
        resizeToAvoidBottomInset: true,
        body: GetBuilder<SignInController>(
            init: controller,
            builder: (_) => keyboardDismissView(
                  child: buildBodyWidget(context, isDark),
                )));
  }

  Widget buildBodyWidget(BuildContext context, bool isDark) {
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

        /// App title
        Text(BanXString.loginTitle,
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: BanXSizes.sm),
        Text(BanXString.loginSubTitle,
            style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }

  /// Login Form
  Widget _buildLoginForm(BuildContext context, bool isDark) {
    return Form(
        child: Column(children: [
      ///Email
      TextFormField(
        decoration: const InputDecoration(
          prefixIcon: Icon(Iconsax.direct),
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

      const SizedBox(height: BanXSizes.spaceBtwInputFields / 2),

      ///Remember me checkbox
      Obx(() => ListTileTheme(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: 0.0,
          child: CheckboxListTile(
            visualDensity:
                const VisualDensity(horizontal: -1.0, vertical: -4.0),
            title: const Text(
              BanXString.rememberMe,
              // style: TextStyle(
              //     fontSize: ScreenUtil().setSp(28),
              //     color: AppColors.standardBtnColor,
              //     fontWeight: FontWeight.bold),
            ),
            value: controller.isRememberMe.value,
            onChanged: (newValue) {
              controller.updateRememberMe(newValue ?? false);
            },
            controlAffinity:
                ListTileControlAffinity.leading, //  <-- leading Checkbox
          ))),

      const SizedBox(height: BanXSizes.sm),

      Row(
        children: [
          ///Sign In Button
          Expanded(
              flex: 1,
              child: customStandardBtn(BanXString.signIn,
                  callBack: controller.onTapSignIn)),

          const SizedBox(width: BanXSizes.sm),

          ///Sign Up Button
          Expanded(
            flex: 1,
            child: customStandardBtn(BanXString.signUp,
                buttonColor: BanXColors.secondaryBtnColor,
                callBack: controller.onTapSignUp),
          )
        ],
      ),
    ]));
  }

  Widget _buildDivider(BuildContext context, bool isDark) {
    return Column(
      children: [
        /// Don't have an account text
        RichText(
            text: TextSpan(
                text: '${BanXString.doNotHaveAnAccount} ',
                style: TextStyle(
                    fontSize: BanXSizes.fontSizeSm,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.normal
                    // fontFamily: "NexaBold"
                    ),
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
                    color: Colors.black
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
            Text(BanXString.orSignInWith,
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
