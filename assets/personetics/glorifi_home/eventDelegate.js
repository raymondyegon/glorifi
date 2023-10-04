/* eslint-disable */
window.EventDelegate = function () {
    /**
     * Send data to native interface
     * @param requestId
     * @param data
     */
    this.sendRequestToPServer = function (requestHeaders, data, requestId) {
        PrintMessage.postMessage(data);
        //Navigate User on Button Click event, but not if they click a graph, etc. 
        if(data.eventsInfoList != undefined && data.eventsInfoList[0].type == "NavigateButton"){
          
                NavigateUser.postMessage(data.eventsInfoList[0].params['value']);
       
        }
       
        PrintMessage.postMessage("From Send Request To PServer"+requestId);
        this.sendAjaxRequest(requestHeaders, data, requestId);
      
        
    };
    this.sendAjaxRequest = function (requestHeaders, json, requestId) {
        var isPredefined = "false";
        if (isPredefined == "false") {

            var data = JSON.stringify(json);
            if (PassInsightInfo && sendRequestId) {
                PassInsightInfo.postMessage(data);
                sendRequestId.postMessage(requestId);
            }



        } else {
            if (PrintMessage) {
                PrintMessage.postMessage('hello2');
            }
            personetics.handlePServerResponse({ ok: "true", status: "200" }, requestId);
        }
    };

    //    /**
    //  * Receive data from native
    //  * @param requestId
    //  * @param data
    //  */
    //     this.handlePServerResponse = function (requestId) {
    //         if(PrintMessage){
    //             PrintMessage.postMessage('hello');
    //         }
    //     };
};