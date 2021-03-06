(function(){
        window.uploader = function(){
                var self = {};

                self.open = function() {
                        $("#cover_image_upload").click();
                };

                self.upload = function(event) {
                        var files = event.target.files;
                        var data = new FormData();
                        data.append("thumb", $("#thumb").val());
                        $.each(files, function(index, file) {
                                data.append("file", file, file.name);
                        });
                        $(".upload-progress").show();
                        $.ajax({
                                url: '/image',
                                type: 'POST',
                                data: data,
                                cache: false,
                                dataType: 'json',
                                processData: false, // Don't process the files
                                contentType: false, // Set content type to false as jQuery will tell the server its a query string request
                                success: function(data, textStatus, jqXHR) {
                                        $("#topic_cover_image").val(data.filelink);
                                        $("#cover_image").attr("src", data.filelink);
                                        $(".upload-progress").hide();
                                }
                        });
                };

                return self;
        }();

})();
