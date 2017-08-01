require 'csv'

CSV.open("./training.csv", "wb") do |csv|
    csv << ['validity', 'issue', 'url']
  Issue.all.each do |issue|
    csv << [rand(1..5), "TITLE: #{issue.title} BODY: #{issue.body}", issue.url]
  end
end

