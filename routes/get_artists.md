GET /artists Route Design Recipe

1. Design the Route Signature

You'll need to include:

the HTTP method
the path
any query parameters (passed in the URL)
or body parameters (passed in the request body)

Returns a list of all artists
method: GETS
path: /artists

2. Design the Response

# No paramemters

# Expected Response (200 OK)
Pixies, ABBA, Taylor Swift, Nina Simone

3. Write Examples

# Request:

GET /artists

# Expected response:

200 OK
Pixies, ABBA, Taylor Swift, Nina Simone