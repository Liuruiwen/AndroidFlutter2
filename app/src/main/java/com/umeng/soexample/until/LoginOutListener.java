package com.umeng.soexample.until;

import android.app.Activity;
import android.content.Context;
import android.widget.Toast;

import com.umeng.socialize.UMAuthListener;
import com.umeng.socialize.bean.SHARE_MEDIA;

import java.lang.ref.WeakReference;
import java.util.Map;

/**
 * @author Auser
 * @create 2019-03-27
 * @Desc: 退出登录监听
 */

public class LoginOutListener implements UMAuthListener {

    private WeakReference<Activity> weakContext;//软引用
    public LoginOutListener(Context context) {
        weakContext = new WeakReference(context);
    }
    @Override
    public void onStart(SHARE_MEDIA share_media) {

    }

    @Override
    public void onComplete(SHARE_MEDIA share_media, int i, Map<String, String> map) {

    }

    @Override
    public void onError(SHARE_MEDIA share_media, int i, Throwable throwable) {
        Toast.makeText(weakContext.get(), "退出登录失败！" , Toast.LENGTH_LONG).show();
    }

    @Override
    public void onCancel(SHARE_MEDIA share_media, int i) {

    }
}
