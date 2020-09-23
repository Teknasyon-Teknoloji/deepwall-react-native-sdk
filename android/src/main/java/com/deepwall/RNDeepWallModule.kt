package com.deepwall

import android.os.Bundle
import com.facebook.react.bridge.*
import com.google.gson.Gson
import com.google.gson.JsonObject
import deepwall.core.DeepWall
import deepwall.core.DeepWall.initDeepWallWith
import deepwall.core.DeepWall.setUserProperties
import deepwall.core.models.*
import io.reactivex.functions.Consumer
import manager.eventbus.EventBus
import org.json.JSONException
import org.json.JSONObject


open class RNDeepWallModule(private val reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {
  override fun getName(): String {
    return "RNDeepWall"
  }

  var deepWallEmitter = RNDeepWallEmitter(reactContext)

  @ReactMethod
  fun initialize(apiKey: String?, environment: Int) {
    observeDeepWallEvents()
    val deepWallEnvironment = if (environment == 1) DeepWallEnvironment.SANDBOX else DeepWallEnvironment.PRODUCTION
    initDeepWallWith(currentActivity!!.application, this.currentActivity!!, apiKey!!, deepWallEnvironment)
  }

  @ReactMethod
  fun setUserProperties(userProperties: ReadableMap) {
    val uuid = userProperties.getString("uuid")
    val country = userProperties.getString("country")
    val language = userProperties.getString("language")
    setUserProperties(uuid!!, country!!, language!!)
  }

  @ReactMethod
  fun requestLanding(actionKey: String, extraData: ReadableMap? = null) {
    var hashMap: HashMap<String, Any> = HashMap()
    var bundle = Bundle()
    if (extraData != null) {
      hashMap = extraData.toHashMap()
      bundle.putSerializable("data", hashMap)
    }
    DeepWall.showLanding(this.currentActivity!!, actionKey, bundle)
  }

  @ReactMethod
  fun updateUserProperties(country: String,
                           language: String,
                           environmentStyle: Int = 0,
                           debugAdvertiseAttributions: String?) {

    val theme: DeepWallEnvironmentStyle = if (environmentStyle == 0) DeepWallEnvironmentStyle.LIGHT else DeepWallEnvironmentStyle.DARK
    DeepWall.updateUserProperties(country, language, theme)
  }

  @ReactMethod
  fun closeLanding() {
    DeepWall.closeLanding()
  }

  private fun observeDeepWallEvents() {
    EventBus.subscribe(Consumer {

      var map = WritableNativeMap()

      when (it.type) {
        DeepWallEvent.LANDING_OPENED.value -> {
          map = WritableNativeMap()
          map.putString("data", it.data.toString())
          map.putString("event", "landingOpened")
          deepWallEmitter.sendEvent(reactContext, "DeepWallEvent", map)
        }
        DeepWallEvent.DO_NOT_SHOW.value -> {
          map = WritableNativeMap()
          map.putString("data", it.data.toString())
          map.putString("event", "landingActionShowDisabled")
          deepWallEmitter.sendEvent(reactContext, "DeepWallEvent", map)
        }
        DeepWallEvent.CLOSED.value -> {
          map = WritableNativeMap()
          map.putString("data", it.data.toString())
          map.putString("event", "landingClosed")
          deepWallEmitter.sendEvent(reactContext, "DeepWallEvent", map)
        }
        DeepWallEvent.LANDING_PURCHASING_PRODUCT.value -> {
          map = WritableNativeMap()
          map.putString("data", it.data.toString())
          map.putString("event", "landingPurchasingProduct")
          deepWallEmitter.sendEvent(reactContext, "DeepWallEvent", map)
        }
        DeepWallEvent.LANDING_PURCHASE_FAILED.value -> {
          map = WritableNativeMap()
          map.putString("data", it.data.toString())
          map.putString("event", "landingPurchaseFailed")
          deepWallEmitter.sendEvent(reactContext, "DeepWallEvent", map)
        }
        DeepWallEvent.LANDING_PURCHASE_SUCCESS.value -> {
          map = WritableNativeMap()
          val data = it.data as SubscriptionDetail
          val modelMap = convertJsonToMap(convertJson(data))
          map.putMap("data", modelMap)
          map.putString("event", "landingPurchaseSuccess")
          deepWallEmitter.sendEvent(reactContext, "DeepWallEvent", map)
        }

        DeepWallEvent.LANDING_RESPONSE_FAILURE.value -> {
          map = WritableNativeMap()
          val data = it.data as PageResponse
          val modelData = convertJsonToMap(convertJson(data))
          map.putMap("data", modelData)
          map.putString("event", "landingResponseFailure")
          deepWallEmitter.sendEvent(reactContext, "DeepWallEvent", map)
        }

        DeepWallEvent.LANDING_RESTORE_SUCCESS.value -> {
          map = WritableNativeMap()
          map.putString("data", it.data.toString())
          map.putString("event", "landingRestoreSuccess")
          deepWallEmitter.sendEvent(reactContext, "DeepWallEvent", map)
        }

        DeepWallEvent.LANDING_RESTORE_FAILED.value -> {
          map = WritableNativeMap()
          map.putString("data", it.data.toString())
          map.putString("event", "landingRestoreFailed")
          deepWallEmitter.sendEvent(reactContext, "DeepWallEvent", map)
        }
        DeepWallEvent.EXTRA_DATA.value -> {
          map = WritableNativeMap()
          val modelData = it.data?.let { it1 -> convertJson(it1) }?.let { it2 -> convertJsonToMap(it2) }
          map.putMap("data", modelData)
          map.putString("event", "landingExtraDataReceived")
          deepWallEmitter.sendEvent(reactContext, "DeepWallEvent", map)
        }
      }
    })
  }

  @Throws(JSONException::class)
  private fun convertJsonToMap(jsonObject: JSONObject): WritableNativeMap? {
    val map = WritableNativeMap()
    val iterator = jsonObject.keys()
    while (iterator.hasNext()) {
      val key = iterator.next()
      val value = jsonObject[key]
      if (value is JSONObject) {
        map.putMap(key, convertJsonToMap(value))
      } else if (value is Boolean) {
        map.putBoolean(key, (value))
      } else if (value is Int) {
        map.putInt(key, (value))
      } else if (value is Double) {
        map.putDouble(key, (value))
      } else if (value is String) {
        map.putString(key, value)
      } else {
        map.putString(key, value.toString())
      }
    }
    return map
  }

  @Throws(JSONException::class)
  private fun convertJson(model: Any): JSONObject {
    val gson = Gson()
    val jsonInString = gson.toJson(model)
    return JSONObject(jsonInString)
  }


}
