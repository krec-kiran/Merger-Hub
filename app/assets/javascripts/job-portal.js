jQuery(function ($) {
  var validator = $('.edit-validation').validate({
    rules: {
      "job_portal[title]":  {
        required: true
      },
      "job_portal[company_name]":  {
        required: true
      },
      "job_portal[summary]":  {
        required: true
      },
      "job_portal[requirement]":  {
        required: true
      },
      "job_portal[website]":  {
        required: true
      },
      "job_portal[email]": { required: true, email: true },
      "job_portal[location_attributes][city]": {
        required: true,
        textonly: true
      },
      "job_portal[location_attributes][state]": {
        required: true
      },
      "job_portal[location_attributes][country]": {
        required: true,
        textonly: true
      },
      "job_portal[location_attributes][pin_code]": {
        required: true,
        maxlength: 8
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
  jQuery.validator.addMethod("textonly", function(text, element) {
    return this.optional(element) || text.match(/^[a-zA-Z\(\)\-\+\s]+$/);
  }, "Please specify a valid text");
});