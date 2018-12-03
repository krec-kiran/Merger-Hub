jQuery(function ($) {
  var validator = $('.admin-news').validate({
    rules: {
      "site[name]":  {
        required: true
      },
      "site[url]":  {
        required: true
      }
    },
    highlight: function (element) {
      $(element).parent().addClass('error')
      $(element).addClass('error-element')
    },
    unhighlight: function (element) {
      $(element).parent().removeClass('error')
      $(element).removeClass('error-element')
    }
  });
});