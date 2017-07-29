require_relative 'fake_server_response'

# Repos.delete_all
# Issues.delete_all


@freecodecamp_issues[:data][:repository][:issues][:edges].each do |obj|

   obj.each do |key, value|
      p value[:title]
      p value[:labels][:edges]
      p value[:createdAt]
      p value[:comments][:totalCount]
      p value[:url]
      p value[:author][:login]
      p value[:participants][:totalCount]
      p value[:assignees][:totalCount]
      p value[:repository][:nameWithOwner].match(/\/.*/).to_s[(1..-1)]
   end
end

@webpack_issues[:data][:repository][:issues][:edges].each do |obj|

   obj.each do |key, value|
      p value[:title]
      p value[:labels][:edges]
      p value[:createdAt]
      p value[:comments][:totalCount]
      p value[:url]
      p value[:author][:login]
      p value[:participants][:totalCount]
      p value[:assignees][:totalCount]
      p value[:repository][:nameWithOwner].match(/\/.*/).to_s[(1..-1)]
   end
end

@modernizr_issues[:data][:repository][:issues][:edges].each do |obj|

   obj.each do |key, value|
      p value[:title]
      p value[:labels][:edges]
      p value[:createdAt]
      p value[:comments][:totalCount]
      p value[:url]
      p value[:author][:login]
      p value[:participants][:totalCount]
      p value[:assignees][:totalCount]
      p value[:repository][:nameWithOwner].match(/\/.*/).to_s[(1..-1)]
   end
end


