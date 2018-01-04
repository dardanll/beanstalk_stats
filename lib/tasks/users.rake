namespace :users do
  desc "Import user from Beanstalk"
  task import: :environment do

    auth = {username: 'dardanll',
            password: '79aa335abd73db619bbe6edc3d113dd8337b6f33a0197db3a0'}

    page_number = 1
    loop do
      response = HTTParty.get("https://scopic.beanstalkapp.com/api/users.json?page=#{page_number}&per_page=30", 
                     :basic_auth => auth)
      response = JSON.parse(response.body)
      
      puts page_number
      break if response.empty?
      page_number += 1
      
      create_users(response)
    end
  end
end

def create_users(users)
  users.each do |user|
    formatted_user = user["user"].except("account_id", "can_create_repos")
    User.find_by_id(formatted_user["id"]) || User.create(formatted_user)
  end
end
