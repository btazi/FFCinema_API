class AddShowTimesToMovies < ActiveRecord::Migration[6.1]
  def change
    add_column :movies, :show_times, :datetime, array: true, default: []
  end
end
