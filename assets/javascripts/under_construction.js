// Case-insensetive search for jQuery >= 1.8
// jQuery.expr[":"].Contains = jQuery.expr.createPseudo(function(arg) {
//     return function( elem ) {
//         return jQuery(elem).text().toUpperCase().indexOf(arg.toUpperCase()) >= 0;
//     };
// });

// Case-insensetive search for jQuery < 1.8
// jQuery.expr[':'].Contains = function(elem, index, match) {
//   return jQuery(elem).text().toUpperCase().indexOf(match[3].toUpperCase()) >= 0;
// };

$(document).ready(function () {

  $('#uc_period_form :input').change(function () {
    uc_upd_header();
  });

  $(document.body).on('click', '.uc_close_warning', function () {
    $('#uc_warn_note').hide();
    localStorage['uc_warn_state'] = 'closed';
  });

  uc_show_warn_if_needed();
});


function uc_upd_header () {
  $.ajax({ url: '/uc_periods/update_msg_head',
           type: 'get',
           data: $('#uc_period_form').serialize() });
}

function uc_show_warn_if_needed () {
  if (typeof uc_warn_hash != 'undefined' && localStorage['uc_warn_hash'] != uc_warn_hash) {
      localStorage['uc_warn_hash'] = uc_warn_hash;
      localStorage['uc_warn_state'] = 'open';
  }

  if (localStorage['uc_warn_state'] != 'closed') {
    var tm_heigth = $('#top-menu').outerHeight();
    var uc_warn_width = $('#uc_warn_note').outerWidth();
    $('#uc_warn_note').css('top', tm_heigth + 5 + 'px');
    $('#uc_warn_note').css('left', jQuery(window).width() - 5 - uc_warn_width + 'px');
    $('#uc_warn_note').show();
    $('#uc_warn_note').effect('slide', {direction: 'up'} , 700);
  }
}