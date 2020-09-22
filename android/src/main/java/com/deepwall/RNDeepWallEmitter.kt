package com.deepwall

import androidx.annotation.Nullable
import com.facebook.react.bridge.*
import com.facebook.react.module.annotations.ReactModule
import com.facebook.react.modules.core.DeviceEventManagerModule
import com.facebook.react.uimanager.events.RCTEventEmitter

open class RNDeepWallEmitter(private val reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext), RCTEventEmitter {


  @ReactMethod
  open fun sendEvent(reactContext: ReactContext,
                     eventName: String,
                     @Nullable params: WritableMap) {
    reactContext
      .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter::class.java)
      .emit(eventName, params)
  }


  override fun getName(): String {
    return "RNDeepWallEmitter"
  }

  override fun receiveEvent(targetTag: Int, eventName: String?, event: WritableMap?) {
    //
  }

  override fun receiveTouches(eventName: String?, touches: WritableArray?, changedIndices: WritableArray?) {
    //
  }


}
