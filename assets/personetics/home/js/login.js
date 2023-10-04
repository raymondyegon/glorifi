var loginPage = function loginPage() {
    this.initialize = function initialize() {
        this.url = "../personetics/execute";
        //this.url = "http://54.237.29.75:8080/pbank/personetics/execute";
        this.insightsTemplate = "<div class='perso-teaser' data-id='{{id}}'>{{text}}</div>";
    };
    this.initialize();

    this.onDocumentReady = function onDocumentReady() {
        this.bindEvents();
    };

    this.bindEvents = function bindEvents() {
        var me = this;
        $("#initPersoneticsButton").click(function () {
            me.userId = $("#user-id").val();
            me.url = "../../personetics/execute";
            me.teasersView = $("#select-widget :selected").val();
            me.lang = "en";
            me.isPredefined = false;

            if (me.userId && me.userId.length > 0) {
                var indexPageName = window.indexPageName;
                if (typeof indexPageName !== "undefined" && indexPageName !== null && indexPageName.length > 0)
                    window.location =
                        indexPageName +
                        ".html?userId=" +
                        me.userId +
                        "&lang=" +
                        me.lang +
                        "&channel=web&teasersView=" +
                        me.teasersView +
                        "&pserverUrl=" +
                        me.url +
                        "&isPredefined=" +
                        me.isPredefined;
                else alert("Invalid redirect page name: '" + indexPageName + "'");
            } else {
                alert("Please fill out all inputs");
            }
        });
    };
};
function onFocusBehavioue(id) {
    $(id + "-label").addClass("active");
}
function onFocusOutBehaviour(id) {
    if ($(id).val() == "") {
        $(id + "-label").removeClass("active");
    }
}

var myLogin = new loginPage();
$(document).ready(function () {
    myLogin.onDocumentReady();
});
