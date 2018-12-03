jQuery(function ($) {
  var validator = $('.admin-candidate').validate({
    rules: {
      "candidate[name]":  {
        required: true
      },
      "candidate[email]":  {
        email: true
      },
      "candidate[company_id]":  {
        required: true
      },
      "candidate[city]":  {
        required: true,
        textonly: true
      },
      "candidate[phone]":  {
        phoneUS: true
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

  jQuery.validator.addMethod("phoneUS", function(phone_number, element) {
      return this.optional(element) || phone_number.match(/^[0-9\(\)\-\+\s]+$/);
  }, "Please specify a valid phone number");

  jQuery.validator.addMethod("textonly", function(text, element) {
    return this.optional(element) || text.match(/^[a-zA-Z\(\)\-\+\s]+$/);
  }, "Please specify a valid text");

});