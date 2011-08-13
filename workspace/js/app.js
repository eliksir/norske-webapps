(function ($) {

	$.fn.carousel = function (opts) {
		opts = $.extend({}, $.fn.carousel.defaults, opts);

		function next () {
			var current = this.data('carousel.index'),
				total = this.data('carousel.total'),
				nextIndex = current < (total - 1) ? (current + 1) : 0;

			show.call(this, nextIndex);
		}

		function show (index, pause) {
			var current = this.data('carousel.index');

			this.find(opts.items + ':eq(' + current + ')').fadeOut(opts.transition);
			this.find(opts.items + ':eq(' + index + ')').fadeIn(opts.transition);

			this.data('carousel.index', index);

			if (pause === true) {
				var self = this;

				clearInterval(this.data('carousel.timer'));
				clearTimeout(this.data('carousel.pauseTimer'));

				this.data('carousel.pauseTimer', setTimeout(function () {
					self.data('carousel.timer', setInterval(function () {
						next.call(self);
					}, opts.interval * 1000));
				}, opts.pause * 1000));
			}
		}

		this
			.css('position', 'relative')
			.each(function () {
				var $this = $(this),
					$items = $this.find(opts.items);

				$this
					.data('carousel.index', 0)
					.data('carousel.total', $items.length)
					.data('carousel.timer', setInterval(function () {
						next.call($this);
					}, opts.interval * 1000));

				$items
					.css('position', 'absolute')
					.filter(':gt(0)').hide();
				
				$this.find(opts.navItems)
					.css('cursor', 'pointer')
					.click(function (e) {
						e.preventDefault();
						show.call($this, $(this).index(), true);
					});
			});

		return this;
	};
	$.fn.carousel.defaults = {
		items: 'div',
		navItems: 'ul li',
		interval: 5,
		pause: 10,
		transition: 250
	};

	// Create a carousel out of the featured apps
	$('#featured-apps').carousel({
		items: 'article',
		navItems: 'ul li'
	});

	// Handle changes in sort order or categories in listings
	$('section.ordering input, section.categories input')
		.change(function () {
			var sortValue = $('section.ordering input:checked').val(),
				$categories = $('section.categories input:checked'),
				categoriesValue = '';

			$categories.each(function (i) {
				categoriesValue += i == 0 ? this.value : '+' + this.value;
			});

			window.location.search = '?sort=' + sortValue +
				(categoriesValue === '' ? '' : '&type=' + encodeURIComponent(categoriesValue));
		});

})(jQuery);
