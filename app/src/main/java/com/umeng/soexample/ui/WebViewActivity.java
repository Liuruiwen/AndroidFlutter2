package com.umeng.soexample.ui;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.webkit.WebView;
import android.webkit.WebViewClient;

import com.google.gson.Gson;
import com.umeng.soexample.R;
import com.umeng.soexample.bean.WebBean;

import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.AppCompatTextView;
import androidx.constraintlayout.widget.ConstraintLayout;
import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * 简单写个WebView
 */
public class WebViewActivity extends AppCompatActivity {

    @BindView(R.id.constrainLayout)
    ConstraintLayout constrainLayout;
    @BindView(R.id.tv_title)
    AppCompatTextView tvTitle;
    @BindView(R.id.webView)
    WebView mWebView;
    public static Intent getIntent(Context context,String web) {
        return new Intent(context, WebViewActivity.class)
                .putExtra("web",web);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_web_view);
        ButterKnife.bind(this);
        initView();
    }

    public void onClick(View view){
        finish();
    }

    @SuppressLint("SetJavaScriptEnabled")
    private void initView(){
        WebBean bean=new Gson().fromJson(getIntent().getStringExtra("web"),WebBean.class);
        tvTitle.setText(bean.title);
        mWebView.getSettings().setJavaScriptEnabled(true);
        mWebView.setWebViewClient(new WebViewClient(){
            @Override
            public void onPageFinished(WebView view, String url) {
                super.onPageFinished(view, url);
                String title = view.getTitle();
                if (!TextUtils.isEmpty(title)) {
                    tvTitle.setText(title);
                }
            }
        });
        mWebView.loadUrl(bean.url);
    }


    @Override
    protected void onDestroy() {
        destroyWebView();
        super.onDestroy();
    }

    private void destroyWebView() {
        if(mWebView != null) {
            mWebView.clearHistory();
            mWebView.clearCache(true);
            mWebView.loadUrl("about:blank"); // clearView() should be changed to loadUrl("about:blank"), since clearView() is deprecated now
            mWebView.freeMemory();
            mWebView.pauseTimers();
            mWebView = null; // Note that mWebView.destroy() and mWebView = null do the exact same thing
        }

        if(constrainLayout!=null){
            constrainLayout.removeAllViews();
        }


    }
}
