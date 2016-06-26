// This is a manifest file that'll be compiled into application.js, which will
// include all the files listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts,
// vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here
// using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at
// the bottom of the compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

function otherCheckBox() {
  $('#user_connection_other').change(function() {
    $('input[type="text"]').prop('disabled', !this.checked);
  });
};

function formSubmit() {
  $("form#new_user").submit(function() {
    length = $('input:checked').length;
    if (length == 0) {
      alert('Please choose one checkbox');
      return false;
    }
  });
};

function moreInformation() {
  $('.icon-container').click(function() {
    $('.info:visible').slideUp('fast');
    $('.info-btn.active').removeClass('active');
    var info = $(this).closest('.option').next();
    if (!info.is(':visible')) {
      $(this).children('.info-btn').toggleClass('active');
      info.slideDown('fast');
    };
  });
};

$(formSubmit);
$(otherCheckBox);
$(moreInformation);
