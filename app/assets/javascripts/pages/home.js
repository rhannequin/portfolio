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

    var TweetsView = Backbone.View.extend({
      el: '#contentTweets',
      apiUrl: 'http://api.twitter.com/1/statuses/user_timeline.json',
      tweetsParams: {
        screen_name: 'rhannequin',
        count: 50
      },
      tweets: [],
      initialize: function () {
        this.makeRequest();
      },
      render: function () {
        this.$el.html(this.showTweets(this.tweets));
      },
      makeRequest: function () {
        var self = this;
        var request = $.ajax({
          url: this.apiUrl,
          data: this.tweetsParams,
          dataType: 'jsonp',
        });
        request.done(function (res) {
          self.tweets = res;
          self.render();
        });
      },
      showTweets: function (tweets) {
        var today           = new Date(),
            tweetsToDisplay = [],
            textDisplay     = '',
            limit           = 5;
        var yesterday = new Date();
        yesterday.setDate(yesterday.getDate() - 1);
        today = today.getDate() + '-' + today.getMonth();
        yesterday = yesterday.getDate() + '-' + yesterday.getMonth();

        for(var i = 0 ; i < limit ; i++) {
          var t = tweets[i],
              text = t.text;
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
        var projects = JSON.parse($('#require-js').data('params').projects);
        this.projectsListView = new ProjectsListView({projects: projects});
        this.tweetsView = new TweetsView();
      }
    });

    new MainView();

  });

}).call(this);