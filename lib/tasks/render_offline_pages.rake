
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

  # Offline pages

  offline_page = ApplicationController.render('/offline/offline')
  File.write("#{Rails::root}/public/offline.html", offline_page)

  error_page = ApplicationController.render('/offline/error')
  File.write("#{Rails::root}/public/error.html", error_page)
end
