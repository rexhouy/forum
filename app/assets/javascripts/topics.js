(function() {
        var topics = function() {
                var self = {};

                self.resizePostsFrame = function(obj) {
                        setTimeout(function() {
                                $("#spinner").hide();
                                obj.style.height = 0;
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

                self.openSearch = function() {
                        utility.showBlockLayer();
                        $(".search").show();
                        $("#searchText").focus();
                        nav.toggleSettings();
                };

                self.closeSearch = function() {
                        $(".search").hide();
                        utility.hideBlockLayer();
                };

                /**
                 * Enroll start
                 **********************************************************************/
                var template = $("#question_template").html();
                var name = "topic[questions_attributes][:index][:name]";
                self.enableEnroll = function(enable) {
                        if (enable) {
                                $("#questions").show();
                        } else {
                                $("#questions").hide();
                        }
                };

                var getQuestionsCount = function() {
                        return $("#questions_tbody").children().size();
                };

                self.addQuestion = function() {
                        $(template).appendTo($("#questions_tbody"));
                };

                self.removeQuestion = function(btn) {
                        $(btn).parent().parent().remove();
                };

                self.setFormParams = function() {
                        var container = $("#questions");
                        var names = ["id", "content", "required"];
                        $("#questions_tbody").find("tr").each(function(spec_index) {
                                $(this).find("input").each(function(index, element) {
                                        var html_name = name.replace(/:index/, spec_index).replace(/:name/, names[index]);
                                        var value = element.value;
                                        if (names[index] == "required") {
                                                value = element.checked ? 1 : 0;
                                        }
                                        container.append($("<input type=hidden name="+html_name+" value='"+value+"'>"));
                                });
                        });
                        return true;
                };

                self.enroll = function(form) {
                        var content = {};
                        try {
                                $(form).find("input[type=text]").each(function(index, element) {
                                        if (element.required && !element.value) {
                                                throw "请完成报名表格再提交！";
                                        }
                                        content[element.name] = element.value;
                                }).append($("<input type=hidden name='content' value='"+JSON.stringify(content)+"'>"));
                        } catch(e) {
                                alert(e);
                                return false;
                        }
                        return true;
                };

                return self;
        };

        $(function() {
                $("#posts").load(function() {
                        window.topics.resizePostsFrame(this);
                        $(".redactor-editor").html("");
                }).attr("src", "/topics/"+$("#topicId").val()+"/posts");
        });

        window.topics = topics();
})();
