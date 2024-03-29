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
  - Set ios version to 10.0 or higher in `ios/Podfile` like: `platform :ios, '10.0'`
  - Remove `flipper` from `ios/Podfile` if exists.
  - Run `$ cd ios && pod install`

- **ANDROID**
  - Set `minSdkVersion` to 21 or higher in `android/build.gradle`
  - Make sure your min gradle version is "3.6.4" or higher in `android/build.gradle`. (Check troubleshooting section to see example)
  - Add code below into `android/build.gradle` (Add into repositories under allprojects)
  ```
  maven { url 'https://raw.githubusercontent.com/Teknasyon-Teknoloji/deepwall-android-sdk/master/' }
  maven { url 'https://developer.huawei.com/repo/' }
  ```

- **Notes for android**
  - If your project's react native version is higher than 0.65.0 then you should add `jcenter()` into `android/build.gradle` (Add into repositories under allprojects)

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
import DeepWall, { DeepWallUserProperties, DeepWallEnvironmentStyles } from 'deepwall-react-native-sdk';

DeepWall.getInstance().setUserProperties(
  new DeepWallUserProperties({
    uuid: 'UNIQUE_DEVICE_ID_HERE (UID)',
    country: 'us',
    language: 'en-us',
    environmentStyle: DeepWallEnvironmentStyles.DARK, // Optional
    debugAdvertiseAttributions: null, // Optional
    phoneNumber: null, // Optional
    emailAddress: null, // Optional
    firstName: null, // Optional
    lastName: null, // Optional
  }),
);
```

- After setting userProperties, you are ready for requesting paywall with an action key. You can find action key in DeepWall dashboard.
```javascript
import DeepWall from 'deepwall-react-native-sdk';

DeepWall.getInstance().requestPaywall('{ACTION_KEY}');

// You can send extra parameter if needed
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
import DeepWall, { DeepWallEventBus, DeepWallEvents, DeepWallEnvironments } from 'deepwall-react-native-sdk';

DeepWallEventBus.getInstance().addListener(DeepWallEvents.PAYWALL_OPENED, function (data) {
  console.log(
    'DeepWallEvents.PAYWALL_OPENED',
    data
  );
});

DeepWallEventBus.getInstance().addListener(DeepWallEvents.INIT_FAILURE, function (data) {
  //init failure you may call init again
  DeepWall.getInstance().initialize('{API_KEY}', DeepWallEnvironments.PRODUCTION);
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

- You can set orientation when calling requestPaywall method.
```javascript
import DeepWall, {DeepWallDeviceOrientations} from 'deepwall-react-native-sdk';

DeepWall.getInstance().requestPaywall('{ACTION_KEY}', {}, DeepWallDeviceOrientations.LANDSCAPE);
```

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
- If you get "unexpected element `<queries>` found in `<manifest>`" error
  - Set min gradle version to "3.6.4" in `android/build.gradle` file. See example below:
    - `classpath("com.android.tools.build:gradle:3.6.4")`

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
