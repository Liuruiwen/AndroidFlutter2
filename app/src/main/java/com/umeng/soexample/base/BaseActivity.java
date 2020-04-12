package com.umeng.soexample.base;

import android.content.Intent;
import android.os.Bundle;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.view.FlutterView;

/**
 * Created by Amuse
 * Date:2019/11/30.
 * Desc:
 */
abstract public class BaseActivity  extends FlutterActivity {
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(getLayout());
        initView();
    }

     protected  Intent getIntent(Class<?> c){
        return new Intent(this,c);
     }

     protected  void goActivity(Intent ti){
        startActivity(ti);
        overridePendingTransition(0,0);
     }

    protected abstract  int getLayout();
    protected abstract  void initView();
}
