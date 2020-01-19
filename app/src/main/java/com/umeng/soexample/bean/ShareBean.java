package com.umeng.soexample.bean;

/**
 * Created by Amuse
 * Date:2020/1/19.
 * Desc:
 */
public class ShareBean {
    String title;
    String content;
    String image;
    String link;

    public ShareBean(String title, String content, String image, String link) {
        this.title = title;
        this.content = content;
        this.image = image;
        this.link = link;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }
}
