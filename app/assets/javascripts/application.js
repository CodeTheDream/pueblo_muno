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

function setMasonryHeight() {
  $(window).on('load resize', function (){
    if (screen.width > 768) {
      var masonry = $('.masonry'),
          height = masonry.height('auto').height(),
          scroll = 1,
          rows = screen.width > 992 ? 3 : 2;

      $('.masonry').height(height/rows);

      while (scroll > 0) {
        height = masonry.height();
        $('.masonry').height(height + 10);
        scroll = $('.masonry').scrollLeft(1).scrollLeft();
      };
    } else {
      $('.masonry').height('');
    };
  });
};

// Used to format phone number
function phoneFormatter() {
  $('.phone').on('input', function() {
    // remove all non-digit characters
    var number = $(this).val().replace(/[^\d]/g, '');

    if (number.length == 7) {
      number = number.replace(/(\d{3})(\d{4})/, "$1-$2");
    } else if (number.length == 10) {
      number = number.replace(/(\d{3})(\d{3})(\d{4})/, "($1) $2-$3");
    };

    $(this).val(number);
  });
};

$(formSubmit);
$(otherCheckBox);
$(moreInformation);
// $(setInfoHeight);
$(setMasonryHeight);
