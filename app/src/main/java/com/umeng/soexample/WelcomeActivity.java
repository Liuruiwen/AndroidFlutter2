package com.umeng.soexample;


import android.os.CountDownTimer;
import android.view.View;
import android.widget.TextView;

import com.umeng.soexample.base.BaseActivity;
/**
 * Created by Amuse
 * Date:2019/12/6.
 * Desc:
 */
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
                int count= (int) (millisUntilFinished / 1000);
                tvClick.setText(String.format("跳转%1$s",count));
                if(count<1){
                    tvClick.setText("跳转");
                    action();
                    return;
                }


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


