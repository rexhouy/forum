(function() {
        var client, subscription;
        var CHANNEL = "/faye/im";

        var template;
        var templateMe;
        var messageContainer;
        var user;

        var scrollToBottom = function() {
                $("html, body").animate({scrollTop:$(document).height()}, "slow");
        };

        var events = {
                onReceiveMessage : function(message) {
                        var t = message.name === user.name ? templateMe : template;
                        $(Mustache.render(t, message)).appendTo(messageContainer);
                        scrollToBottom();
                },
                onSendMessage : function() {
                        $("#inputWindow").val("");
                        console.log("message sent");
                },
                onSendMessageError : function(error) {
                        console.log("There was a problem " + error);
                }
        };

        var init = function() {
                template = $("#messageTemplate").html();
                templateMe = $("#messageTemplateMe").html();
                user = {
                        avatar: $("#userAvatar").val(),
                        name: $("#userName").val()
                };
                messageContainer = $("#messageContainer");
                $("#inputWindow").textareaAutoSize();
                client = new Faye.Client($("#imServerUrl").val(), {
                        timeout: 120,
                        retry: 5
                });
                subscription = client.subscribe(CHANNEL, events.onReceiveMessage);
                console.log("client subscribed");
        };

        var im = function() {
                var self = {};
                self.sendMessage = function() {
                        var text = $.trim($("#inputWindow").val());
                        if (!text) {
                                return;
                        }
                        var publication = client.publish(CHANNEL, {
                                avatar: user.avatar,
                                name: user.name,
                                text: text
                        }).then(events.onSendMessage, events.onSendMessageError);
                };
                return self;
        };

        $(function() {
                init();
                window.im = im();
        });

})();
