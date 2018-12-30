require 'benchmark'

namespace :experiment do
  desc "集計処理のパフォーマンスを比較する"
  task compare_summary_logic_case1: :environment do
    number_of_trial = 500
    Order.uncached do
      Benchmark.bm 12 do |r|
        r.report "map and sum" do
          number_of_trial.times do
            Order.all.map{|order| order.price * order.quantity}.sum
          end
        end

        r.report "inject" do
          number_of_trial.times do
            Order.all.inject(0){|sum, order| sum + order.price * order.quantity}
          end
        end

        r.report "AR sum" do
          number_of_trial.times do
            Order.all.sum("price*quantity")
          end
        end
      end
    end
  end

  desc "集計処理のパフォーマンスを比較する(レコードを取得済みの場合)"
  task compare_summary_logic_case2: :environment do
    number_of_trial = 500
    Order.uncached do
      Benchmark.bm 12 do |r|
        orders = Order.all
        r.report "map and sum" do
          number_of_trial.times do
            orders.map{|order| order.price * order.quantity}.sum
          end
        end

        r.report "inject" do
          number_of_trial.times do
            orders.inject(0){|sum, order| sum + order.price * order.quantity}
          end
        end

        r.report "AR sum" do
          number_of_trial.times do
            orders.sum("price*quantity")
          end
        end
      end
    end
  end
end