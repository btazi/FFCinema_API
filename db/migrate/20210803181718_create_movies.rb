class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :imdb_id
      t.date :release_date
      t.float :rating
      t.float :imdb_rating
      t.integer :runtime
      t.float :price_in_usd

      t.timestamps
    end
  end
end
