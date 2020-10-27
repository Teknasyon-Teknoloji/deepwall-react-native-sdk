import React from 'react';
import {View, Button} from 'react-native';
import DeepWall, {
  DeepWallEnvironments,
  DeepWallUserProperties,
  DeepWallEvents,
  DeepWallEventBus,
} from 'deepwall-react-native-sdk';

const API_KEY = 'XXXX'; // Api key from deepwall console

export default class App extends React.Component {
  deepwallListeners = [];

  constructor(props) {
    super(props);

    DeepWall.getInstance().initialize(API_KEY, DeepWallEnvironments.PRODUCTION);
  }

  componentDidMount() {
    DeepWall.getInstance().setUserProperties(
      new DeepWallUserProperties({
        uuid: 'deepwall-test-device',
        country: 'en',
        language: 'en-en',
      }),
    );

    // Listen and log all events
    Object.values(DeepWallEvents).map(item => {
      DeepWallEventBus.getInstance().addListener(item, this.deepwallListeners[item] = data => {
        console.log('Deepwall event received: ', item, data);
      });
    });
  }

  componentWillUnmount() {
    // Remove all listeners
    Object.values(DeepWallEvents).map(item => {
      DeepWallEventBus.getInstance().removeListener(this.deepwallListeners[item]);
    });
  }

  render() {
    return (
      <View style={{flex: 1, justifyContent: 'center', alignItems: 'center'}}>
        <View style={{width: 200}}>
          <Button
            title={'OPEN PAGE'}
            onPress={() => DeepWall.getInstance().requestPaywall('AppLaunch')}
          />
        </View>
      </View>
    );
  }
}
