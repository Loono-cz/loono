package cz.loono.app

import cz.loono.loono.platformSpecific.AccountProvider
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    lateinit var accountProvider: AccountProvider

    override fun onFlutterUiDisplayed() {
        accountProvider =
            AccountProvider(flutterEngine!!.dartExecutor.binaryMessenger, this)
        super.onFlutterUiDisplayed()
    }
}
