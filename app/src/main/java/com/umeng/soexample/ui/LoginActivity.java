package com.umeng.soexample.ui;

import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Toast;

import com.umeng.soexample.R;
import com.umeng.socialize.UMAuthListener;
import com.umeng.socialize.UMShareAPI;
import com.umeng.socialize.bean.SHARE_MEDIA;
import com.umeng.socialize.utils.SocializeUtils;
import com.umeng.soexample.until.LoginOutListener;

import java.util.Map;

import androidx.appcompat.app.AppCompatActivity;

///https://github.com/umeng/MultiFunctionAndroidDemo
import androidx.appcompat.widget.AppCompatEditText;
import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class LoginActivity extends AppCompatActivity {

    @BindView(R.id.et_content)
    AppCompatEditText etContent;
    private ProgressDialog dialog;

    public static Intent getIntent(Context context) {
        return new Intent(context, LoginActivity.class);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
        ButterKnife.bind(this);
        dialog = new ProgressDialog(this);
    }

    @OnClick({R.id.iv_wechat, R.id.iv_qq, R.id.btn_delete})
    public void onViewClicked(View view) {
        switch (view.getId()) {
            case R.id.iv_wechat:
                SHARE_MEDIA weixin = SHARE_MEDIA.WEIXIN;
//                if (isTrueAuthor(weixin)) {
//                    UMShareAPI.get(this).getPlatformInfo(this, weixin, authListener);
//                } else {
//                    UMShareAPI.get(this).doOauthVerify(this, weixin, authListener);
//                }
                UMShareAPI.get(LoginActivity.this).getPlatformInfo(LoginActivity.this, weixin, authListener);
                break;
            case R.id.iv_qq:
                SHARE_MEDIA qq = SHARE_MEDIA.QQ;
//                if (isTrueAuthor(qq)) {
//                    UMShareAPI.get(this).getPlatformInfo(this,qq, authListener);
//                } else {
//                    UMShareAPI.get(this).doOauthVerify(this, qq, authListener);
//                }
                UMShareAPI.get(LoginActivity.this).getPlatformInfo(LoginActivity.this, qq, authListener);
                break;
            case R.id.btn_delete:
                UMShareAPI.get(LoginActivity.this).deleteOauth(LoginActivity.this, SHARE_MEDIA.WEIXIN, new LoginOutListener(this){
                    @Override
                    public void onComplete(SHARE_MEDIA share_media, int i, Map<String, String> map) {
                        super.onComplete(share_media, i, map);
                        Toast.makeText(LoginActivity.this, "退出微信登录成功！", Toast.LENGTH_SHORT).show();
                    }
                });
                UMShareAPI.get(LoginActivity.this).deleteOauth(LoginActivity.this, SHARE_MEDIA.QQ, new LoginOutListener(this){
                    @Override
                    public void onComplete(SHARE_MEDIA share_media, int i, Map<String, String> map) {
                        super.onComplete(share_media, i, map);
                        Toast.makeText(LoginActivity.this, "退出QQ登录成功！", Toast.LENGTH_SHORT).show();
                    }
                });
                break;
        }
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

    /**
     * 是否需要授权
     *
     * @return
     */
    private boolean isTrueAuthor(SHARE_MEDIA share_media) {
        final boolean isauth = UMShareAPI.get(this).isAuthorize(this, share_media);
        return isauth;
    }

    UMAuthListener authListener = new UMAuthListener() {
        @Override
        public void onStart(SHARE_MEDIA platform) {
            SocializeUtils.safeShowDialog(dialog);
        }

        @Override
        public void onComplete(SHARE_MEDIA platform, int action, Map<String, String> data) {
            SocializeUtils.safeCloseDialog(dialog);
            StringBuilder sb = new StringBuilder();
            for (String key : data.keySet()) {
                sb.append(key).append(" : ").append(data.get(key)).append("\n");
            }
            etContent.setText(sb.toString());
            Toast.makeText(LoginActivity.this, "登录成功", Toast.LENGTH_LONG).show();
        }

        @Override
        public void onError(SHARE_MEDIA platform, int action, Throwable t) {
            SocializeUtils.safeCloseDialog(dialog);
            Toast.makeText(LoginActivity.this, "失败：" + t.getMessage(), Toast.LENGTH_LONG).show();
        }

        @Override
        public void onCancel(SHARE_MEDIA platform, int action) {
            SocializeUtils.safeCloseDialog(dialog);
            Toast.makeText(LoginActivity.this, "取消了", Toast.LENGTH_LONG).show();
        }
    };



}