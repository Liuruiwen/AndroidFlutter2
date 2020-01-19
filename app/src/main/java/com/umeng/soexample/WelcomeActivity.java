package com.umeng.soexample;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.os.CountDownTimer;
import android.view.View;
import android.widget.TextView;

import com.umeng.soexample.base.BaseActivity;

public class WelcomeActivity extends BaseActivity {

    private TextView tvClick;
    CountDownTimer timer;

    @Override
    protected int getLayout() {
        return R.layout.activity_welcome;
    }

    @Override
    protected void initView() {
        tvClick = findViewById(R.id.tv_click);
        tvClick.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                timer.onFinish();
                action();
            }
        });
        intiTimer();
    }

    /**
     * 初始化倒計時
     */
    private void intiTimer() {
        timer = new CountDownTimer(3000, 1000) {
            @Override
            public void onTick(long millisUntilFinished) {
                tvClick.setText(String.format("跳转%1$s", millisUntilFinished / 1000));
            }

            @Override
            public void onFinish() {
                action();
            }
        }.start();
    }

    void  action(){
       goActivity(getIntent(MainActivity.class));
        finish();
    }

    @Override
    protected void onDestroy() {
        if (timer != null) {
            timer.cancel();
        }
        super.onDestroy();
    }
}


