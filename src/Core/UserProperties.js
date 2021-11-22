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
    phoneNumber = '',
    email = '',
    firstName = '',
    lastName = '',
  }) {
    this.uuid = uuid;
    this.country = country;
    this.language = language;
    this.environmentStyle = environmentStyle;
    this.debugAdvertiseAttributions = debugAdvertiseAttributions;
    this.phoneNumber = phoneNumber;
    this.email = email;
    this.firstName = firstName;
    this.lastName = lastName;
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
      phoneNumber: this.phoneNumber,
      email: this.email,
      firstName: this.firstName,
      lastName: this.lastName,
    };
  }
}
