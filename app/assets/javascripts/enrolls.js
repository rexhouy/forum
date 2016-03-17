(function() {

        var enrolls = function() {
                var self = {};

                self.create = function(form) {
                        var content = {};
                        try {
                                $(form).find("input[type=text]").each(function(index, element) {
                                        if (element.required && !element.value) {
                                                throw "请完成报名表格再提交！";
                                        }
                                        content[$(element).attr("data")] = element.value;
                                }).append($("<input type=hidden name='content' value='"+JSON.stringify(content)+"'>"));
                        } catch(e) {
                                alert(e);
                                return false;
                        }
                        return true;
                };

                return self;
        };

        window.enrolls = enrolls();
})();
