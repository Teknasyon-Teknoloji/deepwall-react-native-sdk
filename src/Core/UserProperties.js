/**
 * UserProperties
 */
export default class UserProperties {
  constructor({
    uuid,
    country,
    language,
    environmentStyle = 0,
    debugAdvertiseAttributions = null,
  }) {
    this.uuid = uuid;
    this.country = country;
    this.language = language;
    this.environmentStyle = environmentStyle;
    this.debugAdvertiseAttributions = debugAdvertiseAttributions;
  }

  get(key) {
    if (typeof key !== 'undefined') {
      return this[key];
    }

    return {
      uuid: this.uuid,
      country: this.country,
      language: this.language,
      environmentStyle: this.environmentStyle,
      debugAdvertiseAttributions: this.debugAdvertiseAttributions,
    };
  }
}
