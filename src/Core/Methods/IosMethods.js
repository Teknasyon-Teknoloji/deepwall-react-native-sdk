import {IS_IOS} from '../utils';

export default class IosMethods {
  nativeDeepWall;

  constructor(nativeDeepWall) {
    this.nativeDeepWall = nativeDeepWall;
  }

  /**
   * hidePaywallLoadingIndicator
   */
  hidePaywallLoadingIndicator() {
    if (!IS_IOS) {
      return;
    }

    this.nativeDeepWall.hidePaywallLoadingIndicator();
  }

  /**
   * requestAppTracking
   *
   * @param actionKey
   * @param extraData
   */
  requestAppTracking(actionKey, extraData = null) {
    if (!IS_IOS) {
      return;
    }

    this.nativeDeepWall.requestAppTracking(actionKey, extraData);
  }

  /**
   * sendExtraDataToPaywall
   *
   * @param extraData
   */
  sendExtraDataToPaywall(extraData) {
    if (!IS_IOS) {
      return;
    }

    this.nativeDeepWall.sendExtraDataToPaywall(extraData);
  }
}
