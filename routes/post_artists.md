POST /artists Route Design Recipe

1. Design the Route Signature

Creates a new artists in table
method: POST
path: /artists
body parameters: :name, :genre

2. Design the Response

# With body parameters
name=Wild nothing
genre=Indie

# Expected response (200 OK)
no content

3. Write Examples

# Request:

POST /artists?name=Wild nothing,genre=Indie

# Expected response:

Response for 200 OK
