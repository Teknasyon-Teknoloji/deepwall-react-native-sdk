import {NativeModules} from 'react-native';
import {DeepWallException} from '../Exceptions/DeepWallException';
import ErrorCodes from '../Enums/ErrorCodes';
import ValidateReceiptTypes from '../Enums/ValidateReceiptTypes';
import SdkEventListener from './SdkEventListener';

export default class DeepWall {
  nativeDeepWall;
  listenSdkEvents = false;

  static getInstance() {
    if (!DeepWall.instance) {
      DeepWall.instance = new DeepWall();
    }

    return DeepWall.instance;
  }

  constructor() {
    this.nativeDeepWall = NativeModules.RNDeepWall;

    if (!this.nativeDeepWall) {
      throw new DeepWallException(ErrorCodes.NATIVE_MODULE_NOT_FOUND);
    }

    // Enable SDK event listener only once (the way 'EventBus' works)
    if (!this.listenSdkEvents) {
      new SdkEventListener().listenEvents();
      this.listenSdkEvents = true;
    }
  }

  initialize(apiKey, environment) {
    this.nativeDeepWall.initialize(apiKey, environment);

    return this;
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

    return this;
  }

  updateUserProperties({
    country,
    language,
    environmentStyle = 0,
    debugAdvertiseAttributions,
  }) {
    this.nativeDeepWall.updateUserProperties(
      country,
      language,
      environmentStyle,
      debugAdvertiseAttributions,
    );

    return this;
  }

  hideLandingLoadingIndicator() {
    this.nativeDeepWall.hideLandingLoadingIndicator();
  }

  requestLanding(actionKey, extraData = null) {
    this.nativeDeepWall.requestLanding(actionKey, extraData);
  }

  closeLanding() {
    this.nativeDeepWall.closeLanding();
  }

  validateReceipt(type) {
    if (!Object.values(ValidateReceiptTypes).includes(type)) {
      throw new DeepWallException(ErrorCodes.VALIDATE_RECEIPT_TYPE_NOT_VALID);
    }

    this.nativeDeepWall.validateReceipt(type);
  }
}
