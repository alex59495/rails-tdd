describe 'HTTParty' do
  # it 'content type', vcr: { cassette_name: 'jsonplaceholder/posts', match_requests_on: [:body]} do
  it 'content type', vcr: { cassette_name: 'jsonplaceholder/posts', record: :new_episodes} do
    # stub_request(:get, "https://jsonplaceholder.typicode.com/posts/2").
    #      with(
    #        headers: {
    #    	  'Accept'=>'*/*',
    #    	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
    #    	  'User-Agent'=>'Ruby'
    #        }).
    #      to_return(status: 200, body: "", headers: { 'content-type': 'application/json' })

    # VCR.use_cassette("jsonplaceholder/posts") do
      response = HTTParty.get("https://jsonplaceholder.typicode.com/posts/#{[1,2,3,4,5].sample}")
      content_type = response.headers['content-type']
      expect(content_type).to match(/application\/json/)
    # end
  end
end