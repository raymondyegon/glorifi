package com.glorifi.mobile;

import android.app.Application;

public class GlorifiApplication extends Application {
    private static GlorifiApplication mContext;

    @Override
    public void onCreate() {
        super.onCreate();
        mContext = this;
    }

    public static GlorifiApplication getContext() {
        return mContext;
    }
}
