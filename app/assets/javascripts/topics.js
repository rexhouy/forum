(function() {
        var topics = function() {
                var self = {};

                self.resizePostsFrame = function(obj) {
                        setTimeout(function() {
                                $("#spinner").hide();
                                obj.style.height = obj.contentWindow.document.body.scrollHeight + "px";
                        }, 500);
                };

                return self;
        };

        $(function() {
                $("#posts").load(function() {
                        window.topics.resizePostsFrame(this);
                }).attr("src", "/topics/"+$("#topicId").val()+"/posts");
        });

        window.topics = topics();
})();
