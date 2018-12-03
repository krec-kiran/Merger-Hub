// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//= require jquery_ujs
//= require jquery-ui
//= require jquery-migrate
//= require underscore
//= require pluralize
//= require bootstrap
//= require bootstrap-hover-dropdown
//= require toastr_rails
//= require jquery.validate.min
//= require jquery.payment.min
//= require highcharts
//= require highcharts-drilldown
//= require highcharts-exporting
//= require angular-file-upload-shim.min
//= require angular
//= require angular-file-upload.min
//= require angular-resource
//= require angular-animate
//= require angular-bootstrap
//= require angular-sanitize
//= require angular-route
//= require angular-ui-router
//= require angular-ui-utils
//= require angular-ui-select
//= require angularjs-toaster
//= require angular-utils-pagination
//= require back-to-top
//= require jquery-placeholder
//= require jquery.fitvids
//= require flexslider
//= require jquery.mask
//= require bootstrap-tagsinput
//= require main
//= require angular-rails-templates
//= require angular-busy
//= require_tree ../templates
//= require_tree .

$(document).ready(function() {
  toastr.options = {
    "closeButton": false,
    "debug": false,
    "positionClass": "toast-bottom-right",
    "onclick": null,
    "showDuration": "300",
    "hideDuration": "1000",
    "timeOut": "5000",
    "extendedTimeOut": "1000",
    "showEasing": "swing",
    "hideEasing": "linear",
    "showMethod": "fadeIn",
    "hideMethod": "fadeOut"
  }

});
