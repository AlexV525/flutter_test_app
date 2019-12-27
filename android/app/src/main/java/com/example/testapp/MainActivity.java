package com.example.testapp;

import android.content.res.AssetFileDescriptor;
import android.content.res.AssetManager;
import android.os.Bundle;

import androidx.annotation.NonNull;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity implements MethodChannel.MethodCallHandler {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    Registrar registrar = registrarFor("com.example.testapp.test_channel");
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "channel");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall methodCall, @NonNull MethodChannel.Result result) {
    if (methodCall.method.equals("loadVideoAD")) {
      method();
    } else {
      result.notImplemented();
    }
  }

  void method() {

    try {
      Registrar registrar = registrarFor("com.example.testapp.test_channel");
      AssetManager assetManager = registrar.context().getAssets();
      String assetKey = registrar.lookupKeyForAsset("images/ic_launcher.png");
      AssetFileDescriptor fileDescriptor = assetManager.openFd(assetKey);
    } catch (Exception e) {
      e.printStackTrace();
    }
  }
}
