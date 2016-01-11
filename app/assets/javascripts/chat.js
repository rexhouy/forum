(function() {
        var client, subscription;
        var CHANNEL = "/faye/im";

        var events = {
                onReceiveMessage : function(message) {
                        console.log("message received: " + message.text);
                },
                onSendMessage : function() {
                        console.log("message sent");
                },
                onSendMessageError : function(error) {
                        console.log("There was a problem " + error);
                }
        };

        var init = function() {
                client = new Faye.Client("/faye", {
                        timeout: 120,
                        retry: 5
                });
                subscription = client.subscribe(CHANNEL, events.onReceiveMessage);
                console.log("client subscribed");
        };

        window.im = {
                sendMessage : function(message) {
                        var publication = client.publish(CHANNEL, {text: message}).then(events.onSendMessage, events.onSendMessageError);
                }
        };

        $(function() {
                init();
                var sendMsg = function() {
                        window.im.sendMessage("test");
                        setTimeout(sendMsg, 10000);
                };
                setTimeout(sendMsg, 10000);
        });

})();
