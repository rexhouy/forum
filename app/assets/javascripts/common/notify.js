(function() {
        $(function() {
                setTimeout(function() {
                        $(".alert").each(function() {
                                $(this).alert('close');
                        });
                }, 5*1000);
        });
})();
