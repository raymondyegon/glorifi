var advancedSettingsPage = function advancedSettingsPage() {
    this.initialize = function initialize() {
        initSessionStorage(this);
        try {
            var persoSessionStorage = JSON.parse(sessionStorage.getItem("persoStorage"));
            if (persoSessionStorage != null) {
                this.persoSessionStorage = persoSessionStorage;
            }
        } catch (e) {
            console.error("Error: ", e);
        }
    };
    this.initialize();

    this.onDocumentReady = function onDocumentReady() {
        for (var settingKey in this.persoSessionStorage) {
            for (var key in this.persoSessionStorage[settingKey]) {
                var el = $("#" + key);
                var value = this.persoSessionStorage[settingKey][key];
                el.val(value);
                if (el.attr("type") === "checkbox") {
                    el.prop("checked", value);
                }
            }
        }
        this.bindEvents();
    };
    this.bindEvents = function bindEvents() {
        var me = this;
        $(".close-button").click(function () {
            try {
                sessionStorage.setItem("persoStorage", JSON.stringify(me.persoSessionStorage));
            } catch (e) {
                console.error("Error: ", e);
            }
        });
        $("form.settings-container input:checkbox").change(function (e) {
            var targetInput = e.target;
            me.persoSessionStorage[targetInput.dataset.feature][targetInput.id] = targetInput.checked;
        });
        $("form.settings-container input[type='text']").change(function (e) {
            var targetInput = e.target;
            if (this.value != "") {
                me.persoSessionStorage[targetInput.dataset.feature][this.id] = this.value;
            }
        });
        $("form.settings-container").on("reset", function () {
            initSessionStorage(me);
        });
    };
};

function initSessionStorage(el) {
    el.persoSessionStorage = {
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
}

var advancedSettings = new advancedSettingsPage();
$(document).ready(function () {
    advancedSettings.onDocumentReady();
});
