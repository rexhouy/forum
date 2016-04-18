(function() {
        window.users = function() {
                var self = {};

                self.editAvatar = function() {
                        $("#avatarUploader").click();
                };

                self.uploadAvatar = function(event) {
                        var files = event.target.files;
                        var data = new FormData();
                        data.append("thumb", $("#thumb").val());
                        $.each(files, function(index, file) {
                                data.append("file", file, file.name);
                        });
                        $.ajax({
                                url: "/images",
                                type: "POST",
                                data: data,
                                cache: false,
                                dataType: 'json',
                                processData: false, // Don't process the files
                                contentType: false, // Set content type to false as jQuery will tell the server its a query string request
                                success: function(data, textStatus, jqXHR) {
                                        $("#user_avatar").val(data.filelink);
                                        $("#avatarImage").attr("src", data.filelink);
                                }
                        });
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
        }();

})();
