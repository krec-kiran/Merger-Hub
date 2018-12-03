jQuery(function ($) {
  var validator = $('.user-transaction').validate({
    rules: {
      "ma_transaction[target_id]":  {
        required: true
      },
      "ma_transaction[date]":  {
        required: true
      },
      "ma_transaction[value]":  {
        required: true
      },
      "ma_transaction[transaction_type_id]":  {
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