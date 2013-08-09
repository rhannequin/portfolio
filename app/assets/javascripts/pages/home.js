(function () {

  require(['jquery', 'lodash', 'backbone', 'handlebars'], function ($, _, Backbone, Handlebars) {

    var getById = function (id) {
          return document.getElementById(id);
        },
        requireParams = JSON.parse(getById('require-js').getAttribute('data-params')),
        compileHandlebars = function (id) {
          return Handlebars.compile(getById(id).innerHTML);
        },
        projectTemplate  = compileHandlebars('project-template'),
        uploadTemplate   = compileHandlebars('upload-template');

    /* PROJECTS */

    var GaleryItemView = Backbone.View.extend({
      template: uploadTemplate,
      el: '.galery',
      initialize: function (params) {
        this.model = params.model;
        this.id = params.id;
      },
      render: function() {
        this.$el.append(this.template({link: this.model, index: this.id}));
      },
      show: function() {
        $('#galery_item_' + this.id).show();
      }
    });

    var ProjectView = Backbone.View.extend({
      template: projectTemplate,
      initialize: function (params) {
        this.model = params.model;
        this.galeryItemView = new GaleryItemView({
          model: this.model.get('upload_link'),
          id: this.model.get('id')
        });
      },
      render: function () {
        var json = this.model.toJSON();
        this.galeryItemView.render();
        return {
          project: this.$el.html(this.template(json)),
          upload: json.upload_link
        };
      },
      show: function() {
        $('#work_info_' + this.model.get('id')).show();
      }
    });

    var ProjectsList = Backbone.Collection.extend();

    var ProjectsListView = Backbone.View.extend({
      el: '#work',
      events: {
        'click .choice': 'showProjectEvent'
      },
      initialize: function (params) {
        this.collection = new ProjectsList(params.projects);
        this.collectionViews = [];
        this.render();
      },
      render: function () {
        var projects = this.collection.models;
        var projectsLength = projects.length;
        for(var i = 0; i < projectsLength; i++) {
          var projectView = new ProjectView({model: projects[i], index: i});
          var render = projectView.render();
          this.collectionViews.push(projectView);
          this.$el.append(render.project);
        }
        this.displayFirstProject();
        this.displayPagination();
      },
      displayFirstProject: function() {
        var last = this.collectionViews[0];
        this.showProject(last);
      },
      displayPagination: function() {
        var collectionViews = this.collectionViews,
            len             = this.collectionViews.length,
            str             = '';
        for(var i  = 0; i < len; i++) {
          var view = collectionViews[i];
          str += '<span data-id="' + view.model.get('id') + '" class="choice label label-inverse">' + (i+1) + '</span>';
        }
        this.$el.append(str);
      },
      showProjectEvent: function (e) {
        e.preventDefault();
        var id              = parseInt(e.currentTarget.getAttribute('data-id'), 10),
            collectionViews = this.collectionViews;
        for(var i = 0, len = this.collectionViews.length; i < len; i++) {
          var view = collectionViews[i];
          if(view.model.get('id') === id) {
            this.showProject(view);
            break;
          }
        }

      },
      showProject: function (view) {
        $('.work').add('.galery-item').hide();
        view.show();
        view.galeryItemView.show();
      }
    });

    var TweetsView = Backbone.View.extend({
      el: '#contentTweets',
      tweets: JSON.parse(requireParams.tweets),
      initialize: function () {
        this.render();
      },
      render: function () {
        this.$el.html(this.showTweets(this.tweets));
      },
      showTweets: function (tweets) {
        var today           = new Date(),
            tweetsToDisplay = [],
            textDisplay     = '',
            limit           = 7;
        var yesterday = new Date();
        yesterday.setDate(yesterday.getDate() - 1);
        today = today.getDate() + '-' + today.getMonth();
        yesterday = yesterday.getDate() + '-' + yesterday.getMonth();

        for(var i = 0 ; i < limit ; i++) {
          var t = tweets[i];
          if(typeof t !== 'undefined') {
            var text = t.text;
            if(text.substr(0, 1) === '@') {
              limit++;
              continue;
            }
            var tweet = {};
            var dateTime = new Date(t.created_at),
                date = dateTime.getDate() + '-' + dateTime.getMonth(),
                time = dateTime.getHours();
            if(time < 10) {
              time = '0' + time;
            }
            var minutes = dateTime.getMinutes();
            if(minutes < 10) {
              minutes = '0' + minutes;
            }
            time += ':' + minutes;

            switch(date) {
            case today:
              tweet.date = 'Aujourd\'hui';
              break;
            case yesterday:
              tweet.date = 'Hier';
              break;
            default:
              tweet.date = dateTime.getDate() + ' ' + this.replaceMonth(dateTime.getMonth()) + ' ' + dateTime.getFullYear();
              break;
            }

            tweet.text = this.clean(text);
            tweet.time = time;
            if(typeof tweetsToDisplay[tweet.date] === 'undefined') {
              tweetsToDisplay[tweet.date] = [];
            }
            tweetsToDisplay[tweet.date].push(tweet);
          }
        }

        for (var todaysTweets in tweetsToDisplay) {
          var todaysTweetsObj = tweetsToDisplay[todaysTweets],
              todaysTweetsCount = todaysTweetsObj.length;
          textDisplay += '<h3>' + todaysTweets + '</h3>';

          for(var j = 0 ; j < todaysTweetsCount ; j++) {
            var tw = todaysTweetsObj[j];
            textDisplay += '<div class="row-fluid"><div class="span2">' + tw.time + ' : </div><div class="span10">' + tw.text + '</div></div>';
          }

        }
        return textDisplay;
      },
      link: function(tweet) {
        return tweet.replace(/\b(((https*\:\/\/)|www\.)[^\"\']+?)(([!?,.\)]+)?(\s|$))/g, function(link, m1, m2, m3, m4) {
          var http = m2.match(/w/) ? 'http://' : '';
          return '<a target="_blank" href="' + http + m1 + '">' + ((m1.length > 25) ? m1.substr(0, 24) + '...' : m1) + '</a>' + m4;
        });
      },
      at: function(tweet) {
        return tweet.replace(/\B[@＠]([a-zA-Z0-9_]{1,20})/g, function(m, username) {
          return '<a target="_blank" href="http://twitter.com/intent/user?screen_name=' + username + '">@' + username + '</a>';
        });
      },
      list: function(tweet) {
        return tweet.replace(/\B[@＠]([a-zA-Z0-9_]{1,20}\/\w+)/g, function(m, userlist) {
          return '<a target="_blank" href="http://twitter.com/' + userlist + '">@' + userlist + '</a>';
        });
      },
      hash: function(tweet) {
        return tweet.replace(/(^|\s+)#(\w+)/gi, function(m, before, hash) {
          return before + '<a target="_blank" href="http://twitter.com/search?q=%23' + hash + '">#' + hash + '</a>';
        });
      },
      clean: function(tweet) {
        return this.hash(this.at(this.list(this.link(tweet))));
      },
      replaceMonth: function (i) {
        var month = {
          '0':  'janvier',
          '1':  'février',
          '2':  'mars',
          '3':  'avril',
          '4':  'mai',
          '5':  'juin',
          '6':  'juillet',
          '7':  'août',
          '8':  'septembre',
          '9':  'octobre',
          '10': 'novembre',
          '11': 'décembre'
        };
        return month[i];
      }
    });

    var MainView = Backbone.View.extend({
      initialize: function () {
        var projects = JSON.parse(requireParams.projects);
        this.projectsListView = new ProjectsListView({projects: projects});
        this.tweetsView = new TweetsView();
      }
    });

    new MainView();

  });

}).call(this);