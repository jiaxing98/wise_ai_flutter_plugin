package com.example.wise_ai_ekyc

import EkycHostApi
import FlutterError
import PEkycConfig
import PEkycRequest
import android.content.Context
import android.content.Intent

import io.flutter.embedding.engine.plugins.FlutterPlugin

/** WiseAiEkycPlugin */
class WiseAiEkycPlugin: FlutterPlugin, EkycHostApi {
  private var context: Context? = null

  companion object {
    var config: PEkycConfig? = null
    var onCompleted: ((Result<String>) -> Unit)? = null
  }

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    this.context = flutterPluginBinding.applicationContext
    EkycHostApi.setUp(flutterPluginBinding.binaryMessenger, this)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    this.context = null
    EkycHostApi.setUp(binding.binaryMessenger, null)
  }

  override fun getPlatformVersion(callback: (Result<String>) -> Unit) {
    callback(Result.success("Android ${android.os.Build.VERSION.RELEASE}"))
  }

  override fun initialize(config: PEkycConfig, callback: (Result<Unit>) -> Unit) {
    WiseAiEkycPlugin.config = config
    callback(Result.success(Unit))
  }

  override fun performEkyc(request: PEkycRequest, callback: (Result<String>) -> Unit) {
    if (context != null) {
      val intent = Intent(context, WiseAiEkycActivity::class.java)
      intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
      intent.putExtra("COUNTRY_CODE", request.countryCode)
      intent.putExtra("ID_TYPE", request.idType)
      intent.putExtra("BACK_CAMERA", request.backCamera)
      onCompleted = callback

      if (config != null && config!!.token.isNotEmpty() && config!!.endpoint.isNotEmpty())
        context!!.startActivity(intent)
      else
        callback(Result.failure(FlutterError("CONFIG_NOT_FOUND", "Failed to find eKYC config", null)))
    } else {
      callback(Result.failure(FlutterError("CONTEXT_NOT_FOUND", "Failed to find application context", null)))
    }
  }
}
