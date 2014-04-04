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
    var warn_note = $('#uc_warn_note');
    var uc_warn_width = warn_note.outerWidth();
    warn_note.css('width', warn_note.width()+'px');
    warn_note.css('height', warn_note.height()+'px');
    warn_note.css('top', 3 + 'px');
    warn_note.css('left', jQuery(window).width() - 3 - uc_warn_width + 'px');
    warn_note.find('.uc_warn_wrapper').hide();
    warn_note.show();
    warn_note.effect('slide', {direction: 'up'} , 300, function () { $('.uc_warn_wrapper').show(); $('#uc_warn_note').css('width', 'auto').css('height', 'auto')});
  }
}