package cz.loono.loono.platformSpecific

import android.content.Context
import androidx.core.content.edit
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel

class AccountProvider(binaryMessenger: BinaryMessenger, context: Context) {
    private val channel = MethodChannel(
        binaryMessenger,
        CHANNEL_NAME
    )

    init {
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                LOGGED_IN -> {
                    val loggedIn = call.arguments<Boolean?>() == true
                    val preferences = context.getSharedPreferences(
                        CHANNEL_NAME,
                        Context.MODE_PRIVATE
                    )
                    preferences.edit {
                        putBoolean(LOGGED_IN, loggedIn)
                    }
                    result.success(loggedIn)
                }
            }
        }
    }

    companion object {
        const val CHANNEL_NAME = "account_channel"
        const val LOGGED_IN = "logged_in"
    }
}