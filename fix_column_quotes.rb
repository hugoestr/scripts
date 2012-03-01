#!/usr/bin/env ruby
# Script to fix column quotes
# fix_column_quotes.rb  <file> "<column number>"
# Usage ruby fix_column_quotes.rb file.csv "1 23 8 "
require 'csv'

def adjust_quotations(row, columns)
  result = row

  columns.each do |column_id|
    field = row[column_id].to_s.gsub(/"|""/, "'")
    result[column_id] = "\"#{field}\""
  end

  result
end

def process_row(row, columns)
  result = adjust_quotations row, columns
  puts result.to_s.gsub('"""', '"')
end

def write_header(file)
  file = File.open file, "r"
  puts file.readline
  file.close
end

def write_migration_script(csv, columns)
  write_header csv  
  CSV.foreach(csv, :quote_char => '"', :col_sep => ",", :headers => :first_row) do |row|
      process_row row, columns
    end
end


#main script
columns = []
csv = ARGV[0]
columns << ARGV[1].split(" ").map {|x| x.to_i - 1}
write_migration_script(csv, columns.flatten)
