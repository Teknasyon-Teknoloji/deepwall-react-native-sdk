package com.deepwall

import android.os.Bundle
import com.appsflyer.internal.r
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
  fun requestPaywall(actionKey: String, extraData: ReadableMap? = null) {
    var hashMap: HashMap<String, Any> = HashMap()
    var bundle = Bundle()
    if (extraData != null) {
      hashMap = extraData.toHashMap()
      bundle.putSerializable("data", hashMap)
    }
    DeepWall.showPaywall(this.currentActivity!!, actionKey, bundle)
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
  fun closePaywall() {
    DeepWall.closePaywall()
  }

  @ReactMethod
  fun hidePaywallLoadingIndicator(){

  }

  @ReactMethod
  fun validateReceipt(validationType: Int) {
    val validation = when (validationType) {
      1 -> DeepWallReceiptValidationType.PURCHASE
      2 -> DeepWallReceiptValidationType.RESTORE
      3 -> DeepWallReceiptValidationType.AUTOMATIC
      else -> DeepWallReceiptValidationType.PURCHASE
    }
    DeepWall.validateReceipt(validation)
  }

  private fun observeDeepWallEvents() {
    EventBus.subscribe(Consumer {

      var map = WritableNativeMap()

      when (it.type) {
        DeepWallEvent.PAYWALL_OPENED.value -> {
          map = WritableNativeMap()
          val data = it.data as PaywallOpenedInfo
          val modelMap = convertJsonToMap(convertJson(data))
          map.putMap("data", modelMap)
          map.putString("event", "deepWallPaywallOpened")
          deepWallEmitter.sendEvent(reactContext, "DeepWallEvent", map)
        }
        DeepWallEvent.DO_NOT_SHOW.value -> {
          map = WritableNativeMap()
          val data = it.data as PaywallNotOpenedInfo
          val modelMap = convertJsonToMap(convertJson(data))
          map.putMap("data", modelMap)
          map.putString("event", "deepWallPaywallActionShowDisabled")
          deepWallEmitter.sendEvent(reactContext, "DeepWallEvent", map)
        }
        DeepWallEvent.CLOSED.value -> {
          map = WritableNativeMap()
          val data = it.data as PaywallClosedInfo
          val modelMap = convertJsonToMap(convertJson(data))
          map.putMap("data", modelMap)
          map.putString("event", "deepWallPaywallClosed")
          deepWallEmitter.sendEvent(reactContext, "DeepWallEvent", map)
        }
        DeepWallEvent.PAYWALL_PURCHASING_PRODUCT.value -> {
          map = WritableNativeMap()
          val data = it.data as PaywallPurchasingProductInfo
          val modelMap = convertJsonToMap(convertJson(data))
          map.putMap("data", modelMap)
          map.putString("event", "deepWallPaywallPurchasingProduct")
          deepWallEmitter.sendEvent(reactContext, "DeepWallEvent", map)
        }
        DeepWallEvent.PAYWALL_PURCHASE_FAILED.value -> {
          map = WritableNativeMap()
          val data = it.data as SubscriptionErrorResponse
          val modelMap = convertJsonToMap(convertJson(data))
          map.putMap("data", modelMap)
          map.putString("event", "deepWallPaywallPurchaseFailed")
          deepWallEmitter.sendEvent(reactContext, "DeepWallEvent", map)
        }
        DeepWallEvent.PAYWALL_PURCHASE_SUCCESS.value -> {
          map = WritableNativeMap()
          val data = it.data as SubscriptionResponse
          val modelMap = convertJsonToMap(convertJson(data))
          map.putMap("data", modelMap)
          map.putString("event", "deepWallPaywallPurchaseSuccess")
          deepWallEmitter.sendEvent(reactContext, "DeepWallEvent", map)
        }

        DeepWallEvent.PAYWALL_RESPONSE_FAILURE.value -> {
          map = WritableNativeMap()
          val data = it.data as PaywallFailureResponse
          val modelData = convertJsonToMap(convertJson(data))
          map.putMap("data", modelData)
          map.putString("event", "deepWallPaywallResponseFailure")
          deepWallEmitter.sendEvent(reactContext, "DeepWallEvent", map)
        }

        DeepWallEvent.PAYWALL_RESTORE_SUCCESS.value -> {
          map = WritableNativeMap()
          map.putString("data", it.data.toString())
          map.putString("event", "deepWallPaywallRestoreSuccess")
          deepWallEmitter.sendEvent(reactContext, "DeepWallEvent", map)
        }

        DeepWallEvent.PAYWALL_RESTORE_FAILED.value -> {
          map = WritableNativeMap()
          map.putString("data", it.data.toString())
          map.putString("event", "deepWallPaywallRestoreFailed")
          deepWallEmitter.sendEvent(reactContext, "DeepWallEvent", map)
        }
        DeepWallEvent.EXTRA_DATA.value -> {
          map = WritableNativeMap()
          val modelData = it.data?.let { it1 -> convertJson(it1) }?.let { it2 -> convertJsonToMap(it2) }
          map.putMap("data", modelData)
          map.putString("event", "deepWallPaywallExtraDataReceived")
          deepWallEmitter.sendEvent(reactContext, "DeepWallEvent", map)
        }

        DeepWallEvent.PAYWALL_REQUESTED.value -> {
          map = WritableNativeMap()
          map.putString("data", "")
          map.putString("event", "deepWallPaywallRequested")
          deepWallEmitter.sendEvent(reactContext, "DeepWallEvent", map)
        }

        DeepWallEvent.PAYWALL_RESPONSE_RECEIVED.value -> {
          map = WritableNativeMap()
          map.putString("data", "")
          map.putString("event", "deepWallPaywallResponseReceived")
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
