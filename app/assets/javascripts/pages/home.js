(function () {

  require([
    'jquery',
    'lodash',
    'backbone',
    'handlebars'
  ], function ($, _, Backbone, Handlebars) {

    /* PROJECTS */

    var ProjectView = Backbone.View.extend({
      template: Handlebars.compile($('#project-template').html()),
      initialize: function (params) {
        this.model = params.model;
      },
      render: function () {
        var json = this.model.toJSON();
        return {
          project: this.$el.html(this.template(json)),
          upload: json.upload_link
        };
      }
    });

    var ProjectsList = Backbone.Collection.extend();

    var ProjectsListView = Backbone.View.extend({
      el: '#work',
      $galery: $('.galery'),
      initialize: function (params) {
        this.collection = new ProjectsList(params.projects);
        this.render();
      },
      render: function () {
        var projects = this.collection.models;
        var projectsLength = projects.length;
        for(var i = 0; i < projectsLength; i++) {
          var projectView = new ProjectView({model: projects[i]});
          var render = projectView.render();
          this.$el.append(render.project);
          if(render.upload) {
            this.$galery.append('<img src="' + render.upload + '" alt="" />');
          }
        }
      }
    });

    var MainView = Backbone.View.extend({

      initialize: function () {
        var projects = JSON.parse($('#require-js').data('params').projects);
        this.projectsListView = new ProjectsListView({projects: projects});
      }

    });

    new MainView();

  });

}).call(this);