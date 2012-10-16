jQuery ($) ->

	$.fn.carousel = (opts) ->
		opts = $.extend {}, $.fn.carousel.defaults, opts

		next = () ->
			current = @data 'carousel.index'
			total = @data 'carousel.total'
			nextIndex = if current < total - 1 then current + 1 else 0

			show.call @, nextIndex

		show = (index, pause) ->
			current = @data 'carousel.index'

			@find(opts.items + ":eq(#{current})")
				.fadeOut opts.transition
			@find(opts.items + ":eq(#{index})")
				.fadeIn opts.transition

			@data 'carousel.index', index

			if pause == true
				clearInterval @data 'carousel.timer'
				clearTimeout @data 'carousel.pauseTimer'
				seconds = opts.interval * 1000
				
				stepper = => next.call @
				pauser = =>
					interval = setInterval stepper, seconds
					@data 'carousel.timer', interval

				timeout = setTimeout pauser, seconds
				@data 'carousel.pauseTimer', timeout

		initialize = () ->
			$container = $ @
			$items = $container.find opts.items

			$container.data
				'carousel.index': 0
				'carousel.total': $items.length
				'carousel.timer': setInterval (-> next.call $container), opts.interval * 1000
				
			$items
				.css('position', 'absolute')
				.filter(':gt(0)').hide()

			$container.find(opts.navItems)
				.css('cursor', 'pointer')
				.click (e) ->
					e.preventDefault()
					show.call $container, $(this).index(), true

		@css 'position', 'relative'
		@each initialize
	
	$.fn.carousel.defaults =
		items: 'div'
		navItems: 'ul li'
		interval: 5
		pause: 10
		transition: 250
	
	$('#featured-apps').carousel
		items: 'article'
		navItems: 'ul li'
	
	$('.ordering input, .categories input').change ->
		sortValue = $('.ordering input:checked').val()
		categoriesValue = (elem.value for elem in $ '.categories input:checked').join '+'

		if categoriesValue == ''
			window.location.search = "?sort=#{sortValue}"
		else
			window.location.search = "?sort=#{sortValue}" +
				("&type=#{encodeURIComponent categoriesValue}" unless categoriesValue == '')
