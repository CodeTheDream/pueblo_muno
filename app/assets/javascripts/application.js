//= require jquery
//= require jquery_ujs
//= require d3.v3
//= require_tree .

function otherCheckBox() {
  $('#user_connection_other').change(function() {
    $('input.other').prop('disabled', !this.checked);
  });
};

function formSubmit() {
  $("form#new_user").submit(function() {
    length = $('input:checked').length;
    if (length == 0) {
      alert('Please choose one checkbox. Por favor escoja una opción.');
      return false;
    }
  });
};

function moreInformation() {
  $('.icon-container').click(function() {
    var info = $(this).closest('.dish-header').next('.info'); // Just the one info
    var icon = $(this).children('.info-btn'); // Select the logo

    // Stop any ongoing animation loops. Without this, you could click button 10
    // times real fast, and watch an animation of the info showing and closing
    // for a few seconds after
    icon.stop();
    info.stop();

    // Flip icon and hide/show info (choose 1 method here and in menu.scss)
    icon.toggleClass('flip');

    // Metnod 1
    info.slideToggle('slow');

    // Method 2, use with setInfoheight function
    // info.toggleClass('active').height(icon.is('.flip') ? info.attr('h') : 0);

    // Method 3
    // info.toggleClass('active');
  });
};

// function setInfoHeight() {
//   $(window).on('load resize', function() {
//     $('.info').each(function () {
//       var current = $(this);
//       var closed = $(this).height() == 0;
//       current.height('auto').attr('h', current.height() );
//       current.height(closed ? '0' : current.height());
//     });
//   });
// };

$(formSubmit);
$(otherCheckBox);
$(moreInformation);
// $(setInfoHeight);
