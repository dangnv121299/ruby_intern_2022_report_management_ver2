import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";

import $ from "jquery";
window.jQuery = $;
window.$ = $;

global.toastr = require("toastr/toastr");
import "bootstrap";
import "select2";

Rails.start();
Turbolinks.start();
ActiveStorage.start();

$(document).on("turbolinks:load", function () {
  $(".select2-search").select2({
    allowClear: true,
  });
  $('.claimedRight').each(function (f) {
    var len=$(this).text().trim().length;
    if(len>100)
    {
        $(this).text($(this).text().substring(0,100)+'...');
    }
  });
});

toastr.options = {
  closeButton: false,
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

document.addEventListener("turbolinks:load", function () {
  $(function () {
    $('[data-toggle="tooltip"]').tooltip();
    $('[data-toggle="popover"]').popover();
  });
});
