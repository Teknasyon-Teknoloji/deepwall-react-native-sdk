
# DeepWall (deepwall-react-native-sdk)

* This package gives wrapper methods for [DeepWall](https://github.com/Teknasyon-Teknoloji/deepwall-ios-sdk) sdks.

* Before implementing this package, you need to have **api_key** and list of **actions**.

* You can get api_key and actions from [DeepWall Dashboard](https://console.deepwall.com/)


---

## Getting started

`$ npm install Teknasyon-Teknoloji/deepwall-react-native-sdk#master --save`

### Installation Notes
- **IOS**
  - Set minimum ios version to 10.0 in `ios/Podfile` like: `platform :ios, '10.0'`
  - Add `use_frameworks!` into `ios/Podfile` if not exists.
  - Remove `flipper` from `ios/Podfile` if exists. (Find and remove lines below)
```
use_flipper!
  post_install do |installer|
  flipper_post_install(installer)
end
```

- **ANDROID**
  - Set `minSdkVersion` to  21 in `android/build.gradle`
  - Add `maven { url 'https://raw.githubusercontent.com/Teknasyon-Teknoloji/deepwall-android-sdk/master/' }` into `android/build.gradle` (Add into repositories under allprojects)

**React Native 0.60 and above**

Run `npx pod-install`. Linking is not required in React Native 0.60 and above.

**React Native 0.59 and below**

Run `react-native link deepwall-react-native-sdk` to link the library.
Then run `npx pod-install`.


---


## Usage

### Let's start
- On application start you need to initialize sdk with api key and environment.
```javascript
import DeepWall, { DeepWallEnvironments } from 'deepwall-react-native-sdk';

DeepWall.getInstance().initialize('API_KEY', DeepWallEnvironments.PRODUCTION);
```

- Before requesting any landing page you need to set UserProperties (device uuid, country, language). [See all parameters](https://github.com/Teknasyon-Teknoloji/deepwall-ios-sdk#configuration)
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


- After setting userProperties, you are ready for requesting landing page with an action name. You can find action name in DeepWall dashboard.
```javascript
DeepWall.getInstance().requestLanding('AppLaunch');
```

- You can also close landing.
```javascript
DeepWall.getInstance().closeLanding();
```


- If any of userProperties is changed you need to call updateUserProperties method. (For example if user changed application language)
```javascript
DeepWall.getInstance().updateUserProperties({
  language: 'fr-fr',
});
```

- There is also bunch of events triggering before and after DeepWall Actions. You may listen any action like below.
```javascript
import DeepWall, { DeepWallEventBus, DeepWallEvents } from 'deepwall-react-native-sdk';

DeepWallEventBus.getInstance().listen(DeepWallEvents.LANDING_OPENED, function (data) {
  console.log(
    'DeepWallEvents.LANDING_OPENED',
    data
  );
});
```

- For example you may listen all events from sdk like below.
```javascript
Object.values(DeepWallEvents).map((item) => {
  DeepWallEventBus.getInstance().listen(item, function (data) {
    console.log(item, data);
  });
});
```


---


## Notes
- You may found complete list of _events_ in [Enums/Events.js](./src/Enums/Events.js) or [Native Sdk Page](https://github.com/Teknasyon-Teknoloji/deepwall-ios-sdk#event-handling)
- **UserProperties** are:
    - uuid
    - country
    - language
    - environmentStyle
    - debugAdvertiseAttributions
