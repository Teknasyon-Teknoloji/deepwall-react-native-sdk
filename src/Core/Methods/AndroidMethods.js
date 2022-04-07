import DeepWallException from '../../Exceptions/DeepWallException';
import ErrorCodes from '../../Enums/ErrorCodes';
import ProrationTypes from '../../Enums/ProrationTypes';
import UpgradePolicies from '../../Enums/UpgradePolicies';
import {IS_ANDROID} from '../utils';

export default class AndroidMethods {
  nativeDeepWall;

  constructor(nativeDeepWall) {
    this.nativeDeepWall = nativeDeepWall;
  }

  /**
   * @param productId string
   */
  consumeProduct(productId) {
    if (!IS_ANDROID) {
      return;
    }

    if (!productId) {
      throw new DeepWallException(ErrorCodes.PRODUCT_ID_REQUIRED);
    }

    this.nativeDeepWall.consumeProduct(productId);
  }

  /**
   * @param prorationType
   * @param upgradePolicy
   */
  setProductUpgradePolicy(prorationType, upgradePolicy) {
    if (!IS_ANDROID) {
      return;
    }

    this.validateProrationType(prorationType);
    this.validateUpgradePolicy(upgradePolicy);

    this.nativeDeepWall.setProductUpgradePolicy(prorationType, upgradePolicy)
  }

  /**
   * @param prorationType
   * @param upgradePolicy
   */
  updateProductUpgradePolicy(prorationType, upgradePolicy) {
    if (!IS_ANDROID) {
      return;
    }

    this.validateProrationType(prorationType);
    this.validateUpgradePolicy(upgradePolicy);

    this.nativeDeepWall.updateProductUpgradePolicy(prorationType, upgradePolicy)
  }

  /**
   * Validation
   * @param prorationType
   */
  validateProrationType(prorationType) {
    if (!Object.values(ProrationTypes).includes(prorationType)) {
      throw new DeepWallException(ErrorCodes.PRORATION_TYPE_NOT_VALID);
    }
  }

  /**
   * Validation
   * @param upgradePolicy
   */
  validateUpgradePolicy(upgradePolicy) {
    if (!Object.values(UpgradePolicies).includes(upgradePolicy)) {
      throw new DeepWallException(ErrorCodes.UPGRADE_POLICY_TYPE_NOT_VALID);
    }
  }
}
