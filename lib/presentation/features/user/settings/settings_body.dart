import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/domain/providers/isSeller.provider.dart';
import 'package:sondya_app/presentation/features/user/settings/change_password_body.dart';
import 'package:sondya_app/presentation/features/user/settings/edit_company_details.dart';
import 'package:sondya_app/presentation/features/user/settings/edit_personal_details_body.dart';
import 'package:sondya_app/presentation/features/user/settings/edit_socials_body.dart';
import 'package:sondya_app/presentation/features/user/settings/logout.dart';
import 'package:sondya_app/utils/is_seller.dart';
import 'package:sondya_app/utils/url_launcher.dart';

class SettingsBody extends ConsumerStatefulWidget {
  const SettingsBody({super.key});

  @override
  ConsumerState<SettingsBody> createState() => _SettingsBodyState();
}

class _SettingsBodyState extends ConsumerState<SettingsBody> {
  bool _isSwitched = false;

  @override
  void initState() {
    super.initState();
    _isSwitched = isSellerSession();
  }

  void _toggleSwitch(bool value) {
    if (mounted) {
      setState(() {
        _isSwitched = value;
        if (value == true) {
          context.push("/seller/products");
          ref.read(isSellerProvider.notifier).update1(value);
        } else {
          context.push("/");
          ref.read(isSellerProvider.notifier).update1(value);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 1150,
        width: double.infinity,
        color: const Color(0xFFF5F5F5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: const Color(0xFFFFFFFF),
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  context.canPop()
                      ? IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back),
                        )
                      : const SizedBox(),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Settings",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF5C5566),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              color: const Color(0xFFFFFFFF),
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Switch to Seller Mode",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF5C5566),
                    ),
                  ),
                  CupertinoSwitch(
                    value: _isSwitched,
                    onChanged: _toggleSwitch,
                    activeColor: const Color(0xFF91DF8F),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SettingsTile(
              icon: Icons.account_circle_outlined,
              title: "Personal Details",
              iconColor: const Color(0xFFFFC749),
              onTap: () {
                showGeneralDialog(
                  context: context,
                  transitionDuration: const Duration(
                      milliseconds: 100), // Adjust animation duration
                  transitionBuilder: (context, a1, a2, widget) {
                    return FadeTransition(
                      opacity:
                          CurvedAnimation(parent: a1, curve: Curves.easeIn),
                      child: widget,
                    );
                  },
                  barrierLabel: MaterialLocalizations.of(context)
                      .modalBarrierDismissLabel, // Optional accessibility label
                  pageBuilder: (context, animation1, animation2) {
                    return const EditPersonalDetailsBody();
                  },
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            SettingsTile(
              icon: Icons.person_add,
              title: "Referral",
              onTap: () {
                context.push("/referral");
              },
              bottomBorder: true,
            ),
            SettingsTile(
              icon: Icons.person_pin_circle_outlined,
              title: "KYC",
              iconColor: const Color(0xFFFFC749),
              onTap: () {
                context.push("/kyc/email/verify");
              },
              bottomBorder: true,
            ),
            SettingsTile(
              icon: Icons.lock,
              title: "Change Password",
              iconColor: const Color(0xFFFFC749),
              onTap: () {
                // context.push("/login");
                showGeneralDialog(
                  context: context,
                  transitionDuration: const Duration(
                      milliseconds: 100), // Adjust animation duration
                  transitionBuilder: (context, a1, a2, widget) {
                    return FadeTransition(
                      opacity:
                          CurvedAnimation(parent: a1, curve: Curves.easeIn),
                      child: widget,
                    );
                  },
                  barrierLabel: MaterialLocalizations.of(context)
                      .modalBarrierDismissLabel, // Optional accessibility label
                  pageBuilder: (context, animation1, animation2) {
                    return const ChangePasswordBody();
                  },
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            SettingsTile(
              icon: Icons.archive,
              title: "Edit Socials",
              onTap: () {
                showGeneralDialog(
                  context: context,
                  transitionDuration: const Duration(
                      milliseconds: 100), // Adjust animation duration
                  transitionBuilder: (context, a1, a2, widget) {
                    return FadeTransition(
                      opacity:
                          CurvedAnimation(parent: a1, curve: Curves.easeIn),
                      child: widget,
                    );
                  },
                  barrierLabel: MaterialLocalizations.of(context)
                      .modalBarrierDismissLabel, // Optional accessibility label
                  pageBuilder: (context, animation1, animation2) {
                    return const EditSocialsBody();
                  },
                );
              },
              bottomBorder: true,
            ),
            SettingsTile(
              icon: Icons.inbox_outlined,
              title: "Inbox",
              iconColor: const Color(0xFFFFC749),
              onTap: () {
                context.push("/inbox");
              },
              bottomBorder: true,
            ),
            SettingsTile(
              icon: Icons.payment,
              title: "My Payments",
              iconColor: const Color(0xFFFFC749),
              onTap: () {
                context.push("/user/payments");
              },
              bottomBorder: true,
            ),
            SettingsTile(
              icon: Icons.cases_outlined,
              title: "Company Details",
              onTap: () {
                // context.push("/login");
                showGeneralDialog(
                  context: context,
                  transitionDuration: const Duration(
                      milliseconds: 100), // Adjust animation duration
                  transitionBuilder: (context, a1, a2, widget) {
                    return FadeTransition(
                      opacity:
                          CurvedAnimation(parent: a1, curve: Curves.easeIn),
                      child: widget,
                    );
                  },
                  barrierLabel: MaterialLocalizations.of(context)
                      .modalBarrierDismissLabel, // Optional accessibility label
                  pageBuilder: (context, animation1, animation2) {
                    return const EditCompanyDetailsBody();
                  },
                );
              },
              bottomBorder: true,
            ),
            SettingsTile(
              icon: Icons.notifications_outlined,
              title: "Notifications",
              iconColor: const Color(0xFFFFC749),
              onTap: () {
                context.push("/notifications");
              },
              bottomBorder: true,
            ),
            const SizedBox(
              height: 20,
            ),
            SettingsTile(
              icon: Icons.person_remove,
              title: "Delete Account",
              iconColor: const Color(0xFFFF8038),
              onTap: () {
                // context.push("/login");
                sondyaUrlLauncher(
                    url: Uri.parse('https://www.sondya.com/delete/account'));
              },
              bottomBorder: true,
            ),
            SettingsTile(
              icon: Icons.mode,
              title: "Theme Mode",
              iconColor: const Color(0xFFFFC749),
              onTap: () {
                context.push("/theme/mode");
              },
              bottomBorder: true,
            ),
            SettingsTile(
              icon: Icons.rate_review,
              title: "Rate Us",
              onTap: () {
                context.push("/home");
              },
              bottomBorder: true,
            ),
            SettingsTile(
              icon: Icons.logout,
              title: "Logout",
              onTap: () {
                // context.push("/login");
                showGeneralDialog(
                  context: context,
                  transitionDuration: const Duration(
                      milliseconds: 100), // Adjust animation duration
                  transitionBuilder: (context, a1, a2, widget) {
                    return FadeTransition(
                      opacity:
                          CurvedAnimation(parent: a1, curve: Curves.easeIn),
                      child: widget,
                    );
                  },
                  barrierLabel: MaterialLocalizations.of(context)
                      .modalBarrierDismissLabel, // Optional accessibility label
                  pageBuilder: (context, animation1, animation2) {
                    return const LogoutBody();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final String title;
  final Color iconColor;
  final IconData? icon;
  final bool bottomBorder;
  final void Function()? onTap;
  const SettingsTile(
      {super.key,
      required this.title,
      this.iconColor = const Color(0xFF91DF8F),
      this.onTap,
      this.icon,
      this.bottomBorder = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0),
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        border: Border(
          bottom: bottomBorder
              ? BorderSide(
                  color: const Color(0xFF5C5566).withOpacity(.33),
                  width: 1.2,
                )
              : BorderSide.none,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: iconColor, // Background color of the container
                ),
                padding: const EdgeInsets.all(10),
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  color: Color(0xFF5C5566),
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              if (onTap != null) {
                onTap!();
              }
            },
            icon: const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF5C5566),
            ),
          ),
        ],
      ),
    );
  }
}
