this.EtherMarket = (function(Backbone, Marionette) {
  var App;

  App = new Marionette.Application;

  App.addRegions({
    headerRegion: "#header-region",
    appRegion: "#app-region"
  });

  App.on("start", function(options) {
    if (Backbone.history) {
      return Backbone.history.start({
        pushState: true
      });
    }
  });

  App.addInitializer(function() {});

  return App;

})(Backbone, Marionette);
