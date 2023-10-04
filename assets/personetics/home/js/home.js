var home = function home() {
    this.url = "../personetics/execute";
    this.initialize = function initialize() {};
    this.initialize();

    // init skin setup
    if (typeof SkinSetup !== "undefined") {
        window.skinSetup = new SkinSetup();
        window.skinSetup.init();
    }
    //TODO reset the teaserTabSelected value in ios also.
    if (typeof navigator.userAgent.match(/iPhone|iPad|iPod/i) == "undefined") {
        localStorage.removeItem("teaserTabSelected");
    }
};
var homeWeb = function homeWeb() {
    this.initialize = function initialize() {
        this.persoSessionStorage = {
            "remote-assets": {
                baseUrl: "https://client-vanilla-assets.s3.amazonaws.com/product-assets/assets",
                useRemoteAssets: true,
            },
            "context-id": {
                ctxId: "dashboard",
            },
            "dark-mode": {
                darkMode: false,
            },
            theme: {
                adjustableColoring: false,
            },
        };
        try {
            var persoSessionStorage = JSON.parse(sessionStorage.getItem("persoStorage"));
            if (persoSessionStorage != null) {
                this.persoSessionStorage = persoSessionStorage;
            }
        } catch (e) {
            console.error("Error: ", e);
        }
        this.config = {
            deviceType: "web",
            ctxId: this.persoSessionStorage["context-id"]["ctxId"],
            payload: payload,
            isPayloadEncode: true,
            baseUrl: this.persoSessionStorage["remote-assets"]["baseUrl"],
            useRemoteAssets: this.persoSessionStorage["remote-assets"]["useRemoteAssets"],
            darkMode: this.persoSessionStorage["dark-mode"]["darkMode"],
            // debugMode: Personetics.PLoggerModes.DEBUG
        };

        if (typeof payload != "undefined" && payload !== null) {
            payload = Personetics.utils.encodeDecode.Base64.encode(JSON.stringify(payload));
        } else {
            var payload = null;
        }
        // init skin setup
        window.skinSetup = new SkinSetup();
        window.skinSetup.init();

        localStorage.removeItem("teaserTabSelected");
    };
    this.initialize();

    this.getUrlParams = function getUrlParams() {
        var getParams = {
            userId: Personetics.utils.url.getParameterByName("userId"),
            pserverUrl: Personetics.utils.url.getParameterByName("pserverUrl"),
            isPredefined: Personetics.utils.url.getParameterByName("isPredefined"),
            lang: Personetics.utils.url.getParameterByName("lang"),
            teasersView: Personetics.utils.url.getParameterByName("teasersView"),
            config: Personetics.utils.url.getParameterByName("config"),
        };
        return getParams;
    };

    this.callStartWidget = function callStartWidget(config) {
        if (config.widgetType != "teaser-widget-carousel") {
            //simulate generateInsights call
            var headers = {
                authToken: config.userId,
                "Content-Type": "application/json; charset=UTF-8",
            };

            var postParams = JSON.stringify({
                type: "generateInsights",
                protocolVersion: Personetics.projectConfiguration.getConfig("protocolVersion"),
                userId: config.userId,
                ctxId: config.ctxId,
                lang: config.lang,
            });

            var el = config.el;

            document.querySelector(el).insertAdjacentHTML("afterbegin", "<div>Generating insights...</div>");

            $.ajax({
                url: config.pserverUrl,
                type: "POST",
                dataType: "json",
                headers: headers,
                data: postParams,
                success: function () {
                    //el.empty();
                    personetics.startWidget(config);
                },
                error: function () {
                    //el.empty();
                    $(el).children().not(".resize-sensor").remove();
                    document.querySelector(el).insertAdjacentHTML("afterbegin", "<div>Generate insights request failed</div>");
                    console.log("Generate insights request failed");
                },
            });
        } else {
            config.ctxId = "sampleTopRelevant";
            personetics.startWidget(config);
        }
    };

    this.onDocumentReady = function onDocumentReady() {
        var getParams = this.getUrlParams();
        var browserData = Personetics.utils.persoBrowserDetector.getBrowserData();
        var isDesktopOrTablet = browserData.deviceType === "perso-desktop" || browserData.deviceType === "perso-tablet";
        var theme = null;
        $(".perso-navbar").addClass(browserData.deviceType);
        this.config.el = "#perso-widget-container";
        document.querySelector("#perso-widget-container").classList.add(browserData.deviceType);
        this.config.userId = getParams.userId;
        this.config.pserverUrl = getParams.pserverUrl;
        this.config.lang = getParams.lang;

        switch (getParams.teasersView) {
            case "Budget":
                this.config.widgetType = "manage-budgets";
                break;
            case "Carousel":
                this.config.widgetType = "teaser-widget-carousel";
                break;
            case "SideBySide":
                this.config.widgetType = isDesktopOrTablet ? "inbox-story-widget" : "teaser-widget";
                break;
            default:
                this.config.widgetType = "teaser-widget";
        }

        if (Personetics.utils.projectConf.verifyConfig("allowExternalTheme", false)) {
            theme = this.persoSessionStorage["theme"];
            delete theme["adjustableColoring"];
        }

        this.config.theme = theme && Object.keys(theme).length ? theme : null;

        if (typeof getParams.userId !== "undefined") {
            if (getParams.isPredefined == "true" && window.testData) {
                this.config.payload = this.buildPayLoad();
                this.config.payload.insights = window.testData.richTeasers.insights;
                this.config.payload.status = window.testData.richTeasers.status;
                document.querySelector(this.config.el).innerHTML = "";
                personetics.startWidget(this.config);
            } else {
                this.callStartWidget(this.config);
            }
        }

        $(".close-button").click(function () {
            var deviceType = personetics.getDeviceType();
            var bridge = personetics.getJSBridge();
            if (deviceType != "web") {
                bridge.sessionEnded();
            } else {
                window.location = "login.html";
            }
        });
    };

    this.buildPayLoad = function () {
        var payload = {
            lang: this.lang,
            deviceType: "web",
            ctxId: "dashboard",
            insights: null,
            isPayloadEncode: true,
        };
        return payload;
    };
};

var homeApp;
$(document).ready(function () {
    var channel = Personetics.utils.url.getParameterByName("channel");
    if (channel === "web") {
        homeApp = new homeWeb();
        homeApp.onDocumentReady();
    } else {
        homeApp = new home();
    }
});
