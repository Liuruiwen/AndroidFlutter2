package com.umeng.soexample.ui;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;

import com.umeng.soexample.R;

import androidx.annotation.Nullable;

/**
 * Created by Amuse
 * Date:2019/11/30.
 * Desc:
 */
public class TestActivity  extends Activity {
    public static Intent getIntent(Context context) {
        return new Intent(context, TestActivity.class);
    }
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
    }
}
