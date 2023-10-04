var appUrl = getUrlParameter("appUrl");
var loginHint = getUrlParameter("user");
var issuerUrl = getUrlParameter("issuerUrl");
var bindIdIDP = getUrlParameter("idp");
var clientId = getUrlParameter("clientId");
console.log(appUrl);
var redirectUrl = appUrl + "/logincallback.html";
console.log(redirectUrl);
const authObject = {
    applicationUrl: appUrl,
    hint: loginHint,
    issuer: issuerUrl,
    idp: bindIdIDP,
    redirecturi: redirectUrl
}
window.localStorage.setItem("authObject", JSON.stringify(authObject));
options = Object.assign({
    baseUrl: "https://glorifisandbox.oktapreview.com/oauth2/aus2eh1u19laOvlWM1d7",
    clientId: '0oa22l89upDJGfZgm1d7',
    redirectUri: redirectUrl,
    issuer: issuerUrl,
    responseType: ['id_token', 'token'],
    scopes: ['openid', 'profile', 'email', 'offline_access'],
    useInteractionCodeFlow: false,
    authParams: {
        issuer: issuerUrl,
        responseType: ['id_token', 'token'],
        pkce: false,
        loginHint: loginHint,
        prompt: 'login',

    },
    idps: [
        { id: bindIdIDP, text: 'Login using BindID' }
    ],
    idpDisplay: 'PRIMARY',
    tokenManager: {
        autoRenew: true,
        storage: 'localStorage'
    },
    startService: true,
});

window.localStorage.setItem("options", JSON.stringify(options));

// Create an instance of the signin widget

// var authClient = new OktaAuth(config);
signIn = new OktaSignIn(options);

signIn.authClient.tokenManager.on('renewed', function (_key, newToken, oldToken) {
    console.log("NEW TOKEN");
    console.log(newToken);
    console.log("OLD TOKEN");
    console.log(oldToken);
});

signIn.showSignInAndRedirect({
    el: '#okta-login-container'
})
    .then(function (response) {
        console.log(response);
        signIn.authClient.start();
        // window.parent.postMessage(
        //     {
        //         event_id: 'SUCCESS',
        //         data: response
        //     },
        //     "*"
        // );
    })
    .catch(function (error) {
        console.log('login error', error);
        // window.parent.postMessage(
        //     {
        //         event_id: 'ERROR',
        //         data: error
        //     },
        //     "*"
        // );
    });

signIn.on("afterRender", (_context) => {
    const element = window.document.querySelector("#okta-login-container");
    element.style.visibility = 'collapse';
    document.querySelector('.social-auth-button').click();
});
signIn.on('afterError', function (context, error) {
    console.log(context.controller);
    // reset-password

    console.log(error.name);
    // AuthApiError

    console.log(error.message);
    // The password does not meet the complexity requirements
    // of the current password policy.

    console.log(error.statusCode);
    // window.parent.postMessage(
    //     {
    //         event_id: 'ERROR',
    //         data: error
    //     },
    //     "*"
    // );
    // 403
});

function getUrlParameter(sParam) {
    var sPageURL = window.location.search.substring(1),
        sURLVariables = sPageURL.split('&'),
        sParameterName,
        i;

    for (i = 0; i < sURLVariables.length; i++) {
        sParameterName = sURLVariables[i].split('=');

        if (sParameterName[0] === sParam) {
            return sParameterName[1] === undefined ? true : decodeURIComponent(sParameterName[1]);
        }
    }
    return false;
};

