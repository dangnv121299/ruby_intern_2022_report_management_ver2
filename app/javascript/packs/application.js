import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";

import $ from "jquery";
global.toastr = require("toastr/toastr");
import "select2";

Rails.start();
Turbolinks.start();
ActiveStorage.start();

$(document).on("turbolinks:load", function(){
  $(".select2-search").select2({
    allowClear: true,
  });
});

toastr.options = {
  closeButton: true,
  positionClass: "toast-top-right",
  preventDuplicates: false,
  onclick: null,
  showDuration: "300",
  hideDuration: "1000",
  timeOut: "3000",
  extendedTimeOut: "1000",
  showEasing: "swing",
  hideEasing: "linear",
  showMethod: "fadeIn",
  hideMethod: "fadeOut",
};
