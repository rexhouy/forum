(function() {
        var nav = function() {
                var self = {};
                var show = false;

                self.showSettings = function() {
                        if (show) {
                                $(".settings").hide();
                        } else {
                                $(".settings").show();
                        }
                        show = !show;
                };

                return self;
        };

        window.nav = nav();

})();
