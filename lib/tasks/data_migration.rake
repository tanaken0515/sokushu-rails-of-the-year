namespace :data_migration do
  desc "Taskのuser_idを埋める"
  task fill_tasks_user_id: :environment do
    user_id = User.first.id  # 一人目のuser_idで雑に埋めちゃう
    Task.update_all("user_id = #{user_id}")  # associationがまだないので条件は直書き
  end

  desc "Orderのサンプルデータを作る"
  task create_sample_orders: :environment do
    ActiveRecord::Base.transaction do
      1000.times do |i|
        Order.create!(quantity: i+1, price: (i+1)*100)
      end
    end
  end
end