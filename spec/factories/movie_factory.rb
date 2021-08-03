FactoryBot.define do
  factory :movie do
    title {"The Fast and the Furious"}
    imdb_id { "tt0232500" }
    release_date { Date.parse("26-09-2001") }
    rating { nil }
    imdb_rating { 6.8 }
    runtime { 106 }
    price_in_usd { 8.50 }
    show_times { [] }
  end
end
