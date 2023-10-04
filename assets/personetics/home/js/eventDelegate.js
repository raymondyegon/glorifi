/* eslint-disable */
window.EventDelegate = function () {
    this.sessionEnded = function (config) {
        Personetics.log("Customer: sessionEnded");
        var channel = personetics.getDeviceType();
        if (channel === "web") {
            if (config.ExistInbox) {
                window.location = "../home/login.html";
            } else {
                config.el = $("#perso-widget-container");
                switch (Personetics.utils.url.getParameterByName("teasersView")) {
                    case "Carousel":
                        config.widgetType = "teaser-widget-carousel";
                        break;
                    case "SideBySide":
                        config.widgetType = "inbox-story-widget";
                        break;
                    default:
                        config.widgetType = "teaser-widget";
                        break;
                }
                personetics.startWidget(config);
            }
        } else {
            var data = {
                requestString: "sessionEnded",
                widgetType: config.widgetType,
            };

            this.sendRequestToPServer(null, data);
        }
    };

    this.registered = function () {
        Personetics.log("Customer: Registration completed");
    };

    this.sessionStarted = function () {
        Personetics.log("Customer : sessionStarted");
    };

    /**
     * Send data to native interface
     * @param requestId
     * @param data
     */
    this.sendRequestToPServer = function (requestHeaders, data, requestId) {
        var requestString = data.hasOwnProperty("requestString") ? data.requestString : "sendRequestToPServer";
        this.sendRequestToServer(requestHeaders, data, requestId, requestString);
    };

    this.sendRequestToEnrichServer = function (requestHeaders, data, requestId) {
        var requestString = data.hasOwnProperty("requestString") ? data.requestString : "sendRequestToEnrichServer";
        this.sendRequestToServer(requestHeaders, data, requestId, requestString);
    };

    this.sendRequestToServer = function (requestHeaders, data, requestId, requestString) {
        Personetics.log("Personetics Events Delegate requestDataFromNative: " + JSON.stringify(data) + ", requestId: " + requestId);
        var json = { requestData: data, requestId: requestId };
        var channel = personetics.getDeviceType();
        if (channel === "ios") {
            this.callIphoneBridge(requestHeaders, json, requestString, requestId);
            /* Added for backward support to UIWebView */
            this.callWebViewPhoneBridge(requestHeaders, json, requestString, requestId);
        } else if (channel === "android") {
            this.callAndroidBridge(requestHeaders, json, requestString, requestId);
        } else if (channel === "RJS" || channel === "Angular") {
            window.PersoWidget.widgetEventHandler({
                requestHeaders: requestHeaders,
                json: json,
                requestString: requestString,
                requestId: requestId,
            });
        } else if (channel === "RN") {
            window.ReactNativeWebView.postMessage(
                JSON.stringify({
                    requestString: requestString,
                    requestData: json.requestData,
                    requestId: requestId,
                })
            );
        } else {
            if (channel === "web") {
                this.sendAjaxRequest(requestHeaders, data, requestId);
            } else throw "invalid deviceType '" + channel + "'";
        }
    };

    this.sendAjaxRequest = function (requestHeaders, json, requestId) {
        var pserverUrl = Personetics.utils.url.getParameterByName("pserverUrl");
        var isPredefined = Personetics.utils.url.getParameterByName("isPredefined");
        if (isPredefined == "false") {
            Personetics.utils.network.doAjaxPost(pserverUrl, JSON.stringify(json), {
                dataType: "json",
                headers: requestHeaders,
                onSuccess: function (response) {
                    personetics.handlePServerResponse(response, requestId);
                },
                onFailure: function (XMLHttpRequest, textStatus, errorThrown) {
                    var errorData = {
                        ok: false,
                        status: "600",
                        statusMessage: "A network error occurred - check your network and try again.",
                    };
                    personetics.handlePServerResponse(errorData, requestId);
                },
            });
        } else {
            personetics.handlePServerResponse({ ok: "true", status: "200" }, requestId);
        }
    };
    this.handleError = function () {
        personetics.handlePServerResponse({}, requestId);
    };
    /**
     * Receive data from native
     * @param requestId
     * @param data
     */
    this.handlePServerResponse = function (data, requestId) {
        this.handleServerResponse(data, requestId);
    };
    /**
     * Receive data from native
     * @param requestId
     * @param data
     */
    this.handleServerResponse = function (data, requestId) {
        var decodedData = Personetics.utils.encodeDecode.Base64.decode(data);
        try {
            decodedData = $.parseJSON(decodedData);
        } catch (error) {
            decodedData = {
                ok: false,
                status: "600",
                statusMessage: "A network error occurred - check your network and try again.",
            };
        }

        personetics.handleServerResponse(decodedData, requestId);
    };

    this.callIphoneBridge = function (requestHeaders, json, requestString, reqId) {
        if (
            typeof window.webkit == "undefined" ||
            typeof window.webkit.messageHandlers == "undefined" ||
            typeof window.webkit.messageHandlers.personeticsApple == "undefined"
        )
            return;

        var iosBridge = window.webkit.messageHandlers.personeticsApple;
        if (typeof iosBridge !== "undefined" && iosBridge !== null) {
            var requestBody = json; //encodeURIComponent(JSON.stringify(json);

            var finalJson = {
                sender: "personetics",
                requestType: requestString,
                requestInformation: requestBody,
            };

            var finalMessage = JSON.stringify(finalJson);
            window.webkit.messageHandlers.personeticsApple.postMessage(finalMessage);
        }
    };

    this.callWebViewPhoneBridge = function (requestHeaders, json, requestString, reqId) {
        var queryString = "personetics://" + requestString + "/" + encodeURIComponent(JSON.stringify(json));
        var iframe = document.createElement("iframe");
        iframe.setAttribute("src", queryString);
        document.documentElement.appendChild(iframe);
        iframe.parentNode.removeChild(iframe);
        iframe = null;
    };

    this.callAndroidBridge = function (requestHeaders, json, requestString, reqId) {
        if (typeof PersoneticsAndroid !== "undefined" && PersoneticsAndroid !== null) {
            var jsonString = JSON.stringify(json.requestData);
            switch (requestString) {
                case "sessionEnded":
                    PersoneticsAndroid.sessionEnded(jsonString, reqId);
                    break;
                case "sessionError":
                    PersoneticsAndroid.sessionError(jsonString, reqId);
                    break;
                case "navigateToPage":
                    PersoneticsAndroid.navigateToPage(jsonString);
                    break;
                case "sendRequestToPServer":
                    PersoneticsAndroid.sendRequestToPServer(jsonString, reqId);
                    break;
                case "sendRequestToEnrichServer":
                    PersoneticsAndroid.sendRequestToEnrichServer(jsonString, reqId);
                    break;
                case "personeticsEvent":
                    PersoneticsAndroid.personeticsEvent(jsonString);
                    break;
            }
        }
    };

    this.navigateToPage = function (params) {
        Personetics.log("Customer : navigateToPage, Params : " + JSON.stringify(params));
        var channel = personetics.getDeviceType();
        if (channel != "web") {
            this.sendRequestToPServer(null, params);
        } else {
            if (
                params.data &&
                Object.prototype.hasOwnProperty.call(params.data, "navigateTarget") &&
                (params.data.navigateTarget === "manageBudget" || params.data.navigateTarget === "subscriptions")
            ) {
                // open manage-budgets widget
                var startWidgetConfig = {};
                startWidgetConfig.params = params.data.payload;
                startWidgetConfig.insightId = params.data.insightId;
                startWidgetConfig.instanceId = params.data.instanceId;
                startWidgetConfig.lang = params.lang;
                switch (params.data.navigateTarget) {
                    case "manageBudget":
                        startWidgetConfig.widgetType = "manage-budgets";
                        break;
                    case "subscriptions":
                        startWidgetConfig.widgetType = "subscription-dashboard";
                        break;
                    default:
                        break;
                }

                startWidgetConfig.el = $("#perso-widget-container");
                delete startWidgetConfig.payload;
                personetics.startWidget(startWidgetConfig);
            }
        }
    };

    this.sessionError = function (error) {
        var data = {
            requestString: "sessionError",
            data: error,
        };
        var dataError = error;
        try {
            JSON.parse(error);
        } catch (e) {
            if (dataError === null || typeof dataError !== "object")
                dataError = {
                    status: "600",
                    statusMessage: "A network error occurred - check your network and try again.",
                };
            dataError = JSON.stringify(dataError);
        }
        Personetics.log("Customer : sessionError, Params: " + dataError);
        data.data = dataError;
        this.sendRequestToPServer(null, data);
    };

    this.widgetEvent = function widgetEvent(widget, params) {
        if (params.data && params.data.actionType) {
            if (params.data.actionType == "externalNavigation") {
                this.navigateToPage(params);
            } else if (params.data.actionType == "externalNavigationUrl") {
                window.location.href = params.data.navigateTarget;
            } else {
                this.handleWidgetAction(widget, params);
            }
        }
        var eventType = params.eventType;
        switch (eventType) {
            case "teaserClick":
                var channel = personetics.getDeviceType();
                if (channel !== "web") {
                    Personetics.log("Customer: teaserClick");
                    var data = {
                        requestString: "personeticsEvent",
                        data: params,
                    };
                    this.sendRequestToPServer(null, data);
                } else {
                    var startWidgetConfig = params;
                    startWidgetConfig.widgetType = "story-widget";
                    startWidgetConfig.el = $("#perso-widget-container");
                    personetics.startWidget(startWidgetConfig);
                }
                break;
            case "refreshInsights":
                Personetics.log("Customer: refreshInsights");
                var data = {
                    requestString: "personeticsEvent",
                    data: params,
                };
                this.sendRequestToPServer(null, data);
                break;
            case "reporting":
                var channel = personetics.getDeviceType();
                if (channel !== "web") {
                    Personetics.utils.PLogger.debug("Customer: " + eventType);
                    var data = {
                        requestString: "personeticsEvent",
                        data: params,
                    };
                    this.sendRequestToPServer(null, data);
                } else {
                    console.log("reporting event" + JSON.stringify(params));
                }
                break;
            default:
                console.log("widget event" + JSON.stringify(params));
        }
    };

    this.handleWidgetAction = function handleWidgetActions(widget, params) {
        var channel = personetics.getDeviceType();
        if (channel !== "web") {
            Personetics.log("Customer: openStory");
            var data = {
                requestString: "personeticsEvent",
                data: params.data,
            };

            if (params.requestString == "callPersoneticsAPI") {
                data.requestString = "callPersoneticsAPI";
                var dataObj = params.data;
                personetics.callPersoneticsAPI(dataObj.apiName, dataObj.apiBody, dataObj.successCallback, dataObj.failureCallback);
            } else {
                this.sendRequestToPServer(null, data);
            }
        } else {
            switch (params.data.actionType) {
                case "openStory":
                    var startWidgetConfig = params.data.payload;
                    startWidgetConfig.widgetType = "story-widget";
                    startWidgetConfig.el = $("body");
                    personetics.startWidget(startWidgetConfig);
                    break;
                case "callPersoneticsAPI":
                    var dataObj = params.data;
                    personetics.callPersoneticsAPI(dataObj.apiName, dataObj.apiBody, dataObj.successCallback, dataObj.failureCallback);
                    console.log("callPersoneticsAPI");
                    break;
                default:
                    console.log("widget event" + JSON.stringify(params.data.payload));
                    break;
            }
        }
    };
};
