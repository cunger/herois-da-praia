
task :render_offline_pages => :environment do
  items = []
  ItemCategory.each do |category|
    items << Item.new(beachclean_id: 0, category: category, quantity: 0)
  end

  page = ApplicationController.render(
    file: '/beachcleans/show',
    locals: { '@items': items }
  )

  File.write("#{Rails::root}/public/beachclean_show.html", page)
end
