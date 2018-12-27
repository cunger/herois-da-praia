task :render_offline_pages => :environment do
  def replaceAssets(content, include_js = false)
    # Removes CSS and Javascript tags, and inserts a link to a static version
    # of the assets. This is because there will be new finger prints more often
    # than this task is run.

    static_assets = (include_js ? '<script src="application.js">' : '') +
      '<link rel="stylesheet" media="all" href="application.css">'

    content = content
      .gsub(/<link rel="stylesheet".*?\/>/, '')
      .gsub(/<script.*?<\/script>/, '')
      .gsub(/<\/head>/, static_assets + '</head>')
      .squish
  end

  # Show beachclean

  items = []
  ItemCategory.each do |category|
    items << Item.new(beachclean_id: 0, category: category, quantity: 0)
  end

  beachcleans_page = ApplicationController.render(
    file: '/beachcleans/show',
    locals: { '@items': items }
  )

  File.write("#{Rails::root}/public/beachclean_show.html", replaceAssets(beachcleans_page, true))

  # Offline and error pages

  offline_page = ApplicationController.render('/errors/offline')
  File.write("#{Rails::root}/public/offline.html", replaceAssets(offline_page))

  error_page = ApplicationController.render('/errors/error')
  File.write("#{Rails::root}/public/error.html", replaceAssets(error_page))

  page_404 = ApplicationController.render('/errors/404')
  File.write("#{Rails::root}/public/404.html", replaceAssets(page_404))

  page_500 = ApplicationController.render('/errors/500')
  File.write("#{Rails::root}/public/500.html", replaceAssets(page_500))
end
