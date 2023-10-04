package com.glorifi.mobile

import android.annotation.SuppressLint
import android.app.KeyguardManager
import android.content.Intent
import android.os.Handler
import android.os.Looper
import android.text.TextUtils
import android.util.Log
import android.widget.Toast
import com.akaita.myapplication.Biometric
import com.okta.oidc.*
import com.okta.oidc.clients.sessions.SessionClient
import com.okta.oidc.clients.web.WebAuthClient
import com.okta.oidc.storage.security.GuardedEncryptionManager
import com.okta.oidc.storage.SharedPreferenceStorage
import com.okta.oidc.storage.security.DefaultEncryptionManager
import com.okta.oidc.storage.security.EncryptionManager
import com.okta.oidc.util.AuthorizationException
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import android.os.Build
import android.provider.Settings
import android.provider.Settings.EXTRA_BIOMETRIC_AUTHENTICATORS_ALLOWED
import androidx.biometric.BiometricManager
import android.hardware.fingerprint.FingerprintManager
import android.content.Context

import java.util.*

class MainActivity : FlutterFragmentActivity() {
    val APP_CHANNEL_NAME = "okta_flutter_bridge"
    val AUTHENTICATOR_CHANNEL_NAME = "LOCAL_BIO"
    var mResult: MethodChannel.Result? = null
    var idpValue: String? = null;

    private var keyguardEncryptionManager: EncryptionManager? = null

    /**
     * Authorization client using chrome custom tab as a user agent.
     */
    private lateinit var webAuth: WebAuthClient // <1>

    /**
     * The authorized client to interact with Okta's endpoints.
     */
    private lateinit var sessionClient: SessionClient // <2>


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        MethodChannel(
            flutterEngine.dartExecutor,
            APP_CHANNEL_NAME
        ).setMethodCallHandler { call, xResult ->
            mResult = xResult;
            when (call.method) {
                "initOkta" -> {
//                    if(isKeyguardSecure()) {
//                        keyguardEncryptionManager = GuardedEncryptionManager(
//                            this,
//                            15
//                        )
//                        keyguardEncryptionManager!!.recreateCipher();
//                    } else {
                    keyguardEncryptionManager = DefaultEncryptionManager(this)
//                    }


                    setupWebAuth(call)
                    setupWebAuthCallback(webAuth, sessionClient)

                    xResult.success("true")
                }
                "authenticate" -> {
                    val payload = AuthenticationPayload.Builder()
                        .setIdp(idpValue)
                        .setLoginHint(call.argument<String>("loginHint"))
                        .addParameter("prompt", "login")
                        .build()

                    if(call.argument<String>("isNewAccount") == "true"){
                        webAuth.sessionClient?.clear()
                    }

                    webAuth.signIn(this, payload)

                }
                "oktaLogOut" -> {
                    try {
                        webAuth.signOut(this, getSignOutCallback())
                    } catch (e: Exception) {
                        print(e);
                        xResult.success("false")
                    }
                    xResult.success("true")
                }
                "openSettingsPage" -> {
                    val intent: Intent = when {
                        Build.VERSION.SDK_INT >= Build.VERSION_CODES.R -> {
                            Intent(Settings.ACTION_BIOMETRIC_ENROLL).putExtra(
                                EXTRA_BIOMETRIC_AUTHENTICATORS_ALLOWED,
                                BiometricManager.Authenticators.BIOMETRIC_STRONG
                            )
                        }
                        Build.VERSION.SDK_INT >= Build.VERSION_CODES.P -> {
                            Intent(Settings.ACTION_FINGERPRINT_ENROLL)
                        }
                        else -> {
                            Intent(Settings.ACTION_SECURITY_SETTINGS)
                        }
                    }
                    try {
                        startActivity(intent)
                    } catch (e: Exception) {
                        print(e)
                        startActivity(Intent(Settings.ACTION_SETTINGS))
                    }
                }
            }
        }

        MethodChannel(
            flutterEngine.dartExecutor,
            AUTHENTICATOR_CHANNEL_NAME
        ).setMethodCallHandler { call, xResult ->
            when (call.method) {
                "hasFingerprint" -> xResult.success(deviceHasEnrolledFingerprint())
            }
        }

        GeneratedPluginRegistrant.registerWith(flutterEngine)
        super.configureFlutterEngine(flutterEngine)
    }

    private fun deviceHasEnrolledFingerprint(): Boolean {
        try {
            /**
             * Android has no way to detect the authentication system using newer BiometricManager
             * using Biometric BiometricManager.canAuthenticate(int authenticators) can not determine-
             * -which authentication is being used (eg -face, iris, fingerprint)
             * BiometricManager has so many issue's right now like -
             * https://issuetracker.google.com/issues/111315641
             * https://issuetracker.google.com/issues/147374428
             * As this app is only using Fingerprint,
             * That's why using deprecated FingerprintManager which works fine until now
             */
            val fingerprintManager =
                getSystemService(Context.FINGERPRINT_SERVICE) as FingerprintManager
            if (fingerprintManager.isHardwareDetected && fingerprintManager.hasEnrolledFingerprints()) {
                //device has enrolled fingerprint
                return true;
            }
        } catch (e: Exception) {
            val biometricManager = BiometricManager.from(this)
            val status =
                biometricManager.canAuthenticate(BiometricManager.Authenticators.BIOMETRIC_STRONG)

            if (status == BiometricManager.BIOMETRIC_SUCCESS) {
                //device has strong biometric (can be fingerprint, face or iris)
                return true;
            }
        }

        return false;
    }

    private fun biometricAuthSuccessEvent(
        mResult: MethodChannel.Result?,
        sessionClient: SessionClient?
    ) {
        if (mResult == null) {
            return
        }
        if (sessionClient == null) {
            return
        }
        Toast.makeText(
            GlorifiApplication.getContext(), "Login Successful",
            Toast.LENGTH_LONG
        ).show()

        //client is authorized.
        try {
            val tokens = sessionClient.tokens
            val DtsFeed: HashMap<String, Any?> = HashMap()
            DtsFeed["success"] = true;
            DtsFeed["access"] =
                if (TextUtils.isEmpty(tokens.accessToken)) "null" else tokens.accessToken
            DtsFeed["refresh"] =
                if (TextUtils.isEmpty(tokens.refreshToken)) "null" else tokens.refreshToken
            mResult.success(DtsFeed)
        } catch (e: AuthorizationException) {
            e.printStackTrace()
            onAuthFailed(mResult, "${e.message}")
        }
    }

    private fun onAuthFailed(result: MethodChannel.Result?, error: String){
        val reponse: HashMap<String, Any?> = HashMap()
        reponse["success"] = false
        reponse["error"] = error
        mResult?.success(reponse)
    }

    private fun isKeyguardSecure(): Boolean {
        val keyguardManager = getSystemService(KEYGUARD_SERVICE) as KeyguardManager
        return keyguardManager.isKeyguardSecure
    }

    private fun setupWebAuth(call: MethodCall) {
        idpValue = call.argument<String>("idp")!!
        val scopes = call.argument<String>("scopes")!!
        val oidcConfig = OIDCConfig.Builder()
            .clientId(call.argument<String>("clientId")!!)
            .redirectUri(call.argument<String>("redirectUri")!!)
            .endSessionRedirectUri(call.argument<String>("logoutRedirectUri")!!)
            .scopes(scopes)
            .discoveryUri(call.argument<String>("issuer")!!)
            .create()

        webAuth = Okta.WebAuthBuilder()
            .withConfig(oidcConfig)
            .withContext(applicationContext)
            .withCallbackExecutor(null)
//            .withStorage(SharedPreferenceStorage(this))
            .setRequireHardwareBackedKeyStore(false)
            .withEncryptionManager(keyguardEncryptionManager)
            .create()

        sessionClient = webAuth.sessionClient

    }

    private fun getSignOutCallback(): RequestCallback<Int, AuthorizationException> {
        return object : RequestCallback<Int, AuthorizationException> {
            override fun onSuccess(result: Int) {
                sessionClient.clear()
            }

            override fun onError(msg: String?, exception: AuthorizationException?) {
                Log.d("HomeActivity", "Error: $msg")
            }
        }
    }

    private fun setupWebAuthCallback(
        webAuth: WebAuthClient,
        sessionClient: SessionClient
    ) {
        val callback: ResultCallback<AuthorizationStatus, AuthorizationException> =
            object : ResultCallback<AuthorizationStatus, AuthorizationException> {
                override fun onSuccess(status: AuthorizationStatus) {
                    if (status == AuthorizationStatus.AUTHORIZED) {
                        // Check whether the user has already authenticated using the device's authentication method. If it hasn't, ask them to do it
                        if (webAuth.getSessionClient().isAuthenticated()) {
                            biometricAuthSuccessEvent(mResult, sessionClient)
                        } else {
                            biometricAuthSuccessEvent(mResult, sessionClient)
                        }
                    } else if (status == AuthorizationStatus.SIGNED_OUT) {
                        Log.d("MainActivity", "SIGNED_OUT")
                        Toast.makeText(this@MainActivity, "Signed out", Toast.LENGTH_SHORT).show()
                    }
                }

                override fun onCancel() {
                    Log.d("MainActivity", "CANCELED")
                    sessionClient.clear()
                    Toast.makeText(this@MainActivity, "Cancelled", Toast.LENGTH_SHORT).show()
                    onAuthFailed(mResult, "Canceled by user")
                }

                override fun onError(msg: String?, error: AuthorizationException?) {
                    Log.d("MainActivity", "${error?.error} onError", error)
                    sessionClient.clear()
//                    Toast.makeText(
//                        this@MainActivity,
//                        "Authorization Error - Please Try again",
//                        Toast.LENGTH_SHORT
//                    ).show()
                    onAuthFailed(mResult, "${error?.message}")
                }
            }
        webAuth.registerCallback(callback, this)
    }

    private fun showKeyguard() {
        Biometric(
            fragmentActivity = this,
            onSuccessListener = {
                runOnUiThread {
                    biometricAuthSuccessEvent(mResult, sessionClient)
                }
            },
            onCancelListener = {
                runOnUiThread {
                    Log.d("MainActivity", "Biometric authentication cancelled")
                    val msg = "Biometric authentication cancelled"
                    Toast.makeText(this@MainActivity, msg, Toast.LENGTH_LONG).show()
                    onAuthFailed(mResult, msg)
                    finish()
                }
            },
            onErrorListener = { code, message ->
                runOnUiThread {
                    Log.d("MainActivity", "Biometric authentication failed")
                    Toast.makeText(
                        this@MainActivity,
                        "Biometric authentication failed",
                        Toast.LENGTH_LONG
                    ).show()
                    onAuthFailed(mResult, message)
                    finish()
                }
            }).show()
    }
}

