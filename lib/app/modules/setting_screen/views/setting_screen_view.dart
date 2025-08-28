import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roast/app/constants/color_constant.dart';
import 'package:roast/app/constants/image_constants.dart';
import 'package:roast/app/constants/sizeConstant.dart';
import 'package:roast/app/constants/subscriptionService.dart';

import '../controllers/setting_screen_controller.dart';

class SettingScreenView extends GetView<SettingScreenController> {
  const SettingScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Settings",
                style: TextStyle(
                  fontSize: MySize.getHeight(24),
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: MySize.getHeight(10)),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: const [
                    PremiumCard(),
                    SizedBox(height: 15),
                    SupportCard(),
                    SizedBox(height: 15),
                    ShareCard(),
                    SizedBox(height: 15),
                    InfoCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PremiumCard extends StatelessWidget {
  const PremiumCard({super.key});

  @override
  Widget build(BuildContext context) {
    return _CardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                ImageConstant.crown,
                height: MySize.getHeight(25),
                fit: BoxFit.contain,
              ),
              SizedBox(width: MySize.getWidth(10)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Upgrade to Premium",
                    style: TextStyle(
                      fontSize: MySize.getHeight(13),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: MySize.getHeight(2)),
                  Text(
                    "Unlock unlimited roasting power",
                    style: TextStyle(
                      fontSize: MySize.getHeight(10),
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: MySize.getHeight(15)),
          const PremiumFeatureTile(
            iconPath: ImageConstant.unlimited,
            title: "Get Unlimited Roasts",
          ),
          const PremiumFeatureTile(
            iconPath: ImageConstant.power,
            title: "Get Instant Results",
          ),
          const PremiumFeatureTile(
            iconPath: ImageConstant.lock,
            title: "Remove Annoying Paywalls",
          ),
          _PrimaryButton(
            label: "Upgrade Now",
            onTap: () async {
              await SubscriptionService().presentPaywall();
            },
          ),
        ],
      ),
    );
  }
}

class SupportCard extends StatelessWidget {
  const SupportCard({super.key});

  @override
  Widget build(BuildContext context) {
    return _CardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _CircleIcon(iconPath: ImageConstant.feedback),
              SizedBox(width: MySize.getWidth(10)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Support & Feedback",
                    style: TextStyle(
                      fontSize: MySize.getHeight(13),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: MySize.getHeight(2)),
                  Text(
                    "Rate the app or get help",
                    style: TextStyle(
                      fontSize: MySize.getHeight(10),
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: MySize.getHeight(10)),
          _OptionTile(
            iconPath: ImageConstant.review,
            title: "Review App",
            onTap: () {},
          ),
          SizedBox(height: MySize.getHeight(10)),
          _OptionTile(
            iconPath: ImageConstant.support,
            title: "Support",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class ShareCard extends StatelessWidget {
  const ShareCard({super.key});

  @override
  Widget build(BuildContext context) {
    return _CardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _CircleIcon(iconPath: ImageConstant.share),
              SizedBox(width: MySize.getWidth(10)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sharing",
                    style: TextStyle(
                      fontSize: MySize.getHeight(13),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: MySize.getHeight(2)),
                  Text(
                    "Share the app with others",
                    style: TextStyle(
                      fontSize: MySize.getHeight(10),
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: MySize.getHeight(10)),
          _OptionTile(
            iconPath: ImageConstant.share,
            title: "Share App",
            onTap: () {},
          ),
          SizedBox(height: MySize.getHeight(10)),
          _OptionTile(
            iconPath: ImageConstant.moreApp,
            title: "More Apps from Us",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class InfoCard extends GetWidget<SettingScreenController> {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingScreenController>(
      init: SettingScreenController(),
      assignId: true,
      builder: (controller) {
        return _CardContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _CircleIcon(iconPath: ImageConstant.info),
                  SizedBox(width: MySize.getWidth(10)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Information",
                        style: TextStyle(
                          fontSize: MySize.getHeight(13),
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: MySize.getHeight(2)),
                      Text(
                        "Legal and app information",
                        style: TextStyle(
                          fontSize: MySize.getHeight(10),
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: MySize.getHeight(10)),
              _OptionTile(
                iconPath: ImageConstant.policy,
                title: "Privacy Policy",
                onTap: () {},
              ),
              SizedBox(height: MySize.getHeight(10)),
              _OptionTile(
                iconPath: ImageConstant.terms,
                title: "Terms of Use",
                onTap: () {},
              ),
              SizedBox(height: MySize.getHeight(10)),
              Obx(
                () => _OptionTile(
                  iconPath: ImageConstant.version,
                  title: "Version ${controller.appVersion.value}",
                  showArrow: false,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CardContainer extends StatelessWidget {
  final Widget child;

  const _CardContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: ColorConstants.primaryColor.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.primaryColor.withValues(alpha: 0.2),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Padding(padding: const EdgeInsets.all(15), child: child),
    );
  }
}

class PremiumFeatureTile extends StatelessWidget {
  final String iconPath;
  final String title;

  const PremiumFeatureTile({
    super.key,
    required this.iconPath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MySize.getHeight(10)),
      child: Row(
        children: [
          Image.asset(
            iconPath,
            height: MySize.getHeight(20),
            fit: BoxFit.contain,
          ),
          SizedBox(width: MySize.getWidth(10)),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: MySize.getHeight(12),
                color: Colors.black,
              ),
            ),
          ),
          Icon(
            Icons.check_circle_sharp,
            color: ColorConstants.primaryColor,
            size: 20,
          ),
        ],
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _PrimaryButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: MySize.getHeight(10)),
        padding: EdgeInsets.symmetric(vertical: MySize.getHeight(10)),
        decoration: BoxDecoration(
          color: ColorConstants.primaryColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: ColorConstants.primaryColor.withValues(alpha: 0.4),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: MySize.getHeight(14),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final String iconPath;
  final String title;
  final VoidCallback? onTap;
  final bool showArrow;

  const _OptionTile({
    required this.iconPath,
    required this.title,
    this.onTap,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    final tileContent = Container(
      padding: EdgeInsets.all(MySize.getHeight(8)),
      decoration: BoxDecoration(
        color: ColorConstants.primaryColor.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.asset(
            iconPath,
            height: MySize.getHeight(15),
            color: ColorConstants.primaryColor,
          ),
          SizedBox(width: MySize.getWidth(10)),
          Text(
            title,
            style: TextStyle(
              fontSize: MySize.getHeight(12),
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          if (showArrow)
            Icon(
              Icons.arrow_forward_ios,
              size: MySize.getHeight(12),
              color: Colors.black54,
            ),
        ],
      ),
    );

    return onTap != null
        ? InkWell(onTap: onTap, child: tileContent)
        : tileContent;
  }
}

class _CircleIcon extends StatelessWidget {
  final String iconPath;

  const _CircleIcon({required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MySize.getHeight(8)),
      decoration: BoxDecoration(
        color: ColorConstants.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Image.asset(
        iconPath,
        color: ColorConstants.primaryColor,
        height: MySize.getHeight(15),
        fit: BoxFit.contain,
      ),
    );
  }
}
