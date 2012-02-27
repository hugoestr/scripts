#!/usr/bin/env ruby
# Script to fix column quotes
require 'csv'

def adjust_quotations(row, columns)
  result = row

  columns.each do |column_id|
    result[column_id] = row[column_id.to_i].inspect
  end

  result
end

def process_row(row, columns)
  result = adjust_quotations row, columns
  puts result.to_s.gsub('"""', '"')
end

def write_migration_script(csv, columns)
    CSV.foreach(csv, :quote_char => '"', :col_sep => ",", :headers => :first_row) do |row|
      process_row row, columns
    end
end


#main script
columns = []
csv = ARGV[0]
columns << ARGV[1].split(" ").map {|x| x.to_i}
write_migration_script(csv, columns.flatten)
