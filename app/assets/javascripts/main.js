(function () {

  require.config({
    shim: {
      lodash: {
        exports: '_'
      },
      backbone: {
        deps: ['lodash'],
        exports: 'Backbone'
      },
      handlebars: {
        exports: 'Handlebars'
      }
    },
    paths: {
      jquery: 'jquery.min',
      bootstrap: 'bootstrap.min',
      backbone: 'backbone-min',
      lodash: 'lodash.min',
      handlebars: 'handlebars.min'
    },
    baseUrl: '/assets/'
  });

  require(['jquery', 'bootstrap'], function ($) {
    var script = $('#require-js').data('script');
    if(script.length) {
      require([script]);
    }
  });

}).call(this);