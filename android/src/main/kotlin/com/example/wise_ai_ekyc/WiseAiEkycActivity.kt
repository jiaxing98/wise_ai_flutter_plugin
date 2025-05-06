package com.example.wise_ai_ekyc

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.widget.ProgressBar
import androidx.appcompat.app.AppCompatActivity
import com.google.gson.JsonObject
import com.google.gson.JsonParser
import com.wiseai.ekyc110.WiseAiApp
import com.wiseai.ekyc110.ekyc.Ekyc
import com.wiseai.ekyc110.helper.SessionCallback
import java.util.Objects


const val ACTIVITY_EKYC = 0

class WiseAiEkycActivity : AppCompatActivity() {
    private lateinit var loadingIndicator: ProgressBar
    private lateinit var wiseAiApp: WiseAiApp

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContentView(R.layout.activity_wise_ai_ekyc)
        loadingIndicator = findViewById(R.id.loadingIndicator)

        wiseAiApp = WiseAiApp()
        wiseAiApp.init(this, WiseAiEkycPlugin.config!!.token, WiseAiEkycPlugin.config!!.endpoint)
        performEkyc()
    }

    private fun performEkyc() {
        val ekycIntent = Intent(this, Ekyc::class.java)
        val countryCode = intent.getStringExtra("COUNTRY_CODE")
        val idType = intent.getStringExtra("ID_TYPE")
        val backCamera = intent.getBooleanExtra("BACK_CAMERA", false)
        val ifEncryption = false

        ekycIntent.putExtra("COUNTRY_CODE", countryCode)
        ekycIntent.putExtra("ID_TYPE", idType)
        ekycIntent.putExtra("EXPORT_FACE", false);
        ekycIntent.putExtra("IF_ENCRYPTION", ifEncryption)
        if (backCamera) ekycIntent.putExtra("CAMERA_FACING", "BACK");

        WiseAiApp.startNewSession(ifEncryption, object : SessionCallback {
            override fun onComplete(data: Any?) {
                startActivityForResult(ekycIntent, ACTIVITY_EKYC)
            }

            override fun onError(exception: String?) {
                // 1. Parse string to JsonObject
                val jsonObject : JsonObject = JsonParser.parseString(exception).asJsonObject

                // 2. Handle exception
                if (jsonObject.has("status") && jsonObject.get("status").asString.equals("error")) {
                    // 3.1 if error, return the error message instead of throw error
                    WiseAiEkycPlugin.onCompleted?.let { it(Result.success(jsonObject.toString())) }
                    onBackPressedDispatcher.onBackPressed()
                }
            }
        })
    }

    override fun onActivityResult(requestCode: Int , resultCode: Int , data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        // Return if the result is not from eKYC
        if (requestCode != ACTIVITY_EKYC) return;

        // Error
        if (resultCode != Activity.RESULT_OK) {
            var status: String? = null
            if (data != null) status = data.getStringExtra("STATUS")

            // 1. if cancelled, return the cancelled code
            if (Objects.equals(status, "CANCELLED")) {
                WiseAiEkycPlugin.onCompleted?.let { it(Result.success("CANCELLED")) }
            } else {
                // 2. if error, return the error message instead of throwing error
                WiseAiEkycPlugin.onCompleted?.let { it(Result.success(data.toString())) }
            }

            onBackPressedDispatcher.onBackPressed()
            return
        }

        // Success
        val result = WiseAiApp.getResult()

        // 2. Parse string to JsonObject
        val jsonObject : JsonObject = JsonParser.parseString(result).asJsonObject

        // 3. Process result
        if (jsonObject.has("status") && jsonObject.get("status").asString.equals("error")) {
            // 3.1 if error, return the error message instead of throw error
            WiseAiEkycPlugin.onCompleted?.let { it(Result.success(jsonObject.toString())) }
        } else {
            WiseAiEkycPlugin.onCompleted?.let { it(Result.success(jsonObject.toString())) }
        }

        onBackPressedDispatcher.onBackPressed()
    }
}