importScripts('https://global.oktacdn.com/okta-signin-widget/6.2.0/js/okta-sign-in.min.js');

self.addEventListener('sync', function (event) {
    if (event.tag == 'myFirstSync') {
        event.waitUntil(syncContent());
    }
});

async function syncContent() {
    console.log(window.localStorage.getItem("options"));
    signIn = new OktaSignIn(JSON.parse(window.localStorage.getItem("options")));
    signIn.authClient.start();
    const tokens = await signIn.authClient.token.getWithoutPrompt();
    console.log("FETCHING NEW TOKEN");
    console.log(tokens);
    console.log(tokens.tokens.accessToken.accessToken);
    window.localStorage.setItem("flutter.token", JSON.stringify(tokens.tokens.accessToken.accessToken));
}