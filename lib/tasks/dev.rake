namespace :dev do

  task :ubike => :environment do
    url = 'http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=ddb80380-f1b3-4f8e-8016-7ed9cba571d5'
    response = RestClient.get(url)
    data = JSON.parse( response.body )

    data["result"]["results"].each do |u|
      existing = Ubike.find_by_raw_id( u["_id"] )
      if existing
      # update
      else
        Ubike.create( :raw_id => u["_id"], :name => u["sna"])
        puts "create #{u["sna"]}"
       end
    end
  end

  task :fake => :environment do
    users = []
    10.times do
      users << User.create!( :email => Faker::Internet.email, :password => "12345678")
    end

    50.times do |i|
      topic = Topic.create!( :title => Faker::Cat.name,
                     :content => Faker::Lorem.paragraph,
                     :user_id => users.sample.id )

      rand(10).times do
        Like.create!( :user => users.sample, :topic => topic )
      end
    end
  end

end
