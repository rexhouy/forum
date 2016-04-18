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

                var checkTel = function(checkTelExistence) {
                        var tel = $("#tel").val();
                        if (tel == null || tel.length != 11 || isNaN(tel)) {
                                alert("请输入合法的手机号");
                                return null;
                        }
                        return tel;
                };

                var cancelCoolDown = false;
                var coolDown = function(time) {
                        if (time === 0 || cancelCoolDown) {
                                $("#wizard").removeAttr("disabled").html("获取验证码");
                                cancelCoolDown = false;
                                return;
                        }
                        $("#wizard").html("获取验证码("+time+")");
                        setTimeout(function(){
                                coolDown(time-1);
                        }, 1000);
                };

                self.castCaptcha = function() {
                        var tel = checkTel();
                        if (!tel) {
                                return;
                        }
                        $("#wizard").attr("disabled", "disabled");
                        $.get("/users/captcha", {
                                tel : tel
                        }).done(function(data){
                                if (data != "ok") {
                                        cancelCoolDown = true;
                                        alert(data);
                                }
                                coolDown(60);
                        });
                };

                return self;
        };

        window.enrolls = enrolls();
})();
