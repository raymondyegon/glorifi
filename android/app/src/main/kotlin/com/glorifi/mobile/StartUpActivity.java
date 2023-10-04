package com.glorifi.mobile;

import android.app.KeyguardManager;
import android.content.Context;
import android.content.Intent;
import android.widget.Toast;

import androidx.annotation.NonNull;

import com.okta.oidc.AuthorizationStatus;
import com.okta.oidc.OIDCConfig;
import com.okta.oidc.Okta;
import com.okta.oidc.ResultCallback;
import com.okta.oidc.Tokens;
import com.okta.oidc.clients.sessions.SessionClient;
import com.okta.oidc.clients.web.WebAuthClient;
import com.okta.oidc.storage.SharedPreferenceStorage;
import com.okta.oidc.storage.security.GuardedEncryptionManager;
import com.okta.oidc.util.AuthorizationException;

import java.util.Objects;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class StartUpActivity extends FlutterActivity {

    private static final String APP_CHANNEL_NAME = "okta_flutter_bridge";
    private OIDCConfig config;
    private WebAuthClient webClient;
    private GuardedEncryptionManager keyguardEncryptionManager;
    private static final int REQUEST_CODE_CREDENTIALS = 1000;
    private SessionClient sessionClient;
    private MethodChannel.Result mResult;
    private final static String FIRE_FOX = "org.mozilla.firefox";
    private final static String ANDROID_BROWSER = "com.android.browser";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        new MethodChannel(flutterEngine.getDartExecutor(), APP_CHANNEL_NAME).setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, MethodChannel.Result xResult) {
                        mResult = xResult;
                        switch (call.method) {
                            case "initOkta": {
                                keyguardEncryptionManager = new GuardedEncryptionManager(StartUpActivity.this, Integer.MAX_VALUE);
                                String[] scopes = new String[]{Objects.requireNonNull(call.argument("scopes")), "offline_access",};
                                String[] scopes1 = new String[]{"openid", "profile", "offline_access"};
                                config = new OIDCConfig.Builder()
                                        .clientId(Objects.requireNonNull(call.argument("clientId")))
                                        .redirectUri(Objects.requireNonNull(call.argument("redirectUri")))
                                        .endSessionRedirectUri(Objects.requireNonNull(call.argument("logoutRedirectUri")))
                                        .scopes(scopes1)
                                        .discoveryUri(Objects.requireNonNull(call.argument("discovery_uri")))
                                        .create();

                                webClient = new Okta.WebAuthBuilder()
                                        .withConfig(config)
                                        .withContext(getApplicationContext())
                                        .withStorage(new SharedPreferenceStorage(StartUpActivity.this))
                                        .setCacheMode(false)
                                        .supportedBrowsers(ANDROID_BROWSER, FIRE_FOX)
                                        .setRequireHardwareBackedKeyStore(false)
                                        .withEncryptionManager(keyguardEncryptionManager)
                                        .create();

                                if (webClient != null) {
                                    mResult.success("true");
                                } else {
                                    mResult.error("Error", "Error", null);
                                }

                                break;
                            }
                            case "authenticate": {
                                sessionClient = webClient.getSessionClient();
                                webClient.registerCallback(new ResultCallback<AuthorizationStatus, AuthorizationException>() {
                                    @Override
                                    public void onSuccess(@NonNull AuthorizationStatus status) {
                                        if (status == AuthorizationStatus.AUTHORIZED) {

                                            if (sessionClient.isAuthenticated()) {
                                                if (!keyguardEncryptionManager.isUserAuthenticatedOnDevice()) {
                                                    showKeyguard();
                                                } else {
                                                    biometricAuthSuccessEvent(mResult, sessionClient);
                                                }
                                            }
                                        } else if (status == AuthorizationStatus.SIGNED_OUT) {
                                            //this only clears the browser session.
                                        }
                                    }

                                    @Override
                                    public void onCancel() {
                                        //authorization canceled
                                        mResult.error("UNAVAILABLE", "Authorization Cancelled", null);
                                    }

                                    @Override
                                    public void onError(@NonNull String msg, AuthorizationException error) {
                                        //error encounted
                                        mResult.error(String.valueOf(error.code), error.errorDescription, null);
                                    }
                                }, StartUpActivity.this);
                                try {
//                                    if (isKeyguardSecure()) {
//                                        if (!keyguardEncryptionManager.isUserAuthenticatedOnDevice()) {
//                                            showKeyguard();
//                                        }
//                                    } else {
                                    webClient.signIn(StartUpActivity.this, null);
//                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                                break;
                            }
                        }
                    }
                }
        );
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        super.configureFlutterEngine(flutterEngine);
    }

    private void biometricAuthSuccessEvent(MethodChannel.Result mResult, SessionClient sessionClient) {
        if(mResult == null) {
            return;
        }
        if(sessionClient == null) {
            return;
        }
        Toast.makeText(GlorifiApplication.getContext(), "Login Successful",
                Toast.LENGTH_LONG).show();
        mResult.success(true);
        //client is authorized.
        try {
            Tokens tokens = sessionClient.getTokens();
        } catch (AuthorizationException e) {
            e.printStackTrace();
        }
    }

    private boolean isKeyguardSecure() {
        KeyguardManager keyguardManager =
                (KeyguardManager) getSystemService(Context.KEYGUARD_SERVICE);
        return keyguardManager.isKeyguardSecure();
    }

    private void showKeyguard() {
        KeyguardManager keyguardManager =
                (KeyguardManager) getSystemService(Context.KEYGUARD_SERVICE);
        Intent intent = null;
        intent = keyguardManager.createConfirmDeviceCredentialIntent("Confirm credentials", "");
        if (intent != null) {
            startActivityForResult(intent, REQUEST_CODE_CREDENTIALS);
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == REQUEST_CODE_CREDENTIALS && resultCode == RESULT_OK) {
            if (keyguardEncryptionManager.getCipher() == null) {
                keyguardEncryptionManager.recreateCipher();
            }
            biometricAuthSuccessEvent(mResult,sessionClient);
        } else {
            webClient.handleActivityResult(requestCode, resultCode, data);
        }
    }
}
