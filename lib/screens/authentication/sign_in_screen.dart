import 'package:ban_x/common/styles/spacing_style.dart';
import 'package:ban_x/common/widgets/custom_standard_button.dart';
import 'package:ban_x/controllers/authentication/sign_in_controller.dart';
import 'package:ban_x/utils/constants/banx_colors.dart';
import 'package:ban_x/utils/constants/banx_sizes.dart';
import 'package:ban_x/utils/constants/banx_strings.dart';
import 'package:ban_x/utils/helpers/appbar_utils.dart';
import 'package:ban_x/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
// import 'package:lottie/lottie.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignInController());
    final isDark = HelperFunctions.isDarkMode(context);

    return Scaffold(
        appBar: getAppbar(BanXString.appName),
        body: SingleChildScrollView(
          child: Padding(
            padding: BanXSpacingStyle.paddingWithAppBarHeight,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// App logo
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Lottie.asset('assets/lotties/hello.json',
                          width: 220,
                          height: 220,
                          animate: true,
                          repeat: true,
                          fit: BoxFit.fill),
                    ),

                    // Image(
                    //     height: 150,
                    //     image: AssetImage(isDark
                    //         ? BanXImageStrings.lightAppLogo
                    //         : BanXImageStrings.darkAppLogo)),
                    const SizedBox(height: BanXSizes.sm),
                    Text(BanXString.loginTitle,
                        style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: BanXSizes.sm),
                    Text(BanXString.loginSubTitle,
                        style: Theme.of(context).textTheme.bodyMedium),

                    const SizedBox(height: BanXSizes.spaceBtwSections),

                    /// Login Form
                    Form(
                        child: Column(children: [
                      ///Email
                      TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.direct_right),
                          labelText: BanXString.email,
                        ),
                      ),

                      const SizedBox(height: BanXSizes.spaceBtwInputFields),

                      ///Password
                      TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.password_check),
                          labelText: BanXString.password,
                          suffixIcon: Icon(Iconsax.eye_slash),
                        ),
                      ),

                      const SizedBox(height: BanXSizes.spaceBtwInputFields / 2),

                      ///Remember me and forgot password
                      Row(
                        children: [
                          ///Remember me
                          Row(
                            children: [
                              Checkbox(value: true, onChanged: (value) {}),
                              const Text(BanXString.rememberMe),
                            ],
                          ),

                          const Spacer(),

                          ///Forgot password
                          TextButton(
                              onPressed: () {},
                              child: const Text(BanXString.forgotPassword))
                        ],
                      ),

                      const SizedBox(height: BanXSizes.spaceBtwItems),

                      ///Sign In Button
                      customStandardBtn(BanXString.signIn,
                          callBack: controller.onTapSignIn),

                      const SizedBox(height: BanXSizes.spaceBtwItems),

                      ///Sign Up Button
                      customStandardBtn(BanXString.signUp,
                          callBack: controller.onTapSignUp),
                    ])),

                    const SizedBox(height: BanXSizes.spaceBtwSections),

                    ///Divider
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Divider(
                            color:
                                isDark ? BanXColors.darkGrey : BanXColors.grey,
                            thickness: 0.5,
                            indent: 60,
                            endIndent: 5,
                          ),
                        ),
                        Text(BanXString.orSignInWith,
                            style: Theme.of(context).textTheme.labelMedium),
                        Flexible(
                          child: Divider(
                            color:
                                isDark ? BanXColors.darkGrey : BanXColors.grey,
                            thickness: 0.5,
                            indent: 5,
                            endIndent: 60,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
