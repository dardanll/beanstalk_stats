namespace :repositories do
  desc "Import repositories from Beanstalk"
  task import: :environment do

    auth = {username: 'dardanll',
            password: '79aa335abd73db619bbe6edc3d113dd8337b6f33a0197db3a0'}
    repositories = []
    page_number = 1
    loop do
      response = HTTParty.get("https://scopic.beanstalkapp.com/api/repositories.json?page=#{page_number}&per_page=30", 
                     :basic_auth => auth)

      response = JSON.parse(response.body)

      puts page_number

      break if response.empty?
      repositories << response
      page_number += 1
    end

    create_repositories(repositories.flatten)
  end
end

def create_repositories(repositories)
  repositories.each do |repository|
    formatted_repo = repository["repository"].select{|x| Repository.attribute_names.index(x)}
    Repository.find_by_id(formatted_repo["id"]) || Repository.create!(formatted_repo)
  end
end