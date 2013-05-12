(function () {

  require(['jquery'], function ($) {

    var displayImg = function (id) {
      var prev, next, nb_img = $('.images .link_img').length;
      id = parseFloat(id, 10);

      $('.images .link_img').hide();
      $('.images a#img_' + id).show();

      if (id + 1 === nb_img) {
        prev = 'link_' + (id - 1);
        next = 'link_0';
      } else if (id - 1 === -1) {
        prev = 'link_' + (nb_img - 1);
        next = 'link_' + (id + 1);
      } else {
        prev = 'link_' + (id - 1);
        next = 'link_' + (id + 1);
      }

      $('.images .nav .prev').attr('id', prev);
      $('.images .nav .next').attr('id', next);
    };

    if ($('.images .link_img').length <= 1) {
      $('.images .nav').hide();
    }

    displayImg(0);

    $('.images .nav a').live('click', function (e) {
      e.preventDefault();
      displayImg($(this).attr('id').substring(5, 6));
    });

  });

}).call(this);