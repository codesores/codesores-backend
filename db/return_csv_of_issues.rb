require 'csv'

CSV.open("./training.csv", "wb") do |csv|
    csv << ['complexity', 'issue', 'url']
  Issue.all.each do |issue|
    csv << ['', "TITLE: #{issue.title} BODY: #{issue.title}", issue.url]
  end
end

