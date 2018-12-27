task :render_offline_pages => :environment do
  # Show beachclean

  items = []
  ItemCategory.each do |category|
    items << Item.new(beachclean_id: 0, category: category, quantity: 0)
  end

  beachcleans_page = ApplicationController.render(
    file: '/beachcleans/show',
    locals: { '@items': items }
  )

  File.write("#{Rails::root}/public/beachclean_show.html", beachcleans_page)

  # Offline and error pages

  offline_page = ApplicationController.render('/errors/offline')
  File.write("#{Rails::root}/public/offline.html", offline_page)

  error_page = ApplicationController.render('/errors/error')
  File.write("#{Rails::root}/public/error.html", error_page)

  page_404 = ApplicationController.render('/errors/404')
  File.write("#{Rails::root}/public/404.html", page_404)

  page_500 = ApplicationController.render('/errors/500')
  File.write("#{Rails::root}/public/500.html", page_500)
end
