import {NativeEventEmitter, NativeModules} from 'react-native';
import {DeepWallException} from '../Exceptions/DeepWallException';
import ErrorCodes from '../Enums/ErrorCodes';
import EventBus from './EventBus';

export default class SdkEventListener {
  constructor() {
    if (!NativeModules.RNDeepWallEmitter) {
      throw new DeepWallException(
        ErrorCodes.NATIVE_MODULE_EVENT_EMITTER_NOT_FOUND,
      );
    }
  }

  listenEvents() {
    const NativeEventBusEmitter = new NativeEventEmitter(
      NativeModules.RNDeepWallEmitter,
    );

    NativeEventBusEmitter.addListener('DeepWallEvent', (DeepWallEvent) => {
      EventBus.getInstance().fireEvent(
        DeepWallEvent.event,
        typeof DeepWallEvent.data === 'undefined' ? null : DeepWallEvent.data,
      );
    });
  }
}
