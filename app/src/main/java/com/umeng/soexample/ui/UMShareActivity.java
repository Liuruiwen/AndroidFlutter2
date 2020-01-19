package com.umeng.soexample.ui;

import android.content.Context;
import android.content.Intent;
import android.content.res.Configuration;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;

import com.umeng.socialize.UMShareAPI;
import com.umeng.socialize.bean.SHARE_MEDIA;
import com.umeng.socialize.shareboard.SnsPlatform;
import com.umeng.socialize.utils.ShareBoardlistener;
import com.umeng.soexample.R;
import com.umeng.soexample.until.CustomShareListener;
import com.umeng.soexample.until.ShareManager;

import androidx.appcompat.app.AppCompatActivity;
import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * @author Auser
 * @create 2019-03-27
 * @Describe 友盟分享
 */
public class UMShareActivity extends AppCompatActivity {
    @BindView(R.id.btn_share)
    Button btnShare;
    private CustomShareListener customShareListener;
    private ShareManager shareManager;

    public static Intent getIntent(Context context) {
        return new Intent(context, UMShareActivity.class);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_umshare);
        ButterKnife.bind(this);
        customShareListener = new CustomShareListener(this) {
            @Override
            public void onResult(SHARE_MEDIA platform) {
                super.onResult(platform);

                if (platform.name().equals("WEIXIN_FAVORITE")) {
                    Toast.makeText(UMShareActivity.this, platform + " 收藏成功啦", Toast.LENGTH_SHORT).show();
                    btnShare.setText("收藏成功啦");
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
                        btnShare.setText("分享成功啦");
                        Toast.makeText(UMShareActivity.this, platform + " 分享成功啦", Toast.LENGTH_SHORT).show();
                    }

                }

            }
        };
        /*增加自定义按钮的分享面板*/

        shareManager=new ShareManager(this, new ShareBoardlistener() {
            @Override
            public void onclick(SnsPlatform snsPlatform, SHARE_MEDIA share_media) {
                 shareManager.showShare(share_media,"http://www.xinxinfangche.com/","欣新房车","一个新的房车时代",
                         "https://gss3.bdstatic.com/-Po3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike80%2C5%2C5%2C80%2C26/sign=2eddb34afddeb48fef64a98c9176514c/0b55b319ebc4b745908e9e3dc1fc1e178a821586.jpg"
                 ,customShareListener);
            }
        });

//        mShareAction = new ShareAction(this).setDisplayList(
//                SHARE_MEDIA.WEIXIN, SHARE_MEDIA.WEIXIN_CIRCLE, SHARE_MEDIA.WEIXIN_FAVORITE,
//                SHARE_MEDIA.QQ, SHARE_MEDIA.QZONE)
//                .addButton("复制文本", "复制文本", "umeng_socialize_copy", "umeng_socialize_copy")
//                .addButton("复制链接", "复制链接", "umeng_socialize_copyurl", "umeng_socialize_copyurl")
//                .setShareboardclickCallback(new ShareBoardlistener() {
//                    @Override
//                    public void onclick(SnsPlatform snsPlatform, SHARE_MEDIA share_media) {
//                        if (snsPlatform.mShowWord.equals("复制文本")) {
//                            Toast.makeText(UMShareActivity.this, "复制文本按钮", Toast.LENGTH_LONG).show();
//                        } else if (snsPlatform.mShowWord.equals("复制链接")) {
//                            Toast.makeText(UMShareActivity.this, "复制链接按钮", Toast.LENGTH_LONG).show();
//
//                        } else {
//                            UMWeb web = new UMWeb(AppConfig.url);
//                            web.setTitle("欣新房车");
//                            web.setDescription("一个房车新时代");
//                            web.setThumb(new UMImage(UMShareActivity.this, R.drawable.house_car));
//                            new ShareAction(UMShareActivity.this).withMedia(web)
//                                    .setPlatform(share_media)
//                                    .setCallback(mShareListener)
//                                    .share();
//                        }
//                    }
//                });
        findViewById(R.id.btn_share).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                shareManager.open();
            }
        });
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        /** attention to this below ,must add this**/
        UMShareAPI.get(this).onActivityResult(requestCode, resultCode, data);
    }

    /**
     * 屏幕横竖屏切换时避免出现window leak的问题
     */
    @Override
    public void onConfigurationChanged(Configuration newConfig) {
        super.onConfigurationChanged(newConfig);
        shareManager.close();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        UMShareAPI.get(this).release();
    }

}
