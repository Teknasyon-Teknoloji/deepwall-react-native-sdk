# DeepWall (react native sdk)

* This package gives' wrapper methods for deepwall sdks. [iOS](https://github.com/Teknasyon-Teknoloji/deepwall-ios-sdk) - [Android](https://github.com/Teknasyon-Teknoloji/deepwall-android-sdk)

* Before implementing this package, you need to have **api_key** and list of **actions**.

* You can get api_key and actions from [DeepWall Dashboard](https://console.deepwall.com/)


---


## Getting started

`$ npm install deepwall-react-native-sdk --save`

**React Native 0.59 and below**

Run `$ react-native link deepwall-react-native-sdk` to link the library.


### Installation Notes
- **IOS**
  - Set minimum ios version to 10.0 in `ios/Podfile` like: `platform :ios, '10.0'`
  - Add `use_frameworks!` into `ios/Podfile` if not exists.
  - Remove `flipper` from `ios/Podfile` if exists.
  - Run `$ cd ios && pod install`

- **ANDROID**
  - Set `minSdkVersion` to  21 in `android/build.gradle`
  - Add `maven { url 'https://raw.githubusercontent.com/Teknasyon-Teknoloji/deepwall-android-sdk/master/' }` into `android/build.gradle` (Add into repositories under allprojects)


---


## Usage

### Let's start

- On application start you need to initialize sdk with api key and environment.
```javascript
import DeepWall, { DeepWallEnvironments } from 'deepwall-react-native-sdk';

DeepWall.getInstance().initialize('{API_KEY}', DeepWallEnvironments.PRODUCTION);
```

- Before requesting any paywall you need to set UserProperties (device uuid, country, language). [See all parameters](https://github.com/Teknasyon-Teknoloji/deepwall-ios-sdk#configuration)
```javascript
import DeepWall, { DeepWallUserProperties } from 'deepwall-react-native-sdk';

DeepWall.getInstance().setUserProperties(
  new DeepWallUserProperties({
    uuid: 'UNIQUE_DEVICE_ID_HERE (UUID)',
    country: 'us',
    language: 'en-us',
  }),
);
```

- After setting userProperties, you are ready for requesting paywall with an action key. You can find action key in DeepWall dashboard.
```javascript
import DeepWall from 'deepwall-react-native-sdk';

DeepWall.getInstance().requestPaywall('{ACTION_KEY}');

// You can send extra parameter if needed as below
DeepWall.getInstance().requestPaywall('{ACTION_KEY}', {'sliderIndex': 2, 'title': 'Deepwall'});
```

- You can also close paywall.
```javascript
import DeepWall from 'deepwall-react-native-sdk';

DeepWall.getInstance().closePaywall();
```

- When any of userProperties is changed, you need to call updateUserProperties method. (For example if user changed application language)
```javascript
import DeepWall from 'deepwall-react-native-sdk';

DeepWall.getInstance().updateUserProperties({
  language: 'fr-fr',
});
```

- You can validate receipts like below.
```javascript
import DeepWall, { DeepWallValidateReceiptTypes } from 'deepwall-react-native-sdk';

DeepWall.getInstance().validateReceipt(DeepWallValidateReceiptTypes.RESTORE);
```


### Events

- There is also bunch of events triggering before and after DeepWall Actions. You may listen any event like below.
```javascript
import DeepWall, { DeepWallEventBus, DeepWallEvents } from 'deepwall-react-native-sdk';

DeepWallEventBus.getInstance().addListener(DeepWallEvents.PAYWALL_OPENED, function (data) {
  console.log(
    'DeepWallEvents.PAYWALL_OPENED',
    data
  );
});
```

- For example, you may listen all events from sdk like below.
```javascript
import { DeepWallEventBus, DeepWallEvents } from 'deepwall-react-native-sdk';

Object.values(DeepWallEvents).map((item) => {
  DeepWallEventBus.getInstance().addListener(item, function (data) {
    console.log(item, data);
  });
});
```

- Adding and removing event listener example
```javascript
import { DeepWallEventBus, DeepWallEvents } from 'deepwall-react-native-sdk';

componentDidMount() {
  DeepWallEventBus.getInstance().addListener(DeepWallEvents.PAYWALL_OPENED, this.paywallOpenedListener = data => {
    // handle the event
  })
}

componentWillUnmount() {
  DeepWallEventBus.getInstance().removeListener(this.paywallOpenedListener);
}
```


### iOS Only Methods

- Requesting ATT Prompts
  - Before calling the method, make sure that your iOS app's `Info.plist` contains an entry for `NSUserTrackingUsageDescription` key.

```javascript
import DeepWall from 'deepwall-react-native-sdk';

DeepWall.getInstance().requestAppTracking('{ACTION_KEY}');

// You can send extra parameter if needed as below
DeepWall.getInstance().requestAppTracking('{ACTION_KEY}', {appName: "My awesome app"});
```

- Sending extra data to paywall while it's open.
```javascript
import DeepWall from 'deepwall-react-native-sdk';

DeepWall.getInstance().sendExtraDataToPaywall({appName: "My awesome app"});
```


### Android Only Methods

- For consumable products, you need to mark the purchase as consumed for consumable product to be purchased again.
```javascript
import DeepWall from 'deepwall-react-native-sdk';

DeepWall.getInstance().consumeProduct('consumable_product_id');
```

- Use `setProductUpgradePolicy` method to set the product upgrade policy for Google Play apps.
```javascript
import DeepWall, { DeepWallProrationTypes, DeepWallUpgradePolicies } from 'deepwall-react-native-sdk';

DeepWall.getInstance().setProductUpgradePolicy(
  DeepWallProrationTypes.IMMEDIATE_WITHOUT_PRORATION,
  DeepWallUpgradePolicies.ENABLE_ALL_POLICIES
);
```
  
- Use `updateProductUpgradePolicy` method to update the product upgrade policy within the app workflow before requesting paywalls.
```javascript
import DeepWall, { DeepWallProrationTypes, DeepWallUpgradePolicies } from 'deepwall-react-native-sdk';

DeepWall.getInstance().updateProductUpgradePolicy(
  DeepWallProrationTypes.IMMEDIATE_WITHOUT_PRORATION,
  DeepWallUpgradePolicies.ENABLE_ALL_POLICIES
);
```


---


## Notes
- You may find complete list of _events_ in [Enums/Events.js](./src/Enums/Events.js) or [Native Sdk Page](https://github.com/Teknasyon-Teknoloji/deepwall-ios-sdk#event-handling)
- **UserProperties** are:
    - uuid
    - country
    - language
    - environmentStyle
    - debugAdvertiseAttributions


## Troubleshooting

### Android
- If you get NATIVE_MODULE_NOT_FOUND error, that means you have to link this library manually.
  - Add new instance of Deepwall package into `src/main/java/com/YOUR-APP-NAME/MainApplication.java`
```java
// MainApplication.java

...
import com.deepwall.RNDeepWallPackage;// <-- Add this line.
...

protected List<ReactPackage> getPackages() {
  List<ReactPackage> packages = new PackageList(this).getPackages();
  packages.add(new RNDeepWallPackage()); // <-- Add this line.
  return packages;
}
```
