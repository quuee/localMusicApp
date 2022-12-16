package com.music.localmusicapp;

import android.content.Context;
import android.database.Cursor;
import android.provider.MediaStore;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MusicMethodChannelHandler  implements MethodChannel.MethodCallHandler {

    private Context context;

    public MusicMethodChannelHandler(Context context){
        this.context = context;
    }

    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        if(methodCall.method.equals("getAllMusic") ){
            List<Map<String, Object>> allMusic = getAllMusic();
            result.success(allMusic);

        }else{
            result.notImplemented();
        }
    }

    private List<Map<String,Object>> getAllMusic() {
        List<Map<String,Object>> musics = new ArrayList<>();
        Cursor cursor = context.getContentResolver()
                .query(MediaStore.Audio.Media.EXTERNAL_CONTENT_URI,
                        null, null, null,
                        MediaStore.Audio.Media.DEFAULT_SORT_ORDER);

        if(cursor.moveToFirst()){
            while(!cursor.isAfterLast()){
                //歌曲编号
                int id = cursor.getInt(cursor.getColumnIndexOrThrow(MediaStore.Audio.Media._ID));
                //歌曲名
                String title = cursor.getString(cursor.getColumnIndexOrThrow(MediaStore.Audio.Media.TITLE));
                //歌曲的专辑名：MediaStore.Audio.Media.ALBUM
                String album = cursor.getString(cursor.getColumnIndexOrThrow(MediaStore.Audio.Media.ALBUM));
                //歌曲的歌手名： MediaStore.Audio.Media.ARTIST
                String singer = cursor.getString(cursor.getColumnIndexOrThrow(MediaStore.Audio.Media.ARTIST));
                //歌曲文件的路径 ：MediaStore.Audio.Media.DATA
                String url = cursor.getString(cursor.getColumnIndexOrThrow(MediaStore.Audio.Media.DATA));
                //歌曲的总播放时长 ：MediaStore.Audio.Media.DURATION
                int duration = cursor.getInt(cursor.getColumnIndexOrThrow(MediaStore.Audio.Media.DURATION));
                //歌曲文件的大小 ：MediaStore.Audio.Media.SIZE
                Long size = cursor.getLong(cursor.getColumnIndexOrThrow(MediaStore.Audio.Media.SIZE));

                if(size > 1024*800){
                    HashMap<String, Object> map = new HashMap<>();
                    map.put("id", id);
                    map.put("songTitle", title);
                    map.put("songFileUrl", url);
//                    map.put("music_file_name", title);
                    map.put("singer",singer);
//                    map.put("music_url",url);
//                    map.put("music_duration",duration);
                    map.put("album",album);
//                    map.put("music_size",size);
                    musics.add(map);
                }
//                System.out.println("android: "+title);
                cursor.moveToNext();
            }
        }
        cursor.close();
        return musics;
    }
}
