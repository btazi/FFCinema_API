# Fast & Furious CINEMA API

## Project to build
This is a test assignment. The instructions [are available here](https://gist.github.com/swistaczek/0fa028af47eb83d19b5da3e6d3092e63).

## The challenge:
A small cinema, which only plays movies from the Fast & Furious franchise, is looking to develop a mobile/web app for their users. Specifically, they wish to support the following functions:

- An internal endpoint in which they (i.e. the cinema owners) can update show times and prices for their movie catalog
- An endpoint in which their customers (i.e. moviegoers) can fetch movie times
- An endpoint in which their customers (i.e. moviegoers) can fetch details about one of their movies (e.g. name, description, release date, rating, IMDb rating, and runtime). Even though there's a limited offering, please use the OMDb APIs (detailed below) to demonstrate how to communicate across APIs.
- An endpoint in which their customers (i.e. moviegoers) can leave a review rating (from 1-5 stars) about a particular movie
- And adding anything else that you think will be useful for the user...

You will be responsible for the first iteration of API which will be used by another engineer, who is developing a studio cinema mobile application. To assist him/her, your design should do the following:
- Creating a persistence layer to save results for certain actions (e.g. via SQL/NoSQL/etc)
- Present API documentation leveraging OpenAPI/Swagger 2.0 standard

# Getting Started:
- bundle install
- `rails db:create`
- `rails db:migrate`
- `rails db:seed` will create the movie db and the test users


- admin user:
email: admin@user.com
password: password

- moviegoer user:
email: moviegover@user.com
password: password

# Available queries:
In order to be logged in you need to include in your headers:
`X-User-Email`, `X-User-Token`
See [simple token auth](https://github.com/gonzalo-bulnes/simple_token_authentication) for more details.

* Sign in:
``` 
POST: /v1/sessions
parameters:
- email: String
- password: String

response example:
{
    "success": true,
    "auth_token": "xx6JaerwCyy3NSJzJyaY",
    "email": "abc@abc.com",
    "id": 1
}
```

* Sign out:
``` 
DELETE: /v1/sessions
Headers:
- X-User-Email: String
- X-User-Token: String
response example:
{
    "success": 200
}
or
{
    "success": false,
    "message": "You are already signed out"
}
```
* Update movie show times and prices:
``` 
PUT: /v1/movies/:id (imdb id)
authorization: admins only
Headers:
- X-User-Email: String
- X-User-Token: String
Parameters:
- movie[price_in_usd] | Float | ex: 7.5 | required
- movie[show_times] | Array of times | ex: ["12:45", "17:30", "20:40"] | required
response example:
{
    "success": true,
    "movie": {
        "show_times": [
            "2000-01-01T08:04:00.000Z"
        ],
        "price_in_usd": 7.8,
        "id": 25,
        "imdb_rating": 6.8,
        "runtime": 106,
        "title": "The Fast and the Furious",
        "imdb_id": "tt0232500",
        "release_date": "2001-06-22",
        "created_at": "2021-08-03T19:48:13.547Z",
        "updated_at": "2021-08-03T21:07:34.797Z"
    }
}
```
* Fetch all movies times:
``` 
GET: /v1/movies
response example:
{
    "success": true,
    "movies": [
        {
            "movie": "2 Fast 2 Furious",
            "imdb_id": "tt0322259",
            "show_times": []
        },
        {
            "movie": "The Fast and the Furious: Tokyo Drift",
            "imdb_id": "tt0463985",
            "show_times": []
        },
        {
            "movie": "Fast & Furious",
            "imdb_id": "tt1013752",
            "show_times": []
        },
        {
            "movie": "Fast Five",
            "imdb_id": "tt1596343",
            "show_times": []
        },
        {
            "movie": "Fast & Furious 6",
            "imdb_id": "tt1905041",
            "show_times": []
        },
        {
            "movie": "Furious 7",
            "imdb_id": "tt2820852",
            "show_times": []
        },
        {
            "movie": "The Fate of the Furious",
            "imdb_id": "tt4630562",
            "show_times": []
        },
        {
            "movie": "The Fast and the Furious",
            "imdb_id": "tt0232500",
            "show_times": [
                "2000-01-01T08:04:00.000Z"
            ]
        }
    ]
}
```
* Fetch movie details:
``` 
GET: /v1/movies/:id (imdb id)
response example: 
{
    "success": true,
    "movie": "{\"runtime\":107,\"release_date\":\"2003-06-06\",\"imdb_rating\":5.9,\"id\":26,\"title\":\"2 Fast 2 Furious\",\"imdb_id\":\"tt0322259\",\"price_in_usd\":null,\"created_at\":\"2021-08-03T19:48:13.554Z\",\"updated_at\":\"2021-08-03T19:48:14.301Z\",\"show_times\":[]}"
}
```
* Create a review:
``` 
POST: /v1/reviews/:movie_imdb_id
authorization: any logged in user
Headers:
- X-User-Email: String
- X-User-Token: String
Parameters:
- movie[rating] | integer (between 0 and 10) | ex: 7 | required
Response example:
{
    "success": true,
    "review": {
        "rating": 7,
        "id": 1,
        "user_id": 1,
        "movie_id": 25,
        "created_at": "2021-08-03T21:48:40.028Z",
        "updated_at": "2021-08-03T21:48:40.028Z"
    }
}
