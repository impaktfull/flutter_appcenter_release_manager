package com.impaktfull.appcenter_release_manager

import android.app.DownloadManager
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.net.Uri
import android.os.Environment
import androidx.core.content.FileProvider
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.File


/** AppcenterReleaseManagerPlugin */
class AppcenterReleaseManagerPlugin : FlutterPlugin, MethodCallHandler {

    private var context: Context? = null
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "appcenter_release_manager")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "install_app" -> installApp(call, result)
            else -> result.notImplemented()
        }
    }

    private fun installApp(call: MethodCall, result: Result) {
        val context = context ?: return
        val urlArg = "install_url"
        val openAndroidInstallScreenArg = "open_android_install_screen"
        val keepAndroidNotificationArg = "keep_android_notification"
        val titleArg = "notification_title"
        val descriptionArg = "notification_description"
        if (!call.hasArgument(urlArg)) {
            result.error("404", "install_url is a required param", null)
        }

        val url = call.argument<String>(urlArg)
        val title = call.argument<String>(titleArg) ?: DEFAULT_NOTIFICATION_TITLE
        val description = call.argument<String>(descriptionArg) ?: DEFAULT_NOTIFICATION_DESCRIPTION
        var destination: String = context.getExternalFilesDir(Environment.DIRECTORY_DOWNLOADS).toString() + "/"
        val openAndroidInstallScreen = call.argument<Boolean>(openAndroidInstallScreenArg) ?: true
        val keepAndroidNotification = call.argument<Boolean>(keepAndroidNotificationArg) ?: false
        val fileName = "${url.hashCode()}_app.apk"
        destination += fileName
        val file = File(destination)
        if (file.exists()) file.delete()

        val request = DownloadManager.Request(Uri.parse(url))
        request.setDescription(description)
        request.setTitle(title)
        request.setMimeType("application/vnd.android.package-archive")
        request.setDestinationInExternalFilesDir(context.applicationContext, Environment.DIRECTORY_DOWNLOADS, fileName)
        val notificationVisibility = if (keepAndroidNotification || !openAndroidInstallScreen) DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED
        else DownloadManager.Request.VISIBILITY_VISIBLE
        request.setNotificationVisibility(notificationVisibility)
        val manager = context.getSystemService(Context.DOWNLOAD_SERVICE) as DownloadManager
        val downloadId = manager.enqueue(request)

        val onCompleteBroadcastReceiver: BroadcastReceiver = object : BroadcastReceiver() {
            override fun onReceive(ctxt: Context, intent: Intent) {
                if (openAndroidInstallScreen) {
                    val install = Intent(Intent.ACTION_VIEW)
                    install.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    install.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
                    val fileProviderUri = FileProvider.getUriForFile(context, "${context.packageName}.fileProvider.install", file)
                    install.setDataAndType(fileProviderUri, manager.getMimeTypeForDownloadedFile(downloadId))
                    ctxt.startActivity(install)
                }
                ctxt.unregisterReceiver(this)
                result.success(true)
                return
            }
        }
        context.registerReceiver(onCompleteBroadcastReceiver, IntentFilter(DownloadManager.ACTION_DOWNLOAD_COMPLETE))
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        context = null
    }

    companion object {
        const val DEFAULT_NOTIFICATION_TITLE = "Downloading apk"
        const val DEFAULT_NOTIFICATION_DESCRIPTION = ""
    }

}
