package com.umeng.soexample.until;

import android.content.Context;
import android.widget.Toast;

import com.umeng.socialize.UMShareListener;
import com.umeng.socialize.bean.SHARE_MEDIA;

import java.lang.ref.WeakReference;

/**
 * @author Auser
 * @create 2019-03-27
 * @Desc: 友盟分享监听处理
 */

public class CustomShareListener implements UMShareListener {
    private WeakReference<Context> weakContext;//软引用

    public CustomShareListener(Context context) {
        weakContext = new WeakReference(context);
    }

    @Override
    public void onStart(SHARE_MEDIA platform) {

    }

    @Override
    public void onResult(SHARE_MEDIA platform) {

//        if (platform.name().equals("WEIXIN_FAVORITE")) {
//            Toast.makeText(weakContext.get(), platform + " 收藏成功啦", Toast.LENGTH_SHORT).show();
//        } else {
//            if (platform != SHARE_MEDIA.MORE && platform != SHARE_MEDIA.SMS
//                    && platform != SHARE_MEDIA.EMAIL
//                    && platform != SHARE_MEDIA.FLICKR
//                    && platform != SHARE_MEDIA.FOURSQUARE
//                    && platform != SHARE_MEDIA.TUMBLR
//                    && platform != SHARE_MEDIA.POCKET
//                    && platform != SHARE_MEDIA.PINTEREST
//
//                    && platform != SHARE_MEDIA.INSTAGRAM
//                    && platform != SHARE_MEDIA.GOOGLEPLUS
//                    && platform != SHARE_MEDIA.YNOTE
//                    && platform != SHARE_MEDIA.EVERNOTE) {
//                Toast.makeText(weakContext.get(), platform + " 分享成功啦", Toast.LENGTH_SHORT).show();
//            }
//
//        }
    }

    @Override
    public void onError(SHARE_MEDIA platform, Throwable t) {
        if (platform != SHARE_MEDIA.MORE && platform != SHARE_MEDIA.SMS
                && platform != SHARE_MEDIA.EMAIL
                && platform != SHARE_MEDIA.FLICKR
                && platform != SHARE_MEDIA.FOURSQUARE
                && platform != SHARE_MEDIA.TUMBLR
                && platform != SHARE_MEDIA.POCKET
                && platform != SHARE_MEDIA.PINTEREST

                && platform != SHARE_MEDIA.INSTAGRAM
                && platform != SHARE_MEDIA.GOOGLEPLUS
                && platform != SHARE_MEDIA.YNOTE
                && platform != SHARE_MEDIA.EVERNOTE) {
            Toast.makeText(weakContext.get(), platform + " 分享失败啦", Toast.LENGTH_SHORT).show();

        }

    }

    @Override
    public void onCancel(SHARE_MEDIA platform) {

        Toast.makeText(weakContext.get(), platform + " 分享取消了", Toast.LENGTH_SHORT).show();
    }
}
