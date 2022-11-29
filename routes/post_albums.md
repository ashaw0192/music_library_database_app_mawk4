POST /albums Route Design Recipe

1. Design the Route Signature

You'll need to include:

the HTTP method
the path
any query parameters (passed in the URL)
or body parameters (passed in the request body)

Posts a new album to the database
method: POST
path: /albums
body params: title, release_year, artist_id

2. Design the Response

# With body parameters
title=Voyage 
release_year=2022
artist_id=2

# Expected response 
200 OK
No content 

3. Write Examples

# Request:

POST /albums?title=Voyage,release_year=2022,artist_id=2 

# Expected response:

Response for 200 OK
