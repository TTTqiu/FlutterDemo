package com.example.myflutterapp

import android.content.*
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity : FlutterActivity() {
    companion object {
        const val BATTERY_CHANNEL = "com.example.myflutterapp/battery"
        const val CHARGING_CHANNEL = "com.example.myflutterapp/charging"
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        EventChannel(flutterEngine.dartExecutor, CHARGING_CHANNEL).setStreamHandler(
                object : EventChannel.StreamHandler {
                    lateinit var chargingStateChangeReceiver: BroadcastReceiver
                    override fun onListen(arguments: Any?, events: EventSink) {
                        chargingStateChangeReceiver = createChargingStateChangeReceiver(events)
                        registerReceiver(chargingStateChangeReceiver, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
                    }

                    override fun onCancel(arguments: Any?) {
                        unregisterReceiver(chargingStateChangeReceiver)
                    }
                }
        )
        MethodChannel(flutterEngine.dartExecutor, BATTERY_CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getBatteryLevel") {
                val batteryLevel = getBatteryLevel()
                if (batteryLevel != -1) {
                    result.success(batteryLevel)
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun createChargingStateChangeReceiver(events: EventSink): BroadcastReceiver {
        return object : BroadcastReceiver() {
            override fun onReceive(context: Context, intent: Intent) {
                val status = intent.getIntExtra(BatteryManager.EXTRA_STATUS, -1)
                if (status == BatteryManager.BATTERY_STATUS_UNKNOWN) {
                    events.error("UNAVAILABLE", "Charging status unavailable", null)
                } else {
                    val isCharging = status == BatteryManager.BATTERY_STATUS_CHARGING ||
                            status == BatteryManager.BATTERY_STATUS_FULL
                    events.success(if (isCharging) "charging" else "discharging")
                }
            }
        }
    }

    private fun getBatteryLevel(): Int {
        var batteryLevel = -1
        if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            if (intent != null) {
                batteryLevel = intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 /
                        intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
            }
        }
        return batteryLevel
    }
}
