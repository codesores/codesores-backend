require 'csv'

CSV.open("./training.csv", "wb") do |csv|
  Issue.all.each do |issue|
    csv << [issue.title, rand(1..5)]
  end
end

