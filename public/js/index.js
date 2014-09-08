(function() {
  var _ref, _ref1, _ref2,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.App = new Backbone.Marionette.Application();

  App.Models = {};

  App.Views = {};

  $(function() {
    var corpModel, corpView, runnerModel, runnerView;
    App.addRegions({
      leftPlayRegion: '.play-region.left',
      rightPlayRegion: '.play-region.right'
    });
    runnerModel = new App.Models.PlayerModel({
      side: 'runner'
    });
    corpModel = new App.Models.PlayerModel({
      side: 'corp'
    });
    runnerView = new App.Views.PlayerView({
      model: runnerModel
    });
    corpView = new App.Views.PlayerView({
      model: corpModel
    });
    App.leftPlayRegion.show(runnerView);
    return App.rightPlayRegion.show(corpView);
  });

  App.Models.PlayerModel = (function(_super) {
    __extends(PlayerModel, _super);

    function PlayerModel() {
      _ref = PlayerModel.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    PlayerModel.prototype.defaults = {
      side: null
    };

    return PlayerModel;

  })(Backbone.Model);

  App.Views.CardView = (function(_super) {
    __extends(CardView, _super);

    function CardView() {
      _ref1 = CardView.__super__.constructor.apply(this, arguments);
      return _ref1;
    }

    CardView.prototype.template = _.template('');

    CardView.prototype.className = 'card';

    return CardView;

  })(Backbone.Marionette.ItemView);

  App.Views.PlayerView = (function(_super) {
    __extends(PlayerView, _super);

    function PlayerView() {
      _ref2 = PlayerView.__super__.constructor.apply(this, arguments);
      return _ref2;
    }

    PlayerView.prototype.className = 'player';

    PlayerView.prototype.onRender = function() {
      return this.$el.addClass(this.model.get('side'));
    };

    PlayerView.prototype.getTemplate = function() {
      var templateName;
      templateName = "#" + (this.model.get('side')) + "-player-view";
      return _.template($(templateName).html());
    };

    return PlayerView;

  })(Backbone.Marionette.LayoutView);

}).call(this);
