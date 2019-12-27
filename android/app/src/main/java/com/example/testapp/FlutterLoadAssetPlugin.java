package com.example.testapp;

import android.content.res.AssetFileDescriptor;
import android.content.res.AssetManager;

import java.io.IOException;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class FlutterAssetLoadPlugin implements MethodChannel.MethodCallHandler {
    final String key = "NMethodLayout";


    @Override
    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        AssetManager assetManager = registrar.context().getAssets();
        String key = registrar.lookupKeyForAsset("icons/heart.png");
        try {
            AssetFileDescriptor fd = assetManager.openFd(key);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}