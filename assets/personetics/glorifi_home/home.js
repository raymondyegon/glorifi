class homeWeb {
    constructor() {
        this.showWidget = function (insightId, instanceId) {
            var startWidgetConfig = {
                "insightId": insightId,
                "instanceId": instanceId,
                "lang": "en",
                "widgetType": "story-widget",
                "ctxId": "dashboard",
                "darkMode": false,
                "protocolVersion": Personetics.projectConfiguration.getConfig("protocolVersion"),
                "el": $("#perso-widget-container"),
                "useRemoteAssets": true,
                "baseUrl": "https://client-vanilla-assets.s3.amazonaws.com/product-assets/assets",
                "deviceType": "web"
            };
            startWidgetConfig.widgetType = "story-widget";
            startWidgetConfig.el = $("#perso-widget-container");
       
            personetics.startWidget(startWidgetConfig);
       
        };
        this.showResponse = function (value, requestId) {
            // PrintMessage.postMessage(value);
            PrintMessage.postMessage("Send to PServer"+requestId);
            // PrintMessage.postMessage(requestId);
            PrintMessage.postMessage("*****************************");
            PrintMessage.postMessage("Decoding Data......");
            var decodedData = Personetics.utils.encodeDecode.Base64.decode(value);
            try {
                decodedData = $.parseJSON(decodedData);
                PrintMessage.postMessage("*****************************");
                PrintMessage.postMessage(decodedData);
            } catch (error) {
                decodedData = {
                    ok: false,
                    status: "600",
                    statusMessage: "A network error occurred - check your network and try again.",
                };
                // PrintMessage.postMessage("*****************************");
                // PrintMessage.postMessage(error);
            }
            personetics.handlePServerResponse(decodedData, requestId);
        };
    }
}

var homeApp;
$(document).ready(function () {
    var channel = Personetics.utils.url.getParameterByName("channel");
    homeApp = new homeWeb();
});
