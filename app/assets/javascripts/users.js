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

                return self;
        }();

})();
