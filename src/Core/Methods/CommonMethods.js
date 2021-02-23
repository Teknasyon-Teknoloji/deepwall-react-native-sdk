import DeepWallException from '../../Exceptions/DeepWallException';
import ErrorCodes from '../../Enums/ErrorCodes';
import ValidateReceiptTypes from '../../Enums/ValidateReceiptTypes';

export default class CommonMethods {
  nativeDeepWall;

  constructor(nativeDeepWall) {
    this.nativeDeepWall = nativeDeepWall;
  }

  /**
   * @param apiKey
   * @param environment
   * @returns {CommonMethods}
   */
  initialize(apiKey, environment) {
    this.nativeDeepWall.initialize(apiKey, environment);
  }

  /**
   * @param {UserProperties} userProperties
   */
  setUserProperties(userProperties) {
    if (!userProperties.get('uuid')) {
      throw new DeepWallException(ErrorCodes.USER_PROPERTIES_UUID_REQUIRED);
    }

    if (!userProperties.get('country')) {
      throw new DeepWallException(ErrorCodes.USER_PROPERTIES_COUNTRY_REQUIRED);
    }

    if (!userProperties.get('language')) {
      throw new DeepWallException(ErrorCodes.USER_PROPERTIES_LANGUAGE_REQUIRED);
    }

    this.nativeDeepWall.setUserProperties(userProperties.get());
  }

  /**
   * @param country
   * @param language
   * @param environmentStyle
   * @param debugAdvertiseAttributions
   */
  updateUserProperties({country, language, environmentStyle, debugAdvertiseAttributions}) {
    this.nativeDeepWall.updateUserProperties(
      country,
      language,
      environmentStyle,
      debugAdvertiseAttributions,
    );
  }

  /**
   * @param {ValidateReceiptTypes} type
   */
  validateReceipt(type) {
    if (!Object.values(ValidateReceiptTypes).includes(type)) {
      throw new DeepWallException(ErrorCodes.VALIDATE_RECEIPT_TYPE_NOT_VALID);
    }

    this.nativeDeepWall.validateReceipt(type);
  }

  /**
   * @param actionKey
   * @param extraData
   */
  requestPaywall(actionKey, extraData = null) {
    this.nativeDeepWall.requestPaywall(actionKey, extraData);
  }

  /**
   * closePaywall
   */
  closePaywall() {
    this.nativeDeepWall.closePaywall();
  }
}
