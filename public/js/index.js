(function() {
  var _ref, _ref1, _ref2, _ref3, _ref4, _ref5, _ref6, _ref7, _ref8, _ref9,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.App = new Backbone.Marionette.Application();

  App.Models = {};

  App.Views = {};

  $(function() {
    var card1, card2, card3, card4, corpModel, corpPile1, corpPile2, corpPiles, corpView, noCards, noCardsPile1, noCardsPile2, runnerModel, runnerPile1, runnerPile2, runnerPiles, runnerView;
    App.addRegions({
      leftPlayRegion: '.play-region.left',
      rightPlayRegion: '.play-region.right',
      zoomedCardRegion: '.zoomed-card-container'
    });
    card1 = new App.Models.CardModel({
      cardId: '02009'
    });
    card2 = new App.Models.CardModel({
      cardId: '03046'
    });
    card3 = new App.Models.CardModel({
      cardId: '04030'
    });
    card4 = new App.Models.CardModel({
      cardId: '04031'
    });
    noCards = new App.Models.CardCollection();
    noCardsPile1 = new App.Models.PileModel({
      cards: noCards
    });
    noCardsPile2 = new App.Models.PileModel({
      cards: noCards
    });
    runnerPile1 = new App.Models.PileModel({
      cards: new App.Models.CardCollection([card1])
    });
    runnerPile2 = new App.Models.PileModel({
      cards: new App.Models.CardCollection([card2])
    });
    corpPile1 = new App.Models.PileModel({
      cards: new App.Models.CardCollection([card3])
    });
    corpPile2 = new App.Models.PileModel({
      cards: new App.Models.CardCollection([card4])
    });
    runnerPiles = new App.Models.PileCollection([noCardsPile1, runnerPile1, runnerPile2, noCardsPile2]);
    corpPiles = new App.Models.PileCollection([noCardsPile1, corpPile1, corpPile2, noCardsPile2]);
    runnerModel = new App.Models.PlayerModel({
      side: 'runner',
      piles: runnerPiles
    });
    corpModel = new App.Models.PlayerModel({
      side: 'corp',
      piles: corpPiles
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

  App.Models.CardCollection = (function(_super) {
    __extends(CardCollection, _super);

    function CardCollection() {
      _ref = CardCollection.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    CardCollection.prototype.model = App.Models.CardModel;

    return CardCollection;

  })(Backbone.Collection);

  App.Models.CardModel = (function(_super) {
    var CARD_IMG_PATH, CARD_IMG_SUFFIX;

    __extends(CardModel, _super);

    function CardModel() {
      _ref1 = CardModel.__super__.constructor.apply(this, arguments);
      return _ref1;
    }

    CardModel.prototype.defaults = {
      cardId: null,
      faceUp: false
    };

    CARD_IMG_PATH = 'http://netrunnerdb.com/web/bundles/netrunnerdbcards/images/cards/en/';

    CARD_IMG_SUFFIX = '.png';

    CardModel.prototype.initialize = function() {
      return this.preloadImage();
    };

    CardModel.prototype.toggleFacing = function() {
      return this.set('faceUp', !this.get('faceUp'));
    };

    CardModel.prototype.imagePath = function() {
      return CARD_IMG_PATH + this.get('cardId') + CARD_IMG_SUFFIX;
    };

    CardModel.prototype.preloadImage = function() {
      var dfr, image;
      dfr = $.Deferred();
      image = new Image();
      image.src = this.imagePath();
      image.addEventListener('load', dfr.resolve);
      return dfr.promise();
    };

    return CardModel;

  })(Backbone.Model);

  App.Models.PileCollection = (function(_super) {
    __extends(PileCollection, _super);

    function PileCollection() {
      _ref2 = PileCollection.__super__.constructor.apply(this, arguments);
      return _ref2;
    }

    PileCollection.prototype.model = App.Models.Card;

    return PileCollection;

  })(Backbone.Collection);

  App.Models.PileModel = (function(_super) {
    __extends(PileModel, _super);

    function PileModel() {
      _ref3 = PileModel.__super__.constructor.apply(this, arguments);
      return _ref3;
    }

    PileModel.prototype.defaults = {
      cards: null
    };

    return PileModel;

  })(Backbone.Model);

  App.Models.PlayerModel = (function(_super) {
    __extends(PlayerModel, _super);

    function PlayerModel() {
      _ref4 = PlayerModel.__super__.constructor.apply(this, arguments);
      return _ref4;
    }

    PlayerModel.prototype.defaults = {
      side: null
    };

    return PlayerModel;

  })(Backbone.Model);

  App.Views.BaseCardView = (function(_super) {
    var ASPECT_RATIO_IMG;

    __extends(BaseCardView, _super);

    function BaseCardView() {
      _ref5 = BaseCardView.__super__.constructor.apply(this, arguments);
      return _ref5;
    }

    BaseCardView.prototype.template = _.template('');

    BaseCardView.prototype.className = 'card';

    BaseCardView.prototype.tagName = 'img';

    ASPECT_RATIO_IMG = '/images/cards/aspect.png';

    BaseCardView.prototype.onRender = function() {
      var _this = this;
      if (this.model.get('faceUp')) {
        return this.model.preloadImage().then(function() {
          return _this.$el.attr({
            src: _this.model.imagePath()
          });
        });
      } else {
        return this.$el.attr({
          src: ASPECT_RATIO_IMG
        });
      }
    };

    return BaseCardView;

  })(Backbone.Marionette.ItemView);

  App.Views.CardView = (function(_super) {
    var ZOOM_TIMEOUT;

    __extends(CardView, _super);

    function CardView() {
      _ref6 = CardView.__super__.constructor.apply(this, arguments);
      return _ref6;
    }

    ZOOM_TIMEOUT = 150;

    CardView.prototype.modelEvents = {
      'change:faceUp': 'render'
    };

    CardView.prototype.events = {
      'click': '_toggleFacing',
      'mousedown': '_startCountingTimeForZoom',
      'mouseup': '_stopCountingTimeForZoom',
      'mouseout': '_stopZooming'
    };

    CardView.prototype._toggleFacing = function() {
      if (this.isZooming) {
        return this._stopZooming();
      } else {
        return this.model.toggleFacing();
      }
    };

    CardView.prototype._startCountingTimeForZoom = function() {
      var _this = this;
      if (!this.model.get('faceUp')) {
        return;
      }
      return this.zoomTimeoutId = setTimeout((function() {
        return _this._zoomCard();
      }), ZOOM_TIMEOUT);
    };

    CardView.prototype._stopCountingTimeForZoom = function() {
      if (this.zoomTimeoutId) {
        clearTimeout(this.zoomTimeoutId);
        return this.zoomTimeoutId = void 0;
      }
    };

    CardView.prototype._zoomCard = function() {
      this.isZooming = true;
      this.zoomedCard = new App.Views.ZoomedCardView({
        model: this.model
      });
      return App.zoomedCardRegion.show(this.zoomedCard);
    };

    CardView.prototype._stopZooming = function() {
      if (this.isZooming) {
        this.zoomedCard.hide();
        return this.isZooming = false;
      }
    };

    return CardView;

  })(App.Views.BaseCardView);

  App.Views.ZoomedCardView = (function(_super) {
    var ZOOM_FADE_DURATION;

    __extends(ZoomedCardView, _super);

    function ZoomedCardView() {
      _ref7 = ZoomedCardView.__super__.constructor.apply(this, arguments);
      return _ref7;
    }

    ZOOM_FADE_DURATION = 250;

    ZoomedCardView.prototype.onBeforeShow = function() {
      return this.$el.addClass('hidden');
    };

    ZoomedCardView.prototype.onShow = function() {
      var _this = this;
      return setTimeout((function() {
        return _this.$el.removeClass('hidden');
      }), 10);
    };

    ZoomedCardView.prototype.hide = function() {
      var _this = this;
      this.$el.addClass('hidden');
      return setTimeout((function() {
        return _this.destroy();
      }), ZOOM_FADE_DURATION);
    };

    return ZoomedCardView;

  })(App.Views.BaseCardView);

  App.Views.PileView = (function(_super) {
    __extends(PileView, _super);

    function PileView() {
      _ref8 = PileView.__super__.constructor.apply(this, arguments);
      return _ref8;
    }

    PileView.prototype.className = 'pile';

    PileView.prototype.template = _.template($('#pile-view-template').html());

    PileView.prototype.childView = App.Views.CardView;

    PileView.prototype.initialize = function(options) {
      return this.collection = options.model.get('cards');
    };

    return PileView;

  })(Backbone.Marionette.CollectionView);

  App.Views.PlayerView = (function(_super) {
    __extends(PlayerView, _super);

    function PlayerView() {
      _ref9 = PlayerView.__super__.constructor.apply(this, arguments);
      return _ref9;
    }

    PlayerView.prototype.className = 'player';

    PlayerView.prototype.template = _.template($('#player-view-template').html());

    PlayerView.prototype.childView = App.Views.PileView;

    PlayerView.prototype.childViewContainer = '.piles';

    PlayerView.prototype.initialize = function(options) {
      return this.collection = options.model.get('piles');
    };

    PlayerView.prototype.onRender = function() {
      return this.$el.addClass(this.model.get('side'));
    };

    return PlayerView;

  })(Backbone.Marionette.CompositeView);

}).call(this);
