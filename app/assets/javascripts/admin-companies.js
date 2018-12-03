jQuery(function ($) {
  var validator = $('.admin-company').validate({
    rules: {
      "company[name]":  {
        required: true
      },
      "company[sector]": {
        required: true
      },
      "company[employees_count]":  {
        number: true
      },
      "company[email]": { required: true, email: true },
      "company[company_type_id]": {
        required: true
      },
      "company[locations_attributes][0][city]": {
        required: true,
        textonly: true
      },
      "company[website]": {
        required: true
      },
      "company[locations_attributes][0][country]": {
        required: true,
        textonly: true
      },
      "company[phones_attributes][0][mobile]": {
        phoneUS: true
      },
      "company[locations_attributes][0][pin_code]": {
        maxlength: 8
      },
      "company[phones_attributes][0][landline]": {
        phoneUS: true
      },
      "company[phones_attributes][0][fax]": {
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
  }, "Please specify a valid number");

  jQuery.validator.addMethod("textonly", function(text, element) {
    return this.optional(element) || text.match(/^[a-zA-Z\(\)\-\+\s]+$/);
  }, "Please specify a valid text");

});