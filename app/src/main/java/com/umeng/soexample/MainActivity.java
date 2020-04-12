package com.umeng.soexample;


import android.Manifest;
import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Color;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.provider.Settings;
import android.text.TextUtils;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.FrameLayout;
import android.widget.Toast;

import com.amap.api.location.AMapLocation;
import com.amap.api.location.AMapLocationClient;
import com.amap.api.location.AMapLocationClientOption;
import com.amap.api.location.AMapLocationListener;
import com.google.gson.Gson;
import com.umeng.socialize.UMAuthListener;
import com.umeng.socialize.UMShareAPI;
import com.umeng.socialize.bean.SHARE_MEDIA;
import com.umeng.socialize.shareboard.SnsPlatform;
import com.umeng.socialize.utils.ShareBoardlistener;
import com.umeng.socialize.utils.SocializeUtils;
import com.umeng.soexample.base.BaseActivity;
import com.umeng.soexample.bean.ShareBean;
import com.umeng.soexample.ui.MapActivity;
import com.umeng.soexample.ui.WebViewActivity;
import com.umeng.soexample.until.CustomShareListener;
import com.umeng.soexample.until.LoginOutListener;
import com.umeng.soexample.until.ShareManager;

import java.util.Map;

import androidx.appcompat.app.AlertDialog;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;
import io.flutter.embedding.android.FlutterView;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.dart.DartExecutor;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;


import static androidx.core.content.PermissionChecker.PERMISSION_GRANTED;
/**
 * Created by Amuse
 * Date:2019/12/6.
 * Desc:
 */
public class MainActivity extends BaseActivity implements ShareBoardlistener {
    private MethodChannel mMethodChannel;
    private FrameLayout mainFrameLayout;
    private String METHOD_CHANNER = "com.umeng.soexample";
    private ProgressDialog dialog;
    private CustomShareListener customShareListener;
    private ShareBean _shareBean;
    private ShareManager shareManager;
    private static final int NOT_NOTICE = 2;
    private AlertDialog alertDialog;
    private AlertDialog mDialog;
    private FlutterView flutterView;
    public AMapLocationClient mLocationClient = null;
    public AMapLocationClientOption mLocationOption = null;
    private  boolean isMain=false;
    FlutterEngine flutterEngine;
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
        flutterView=new FlutterView(this);

        // 关键代码，将Flutter页面显示到FlutterView中
         flutterEngine = new FlutterEngine(this);
        flutterEngine.getNavigationChannel().setInitialRoute("main");
        flutterEngine.getDartExecutor().executeDartEntrypoint(
                DartExecutor.DartEntrypoint.createDefault()
        );
        flutterView.attachToFlutterEngine(flutterEngine);
        mainFrameLayout.addView(flutterView);
        mMethodChannel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), METHOD_CHANNER);
        initListener();
        requestPermission();

    }
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        UMShareAPI.get(this).onActivityResult(requestCode, resultCode, data);
        if(requestCode==NOT_NOTICE){
            requestPermission();//由于不知道是否选择了允许所以需要再次判断
        }
    }

    @Override
    protected void onDestroy() {
        if(flutterEngine!=null){
            flutterEngine.destroy();
        }

        if(flutterView!=null){
            flutterView.removeAllViews();
        }
        if(mainFrameLayout!=null){
            mainFrameLayout.removeAllViews();
        }
        super.onDestroy();

        UMShareAPI.get(this).release();

    }

    @Override
    public void onBackPressed() {
//        super.onBackPressed();

        if(this.flutterView!=null && flutterEngine!=null && isMain==false){
                flutterEngine.getNavigationChannel().popRoute();
        }else {
            super.onBackPressed();
        }
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
                    case "bool_main":
                           isMain= (boolean) methodCall.arguments;
                           if(isMain){
                               finish();
                           }
                        break;
                    case "map":
                        startActivity(MapActivity.getIntent(MainActivity.this));
                        break;
                    case "web":
                        startActivity(WebViewActivity.getIntent(MainActivity.this,methodCall.arguments.toString()));
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
                    case "state_color":
                        setStatusBarColor(MainActivity.this,methodCall.arguments.toString());
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

    @Override
    public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);

        if (requestCode == 1) {
            for (int i = 0; i < permissions.length; i++) {
                if (grantResults[i] == PERMISSION_GRANTED) {//选择了“始终允许”
                    Toast.makeText(this, "" + "权限" + permissions[i] + "申请成功", Toast.LENGTH_SHORT).show();
                    initGps();
                } else {
                    if (!ActivityCompat.shouldShowRequestPermissionRationale(this, permissions[i])){//用户选择了禁止不再询问

                        AlertDialog.Builder builder = new AlertDialog.Builder(MainActivity.this);
                        builder.setTitle("permission")
                                .setMessage("点击允许才能定位当前位置哦")
                                .setPositiveButton("去允许", new DialogInterface.OnClickListener() {
                                    public void onClick(DialogInterface dialog, int id) {
                                        if (mDialog != null && mDialog.isShowing()) {
                                            mDialog.dismiss();
                                        }
                                        Intent intent = new Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS);
                                        Uri uri = Uri.fromParts("package", getPackageName(), null);//注意就是"package",不用改成自己的包名
                                        intent.setData(uri);
                                        startActivityForResult(intent, NOT_NOTICE);
                                    }
                                });
                        mDialog = builder.create();
                        mDialog.setCanceledOnTouchOutside(false);
                        mDialog.show();



                    }else {//选择禁止
                        AlertDialog.Builder builder = new AlertDialog.Builder(MainActivity.this);
                        builder.setTitle("permission")
                                .setMessage("点击允许才能定位当前位置哦")
                                .setPositiveButton("去允许", new DialogInterface.OnClickListener() {
                                    public void onClick(DialogInterface dialog, int id) {
                                        if (alertDialog != null && alertDialog.isShowing()) {
                                            alertDialog.dismiss();
                                        }
                                        ActivityCompat.requestPermissions(MainActivity.this,
                                                new String[]{Manifest.permission.ACCESS_COARSE_LOCATION}, 1);
                                    }
                                });
                        alertDialog = builder.create();
                        alertDialog.setCanceledOnTouchOutside(false);
                        alertDialog.show();
                    }

                }
            }
        }
    }


    private void requestPermission() {
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) != PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.ACCESS_COARSE_LOCATION}, 1);
        }else {
            initGps();
        }
    }

    private  void initGps(){
        mLocationClient = new AMapLocationClient(getApplicationContext());
        mLocationClient.setLocationListener( new AMapLocationListener() {
            @Override
            public void onLocationChanged(AMapLocation location) {
                mMethodChannel.invokeMethod("gps",location.getCity());
            }
        });
        mLocationOption = new AMapLocationClientOption();
        AMapLocationClientOption option = new AMapLocationClientOption();
        option.setLocationPurpose(AMapLocationClientOption.AMapLocationPurpose.SignIn);
        if(null != mLocationClient){
            mLocationClient.setLocationOption(option);
            mLocationClient.stopLocation();
            mLocationClient.startLocation();
        }

        mLocationOption.setLocationMode(AMapLocationClientOption.AMapLocationMode.Hight_Accuracy);
    }

    public  void setStatusBarColor(Activity activity,String  color) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            Window window = activity.getWindow();
            window.clearFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS);
            window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS);
            window.setStatusBarColor(Color.parseColor(color));

        }
    }

}
