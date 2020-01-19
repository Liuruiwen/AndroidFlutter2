package com.umeng.soexample.until;

import android.app.Activity;

import com.umeng.socialize.ShareAction;
import com.umeng.socialize.UMShareListener;
import com.umeng.socialize.bean.SHARE_MEDIA;
import com.umeng.socialize.media.UMImage;
import com.umeng.socialize.media.UMWeb;
import com.umeng.socialize.utils.ShareBoardlistener;


/**
 * @author Auser
 * @create 2019-03-27
 * @Desc:分享管理
 */

public class ShareManager extends ShareAction {

    private Activity mActivity;
    public ShareManager(Activity activity, ShareBoardlistener boardListener) {
        super(activity);
        mActivity=activity;
        this.setDisplayList(
                SHARE_MEDIA.WEIXIN, SHARE_MEDIA.WEIXIN_CIRCLE, SHARE_MEDIA.WEIXIN_FAVORITE,
                SHARE_MEDIA.QQ, SHARE_MEDIA.QZONE)
                .setShareboardclickCallback(boardListener);
    }


    /**
     *
     * 分享链接
     * @param share_media 分享的类型微信、QQ
     * @param url 分享的链接地址
     * @param title 分享的标题
     * @param content 分享的内容
     * @param drawable 分享的drawable图片
     * @param umShareListener 分享流程监听
     * @param <T>
     */
    public <T extends UMShareListener>void showShare(SHARE_MEDIA share_media, String url, String title, String content, int drawable, T umShareListener){
        UMWeb web = new UMWeb(url);
        web.setTitle(title);
        web.setDescription(content);
        web.setThumb(new UMImage(mActivity,drawable));
        shareWebContent(share_media,web,umShareListener);
    }

    /**
     *
     * 分享链接
     * @param share_media 分享的类型微信、QQ
     * @param url 分享的链接地址
     * @param title 分享的标题
     * @param content 分享的内容
     * @param imgUrl 分享的网络图片地址
     * @param umShareListener 分享流程监听
     * @param <T>
     */
    public <T extends UMShareListener>void showShare(SHARE_MEDIA share_media, String url, String title, String content, String imgUrl, T umShareListener){
        UMWeb web = new UMWeb(url);
        web.setTitle(title);
        web.setDescription(content);
        web.setThumb(new UMImage(mActivity,imgUrl));
        shareWebContent(share_media,web,umShareListener);
    }


    public void shareWebContent(SHARE_MEDIA share_media, UMWeb umWeb, UMShareListener umShareListener){
        new ShareAction(mActivity).withMedia(umWeb)
                .setPlatform(share_media)
                .setCallback(umShareListener)
                .share();
    }

}
