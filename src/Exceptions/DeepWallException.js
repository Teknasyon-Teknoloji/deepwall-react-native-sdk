/**
 * Custom Exception
 */
export default class DeepWallException {
  constructor(error, meta) {
    const CustomError = new Error(error.message);

    CustomError.code = error.code;

    if (meta) {
      CustomError.meta = meta;
    }

    return CustomError;
  }
}
