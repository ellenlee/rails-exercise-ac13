namespace :dev do

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
