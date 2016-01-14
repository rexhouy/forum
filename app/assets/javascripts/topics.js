(function() {
        var topics = function() {
                var self = {};

                self.resizePostsFrame = function(obj) {
                        setTimeout(function() {
                                $("#spinner").hide();
                                obj.style.height = obj.contentWindow.document.body.scrollHeight + "px";
                        }, 500);
                };

                self.like = function(id) {
                        $.ajax("/topics/"+id+"/like", {
                                method : "post",
                                headers : {
                                        'X-CSRF-Token' : utility.getCSRFtoken()
                                }
                        }).done(function(data) {
                                var favAlert = $("#favAlert");
                                if (data == "marked") {
                                        $("#favCount").html(Number($("#favCount").html()) + 1);
                                        favAlert.html("感谢您的评价");
                                } else {
                                        favAlert.html("已评价");
                                }
                                $(".like-btn").attr("disabled", true);
                                favAlert.css("opacity", 1);
                                setTimeout(function() {
                                        favAlert.animate({opacity: 0}, "slow");
                                }, 1000);
                        });
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
