package cz.loono.loono

import android.app.NotificationManager
import android.content.Context
import android.os.Build
import android.service.notification.StatusBarNotification
import androidx.annotation.RequiresApi
import com.onesignal.OSNotificationReceivedEvent
import com.onesignal.OneSignal.OSRemoteNotificationReceivedHandler
import cz.loono.loono.platformSpecific.AccountProvider
import kotlinx.coroutines.MainScope
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch

class NotificationService : OSRemoteNotificationReceivedHandler {
    @RequiresApi(Build.VERSION_CODES.O)
    override fun remoteNotificationReceived(
        context: Context,
        event: OSNotificationReceivedEvent
    ) {
        val notificationManager =
            context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

        val preferences = context.getSharedPreferences(
            AccountProvider.CHANNEL_NAME,
            Context.MODE_PRIVATE
        )
        val loggedIn = preferences.getBoolean(AccountProvider.LOGGED_IN, false)

        if (!loggedIn) {
            MainScope().launch {
                val id = event.notification.androidNotificationId
                while (!notificationManager.activeNotifications.containsId(id)) {
                    delay(30_000)
                }
                notificationManager.cancel(id)
            }
        }
    }

    companion object {
        fun Array<StatusBarNotification>.containsId(id: Int): Boolean {
            for (notification in this) {
                if (notification.id == id) return true
            }
            return false
        }
    }
}