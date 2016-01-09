(function() {
        var topics = function() {
                var self = {};

                self.resizePostsFrame = function(obj) {
                        console.log(obj.contentWindow.document.body.scrollHeight);

                };

                return self;
        };

        window.topics = topics();
})();
