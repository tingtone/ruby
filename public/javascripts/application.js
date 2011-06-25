(function($) {
  $.fn.ktabs = function() {
    this.each(function() {
      var currentTab = $(this);
      var headerContainer = currentTab.find(".tab_header_container");
      var contentContainer = currentTab.find(".tab_content_container");
      headerContainer.delegate(".tab_header a", "click", function() {
        var currentHeaderClicked = $(this);
        var contentNodeId = currentHeaderClicked.attr("href");
        var currentHeader = currentHeaderClicked.parent();
        if (!currentHeader.is(".current")) {
          currentTab.find(".tab_header.current").removeClass("current");
          currentHeader.addClass("current");
          currentTab.find(".tab_content.current").removeClass("current");
          $(contentNodeId).addClass("current");
        }
        return false;
      });
    });
    return this;
  };


  $(document).ready(function() {
    $(".tab_control").ktabs();
  });
})(jQuery);




