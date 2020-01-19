package com.umeng.soexample;


import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.text.TextUtils;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.Toast;

import com.google.gson.Gson;
import com.umeng.socialize.UMAuthListener;
import com.umeng.socialize.UMShareAPI;
import com.umeng.socialize.bean.SHARE_MEDIA;
import com.umeng.socialize.shareboard.SnsPlatform;
import com.umeng.socialize.utils.ShareBoardlistener;
import com.umeng.socialize.utils.SocializeUtils;
import com.umeng.soexample.base.BaseActivity;
import com.umeng.soexample.bean.ShareBean;
import com.umeng.soexample.ui.LoginActivity;
import com.umeng.soexample.ui.UMShareActivity;
import com.umeng.soexample.until.CustomShareListener;
import com.umeng.soexample.until.LoginOutListener;
import com.umeng.soexample.until.ShareManager;

import java.util.Map;

import io.flutter.facade.Flutter;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.FlutterView;

///Wrong 2nd argument type:Found:'androidx.lifecycle.Lifeycle',required:'lifecy
public class MainActivity extends BaseActivity implements ShareBoardlistener {

    private MethodChannel mMethodChannel;//建立flutter连接
    private FrameLayout mainFrameLayout;
    private String METHOD_CHANNER = "com.umeng.soexample";
    private ProgressDialog dialog;
    private CustomShareListener customShareListener;
    private ShareBean _shareBean;
    private ShareManager shareManager;
    public static Intent getIntent(Context context) {
        return new Intent(context, MainActivity.class);
    }

    @Override
    protected int getLayout() {
        return R.layout.activity_main;
    }

    @Override
    protected void initView() {
        dialog = new ProgressDialog(this);
        mainFrameLayout = findViewById(R.id.main_frame_layout);
        mainFrameLayout.setVisibility(View.INVISIBLE);
        FlutterView flutterView = Flutter.createView(this, getLifecycle(), "main");
        mainFrameLayout.addView(flutterView);
        final FlutterView.FirstFrameListener[] listeners = new FlutterView.FirstFrameListener[1];
        listeners[0] = new FlutterView.FirstFrameListener() {
            @Override
            public void onFirstFrame() {
                mainFrameLayout.setVisibility(View.VISIBLE);
            }
        };
        flutterView.addFirstFrameListener(listeners[0]);
        //初始化MethodChannel
        mMethodChannel = new MethodChannel(flutterView, METHOD_CHANNER);
        initListener();

    }
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        UMShareAPI.get(this).onActivityResult(requestCode, resultCode, data);
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        UMShareAPI.get(this).release();

    }

    @Override
    protected void onSaveInstanceState(Bundle outState) {
        super.onSaveInstanceState(outState);
        UMShareAPI.get(this).onSaveInstanceState(outState);
    }

    private void initListener() {
        mMethodChannel.setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                switch (methodCall.method) {
                    case "flutter":
                        startActivity(UMShareActivity.getIntent(MainActivity.this));
                        break;
                    case "login_weixin":
                        UMShareAPI.get(MainActivity.this).getPlatformInfo(MainActivity.this, SHARE_MEDIA.WEIXIN, authListener);
                        break;
                    case "login_qq":
                        UMShareAPI.get(MainActivity.this).getPlatformInfo(MainActivity.this, SHARE_MEDIA.QQ, authListener);
                        break;
                    case "login_out":
                        if(methodCall.arguments.toString().equals("qq"))
                        {
                            UMShareAPI.get(MainActivity.this).deleteOauth(MainActivity.this, SHARE_MEDIA.QQ, new LoginOutListener(MainActivity.this){
                                @Override
                                public void onComplete(SHARE_MEDIA share_media, int i, Map<String, String> map) {
                                    super.onComplete(share_media, i, map);
                                    Toast.makeText(MainActivity.this, "退出QQ登录成功！", Toast.LENGTH_SHORT).show();
                                }
                            });

                        }else {
                            UMShareAPI.get(MainActivity.this).deleteOauth(MainActivity.this, SHARE_MEDIA.WEIXIN, new LoginOutListener(MainActivity.this){
                                @Override
                                public void onComplete(SHARE_MEDIA share_media, int i, Map<String, String> map) {
                                    super.onComplete(share_media, i, map);
                                    Toast.makeText(MainActivity.this, "退出微信登录成功！", Toast.LENGTH_SHORT).show();
                                }
                            });
                        }
                        mMethodChannel.invokeMethod("login_out","ok");
                        break;
                    case "share":

                        if(!TextUtils.isEmpty(methodCall.arguments.toString())){
                            processShare(methodCall.arguments.toString());
                        }


                        break;
                }
            }
        });
        customShareListener = new CustomShareListener(this) {
            @Override
            public void onResult(SHARE_MEDIA platform) {
                super.onResult(platform);

                if (platform.name().equals("WEIXIN_FAVORITE")) {
                    Toast.makeText(MainActivity.this, platform + " 收藏成功啦", Toast.LENGTH_SHORT).show();
                } else {
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
                        Toast.makeText(MainActivity.this, platform + " 分享成功啦", Toast.LENGTH_SHORT).show();
                    }

                }

            }
        };
    }

    private  void processShare(String json){
        _shareBean=new Gson().fromJson(json,ShareBean.class);
        if(shareManager==null){
            shareManager=new ShareManager(MainActivity.this,this);
        }
        shareManager.open();

    }

    UMAuthListener authListener = new UMAuthListener() {
        @Override
        public void onStart(SHARE_MEDIA platform) {
            SocializeUtils.safeShowDialog(dialog);
        }

        @Override
        public void onComplete(SHARE_MEDIA platform, int action, Map<String, String> data) {
            SocializeUtils.safeCloseDialog(dialog);
            Gson gson = new Gson();
            String loginJson = gson.toJson(new LoginBean(data.get("name"),data.get("profile_image_url"),platform.getName()));
            mMethodChannel.invokeMethod("login",loginJson);
            Toast.makeText(MainActivity.this, "登录成功", Toast.LENGTH_LONG).show();
        }

        @Override
        public void onError(SHARE_MEDIA platform, int action, Throwable t) {
            SocializeUtils.safeCloseDialog(dialog);
            Toast.makeText(MainActivity.this, "授权失败：" + t.getMessage(), Toast.LENGTH_LONG).show();
        }

        @Override
        public void onCancel(SHARE_MEDIA platform, int action) {
            SocializeUtils.safeCloseDialog(dialog);
            Toast.makeText(MainActivity.this, "取消了", Toast.LENGTH_LONG).show();
        }
    };

    @Override
    public void onclick(SnsPlatform snsPlatform, SHARE_MEDIA share_media) {
          if(_shareBean!=null){
              shareManager.showShare(share_media,_shareBean.getLink(),_shareBean.getTitle(),_shareBean.getContent(), _shareBean.getImage(),customShareListener);
          }
    }

    class  LoginBean{
        String name;
        String headImage;
        String openid;

        public LoginBean(String name, String headImage, String openid) {
            this.name = name;
            this.headImage = headImage;
            this.openid = openid;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getHeadImage() {
            return headImage;
        }

        public void setHeadImage(String headImage) {
            this.headImage = headImage;
        }

        public String getPsd() {
            return openid;
        }

        public void setPsd(String openid) {
            this.openid = openid;
        }
    }


}
