namespace :dev do

  task :fake => :environment do
    50.times do |i|
      Topic.create!( :title => Faker::Cat.name, :content => Faker::Lorem.paragraph )
    end
  end

end
