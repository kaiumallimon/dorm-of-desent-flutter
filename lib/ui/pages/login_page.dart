import 'package:dorm_of_decents/configs/constants.dart';
import 'package:dorm_of_decents/configs/theme.dart';
import 'package:dorm_of_decents/ui/widgets/app_logo.dart';
import 'package:dorm_of_decents/ui/widgets/custom_button.dart';
import 'package:dorm_of_decents/ui/widgets/custom_textfield.dart';
import 'package:dorm_of_decents/utils/sizing.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grid_background/grid_background.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.getTheme(context);
    final windowSize = Sizing.windowSize(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Gridbackground(
              space: 60,
              horizontallinewidth: 1.0,
              verticallinewidth: 1.0,
              color: theme.colorScheme.onSurface.withAlpha(20),
            ),

            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Sizing.screenHPadding,
                ),
                child: Card(
                  color: theme.scaffoldBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(
                      color: theme.colorScheme.primary.withAlpha(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppLogo(windowSize: windowSize),
                        const SizedBox(height: 10),
                        Text(
                          AppConstants.appTitle,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          prefixIcon: Icons.email,
                          label: AppConstants.emailLabel,
                          isBordered: false,
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          prefixIcon: Icons.lock,
                          label: AppConstants.passwordLabel,
                          isBordered: false,
                          obscureText: true,
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                          size: ButtonSize.md,
                          label: AppConstants.loginButton,
                          loadingLabel: AppConstants.loadingLabel,
                          variant: ButtonVariant.solid,
                          loading: false,
                          onPressed: () {},
                        ),
                        const SizedBox(height: 15),
                        Center(
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 2,
                            runSpacing: 2,
                            children: [
                              Text(
                                "Contact ",
                                style: theme.textTheme.bodySmall,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: "@kaiumallimon",
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {},
                                ),
                              ),
                              Text(
                                " to create or update an account.",
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
