require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  before(:each) do 
    reset_albums_table
    reset_artists_table
  end


  context "GET to /artists" do
    it "returns a list of artists" do
      response = get("/artists")
      expect(response.status).to eq 200
      expect(response.body).to include '<h1>Artists</h1>'
      expect(response.body).to include '<a href="/artists/1"> Pixies </a>'
      expect(response.body).to include '<a href="/artists/2"> ABBA </a>'
    end
  end

  context "GET to /artists/:id" do
    it "returns the 1st artist by id 1" do
      response = get("/artists/1")
      expect(response.status).to eq 200
      expect(response.body).to include '<h1>Pixies</h1>'
      expect(response.body).to include 'Genre: Rock'
    end

    it "returns the 2nd artist by id 2" do
      response = get("/artists/2")
      expect(response.status).to eq 200
      expect(response.body).to include '<h1>ABBA</h1>'
      expect(response.body).to include 'Genre: Pop'

    end
  end

  context "GET to /albums" do
    it "returns all albums" do
      response = get("/albums")
      expect(response.status).to eq 200
      expect(response.body).to include '<h1>Albums</h1>'
      expect(response.body).to include '<a href="/albums/1"> Title: Doolittle - Released: 1989 </a>'
      expect(response.body).to include '<a href="/albums/2"> Title: Surfer Rosa - Released: 1988 </a>'
    end
  end

  context "Get to /albums/:id" do
    it "returns the 1st album by id 1" do
      response = get("/albums/1")
      expect(response.status).to eq 200
      expect(response.body).to include '<h1>Doolittle</h1>' 
      expect(response.body).to include 'Release year: 1989 - Artist: Pixies'
    end

    it "returns the 2nd album by id 2" do
      response = get("/albums/2")
      expect(response.status).to eq 200
      expect(response.body).to include '<h1>Surfer Rosa</h1>' 
      expect(response.body).to include 'Release year: 1988 - Artist: Pixies'
    end
  end

  context "POST to /artists" do
    xit "adds a new artist to the artists table" do
      response = post("/artists", name: "Wild nothing", genre: "Indie")

      expect(response.status).to eq 200

      response = get("/artists")
      expected_response = "Pixies, ABBA, Taylor Swift, Nina Simone, Wild nothing"

      expect(response.status).to eq 200
      expect(response.body).to eq expected_response
    end
  end


  context "POST to /albums" do
    xit "adds a new album to the albums table" do
      response = post("/albums", title: "Voyage", release_year: 2022, artist_id: 2)

      expect(response.status).to eq 200
      
      response = get("/albums")
      expected_response = "Doolittle, Surfer Rosa, Waterloo, Super Trouper, Bossanova, Lover, \
Folklore, I Put a Spell on You, Baltimore, Here Comes the Sun, Fodder on My Wings, Ring Ring, Voyage"

      expect(response.status).to eq 200
      expect(response.body).to eq expected_response
    end
  end
end
