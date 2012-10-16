(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  jQuery(function($) {
    $.fn.carousel = function(opts) {
      var initialize, next, show;
      opts = $.extend({}, $.fn.carousel.defaults, opts);
      next = function() {
        var current, nextIndex, total;
        current = this.data('carousel.index');
        total = this.data('carousel.total');
        nextIndex = current < total - 1 ? current + 1 : 0;
        return show.call(this, nextIndex);
      };
      show = function(index, pause) {
        var current, pauser, seconds, stepper, timeout;
        current = this.data('carousel.index');
        this.find(opts.items + (":eq(" + current + ")")).fadeOut(opts.transition);
        this.find(opts.items + (":eq(" + index + ")")).fadeIn(opts.transition);
        this.data('carousel.index', index);
        if (pause === true) {
          clearInterval(this.data('carousel.timer'));
          clearTimeout(this.data('carousel.pauseTimer'));
          seconds = opts.interval * 1000;
          stepper = __bind(function() {
            return next.call(this);
          }, this);
          pauser = __bind(function() {
            var interval;
            interval = setInterval(stepper, seconds);
            return this.data('carousel.timer', interval);
          }, this);
          timeout = setTimeout(pauser, seconds);
          return this.data('carousel.pauseTimer', timeout);
        }
      };
      initialize = function() {
        var $container, $items;
        $container = $(this);
        $items = $container.find(opts.items);
        $container.data({
          'carousel.index': 0,
          'carousel.total': $items.length,
          'carousel.timer': setInterval((function() {
            return next.call($container);
          }), opts.interval * 1000)
        });
        $items.css('position', 'absolute').filter(':gt(0)').hide();
        return $container.find(opts.navItems).css('cursor', 'pointer').click(function(e) {
          e.preventDefault();
          return show.call($container, $(this).index(), true);
        });
      };
      this.css('position', 'relative');
      return this.each(initialize);
    };
    $.fn.carousel.defaults = {
      items: 'div',
      navItems: 'ul li',
      interval: 5,
      pause: 10,
      transition: 250
    };
    $('#featured-apps').carousel({
      items: 'article',
      navItems: 'ul li'
    });
    return $('.ordering input, .categories input').change(function() {
      var categoriesValue, elem, sortValue;
      sortValue = $('.ordering input:checked').val();
      categoriesValue = ((function() {
        var _i, _len, _ref, _results;
        _ref = $('.categories input:checked');
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          elem = _ref[_i];
          _results.push(elem.value);
        }
        return _results;
      })()).join('+');
      return window.location.search = ("?sort=" + sortValue) + (categoriesValues !== '' ? "&type=" + (encodeURIComponent(categoriesValues)) : void 0);
    });
  });
}).call(this);
