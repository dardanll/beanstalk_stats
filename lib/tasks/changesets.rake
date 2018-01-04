namespace :changesets do
  desc "Import changesets from Beanstalk"
  task import: :environment do

    auth = {username: 'dardanll',
            password: '79aa335abd73db619bbe6edc3d113dd8337b6f33a0197db3a0'}
    page_number = 4032
    loop do
      response = HTTParty.get("https://scopic.beanstalkapp.com/api/changesets.json?&page=#{page_number}&per_page=30", 
                     :basic_auth => auth)

      response = JSON.parse(response.body)

      puts page_number

      break if response.empty? 
      page_number += 1
      create_changesets(response)
    end

  end
end

def create_changesets(changesets)
  changesets.each do |changeset|
    formatted_repo = changeset["revision_cache"].select{|x| Changeset.attribute_names.index(x)}
    formatted_repo.delete("message")

    User.find_by_id(formatted_repo["user_id"]) || User.create(id: formatted_repo["user_id"])
    Changeset.find_by_revision(formatted_repo["revision"]) || Changeset.create!(formatted_repo)
  end
end