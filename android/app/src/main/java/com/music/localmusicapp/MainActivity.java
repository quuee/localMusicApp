package com.music.localmusicapp;

import android.os.Bundle;
import android.widget.RemoteViews;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        MethodChannel methodChannel = new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), "getMusicMethodChannel");
        methodChannel.setMethodCallHandler(new MusicMethodChannelHandler(getContext()));
    }


}
