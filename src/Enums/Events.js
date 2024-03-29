/**
 * Events
 */
export default {
  // Common events
  PAYWALL_REQUESTED: 'deepWallPaywallRequested',
  PAYWALL_RESPONSE_RECEIVED: 'deepWallPaywallResponseReceived',
  PAYWALL_RESPONSE_FAILURE: 'deepWallPaywallResponseFailure',
  PAYWALL_OPENED: 'deepWallPaywallOpened',
  PAYWALL_NOT_OPENED: 'deepWallPaywallNotOpened',
  PAYWALL_ACTION_SHOW_DISABLED: 'deepWallPaywallActionShowDisabled',
  PAYWALL_CLOSED: 'deepWallPaywallClosed',
  PAYWALL_EXTRA_DATA_RECEIVED: 'deepWallPaywallExtraDataReceived',
  PAYWALL_PURCHASING_PRODUCT: 'deepWallPaywallPurchasingProduct',
  PAYWALL_PURCHASE_SUCCESS: 'deepWallPaywallPurchaseSuccess',
  PAYWALL_PURCHASE_FAILED: 'deepWallPaywallPurchaseFailed',
  PAYWALL_RESTORE_SUCCESS: 'deepWallPaywallRestoreSuccess',
  PAYWALL_RESTORE_FAILED: 'deepWallPaywallRestoreFailed',

  // iOS ONLY events
  ATT_STATUS_CHANGED: 'deepWallATTStatusChanged',

  // Android ONLY events
  PAYWALL_CONSUME_SUCCESS: 'deepWallPaywallConsumeSuccess',
  PAYWALL_CONSUME_FAIL: 'deepWallPaywallConsumeFailure',
  INIT_FAILURE: 'deepWallInitFailure',
};
