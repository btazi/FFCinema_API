class ChangeMoviesHshowTimesFromDatetimesToTimes < ActiveRecord::Migration[6.1]
  def change
    change_column :movies, :show_times, :time, array: true, default: []
  end
end
