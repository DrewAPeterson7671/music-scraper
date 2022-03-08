require 'csv'

namespace :db do
  task :import_csv => :environment do
    CSV.foreach("import.csv", :headers => true) do |row|
      pattern_a = /^((a)\s)/i
      pattern_the = /^((the)\s)/i
      
      if row["name"].match?(pattern_a)
        row["name"].sub!(pattern_a, "").concat(', A')
      end
      
      if row["name"].match?(pattern_the)
        row["name"].sub!(pattern_the, "").concat(', The')
      end
      
      puts row["name"]
      Artist.create!(row.to_hash)
    end
  end
end
