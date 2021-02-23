/**
 * ErrorCodes
 */
export default {
  NATIVE_MODULE_NOT_FOUND: {
    code: 101,
    message: 'Native module "RNDeepWall" not found.',
  },
  NATIVE_MODULE_EVENT_EMITTER_NOT_FOUND: {
    code: 121,
    message: 'Native module "RNDeepWallEmitter" not found.',
  },
  USER_PROPERTIES_UUID_REQUIRED: {
    code: 801,
    message: 'Missing parameter "uuid" for UserProperties.',
  },
  USER_PROPERTIES_COUNTRY_REQUIRED: {
    code: 802,
    message: 'Missing parameter "country" for UserProperties.',
  },
  USER_PROPERTIES_LANGUAGE_REQUIRED: {
    code: 803,
    message: 'Missing parameter "language" for UserProperties.',
  },
  VALIDATE_RECEIPT_TYPE_NOT_VALID: {
    code: 902,
    message: 'Validate receipt type is not valid.',
  },
  PRODUCT_ID_REQUIRED: {
    code: 1001,
    message: 'Product id is required.',
  },
  PRORATION_TYPE_NOT_VALID: {
    code: 1101,
    message: 'Proration type is not valid.',
  },
  UPGRADE_POLICY_TYPE_NOT_VALID: {
    code: 1102,
    message: 'Upgrade policy type is not valid.',
  },
};
