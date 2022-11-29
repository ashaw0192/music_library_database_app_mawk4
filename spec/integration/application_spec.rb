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
      response = get("artists")
      expected_response = "Pixies, ABBA, Taylor Swift, Nina Simone"
      
      expect(response.status).to eq 200
      expect(response.body).to eq expected_response
    end
  end

  context "GET to /albums" do
    it "returns all albums" do
      response = get("/albums")
      expected_response = "Doolittle, Surfer Rosa, Waterloo, Super Trouper, Bossanova, Lover, \
Folklore, I Put a Spell on You, Baltimore, Here Comes the Sun, Fodder on My Wings, Ring Ring"
      expect(response.status).to eq 200
      expect(response.body).to eq expected_response
    end
  end

  context "POST to /artists" do
    it "adds a new artist to the artists table" do
      response = post("/artists", name: "Wild nothing", genre: "Indie")

      expect(response.status).to eq 200

      response = get("/artists")
      expected_response = "Pixies, ABBA, Taylor Swift, Nina Simone, Wild nothing"

      expect(response.status).to eq 200
      expect(response.body).to eq expected_response
    end
  end


  context "POST to /albums" do
    it "adds a new album to the albums table" do
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
