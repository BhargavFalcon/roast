import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

class SubscriptionService {
  static const _yearlyId = "com.falconapps.roastme.yearly";
  static const _weeklyId = "com.falconapps.roastme.weekly";

  static Future<CustomerInfo?> _getCustomerInfo() async {
    try {
      return await Purchases.getCustomerInfo();
    } catch (e) {
      return null;
    }
  }

  static Future<bool> hasActiveSubscription() async {
    final customerInfo = await _getCustomerInfo();
    if (customerInfo == null) return false;

    return customerInfo.entitlements.all.values.any(
      (e) => e.isActive && _isOurProduct(e.productIdentifier),
    );
  }

  static Future<String?> getActiveProductId() async {
    final customerInfo = await _getCustomerInfo();
    if (customerInfo == null) return null;

    for (final entitlement in customerInfo.entitlements.all.values) {
      if (entitlement.isActive &&
          _isOurProduct(entitlement.productIdentifier)) {
        return entitlement.productIdentifier;
      }
    }
    return null;
  }

  static bool _isOurProduct(String productId) {
    return productId == _yearlyId || productId == _weeklyId;
  }

  Future<void> presentPaywall() async {
    await RevenueCatUI.presentPaywall();
  }
}
