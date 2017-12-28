require 'csv'

class CSVSource
  def initialize(options)
    @filename = options.fetch(:filename)
    @csv_options = options.fetch(:csv_options)
    @limit = options.fetch(:limit, nil)
  end
  
  def each
    file_row_index = 0
    CSV.foreach(@filename, @csv_options) do |row|
      file_row_index += 1
      yield(row)
      break if @limit && file_row_index >= @limit
    end
  end
end

class CSVDestination
  attr_reader :filename, :csv_options, :csv, :headers
  
  def initialize(filename: nil, csv_options: nil, headers: nil)
    @filename = filename
    @csv_options = csv_options || {}
    @headers = headers
  end
  
  def write(row)
    @csv ||= ::CSV.open(filename, 'wb', csv_options)
    @headers ||= row.keys
    @headers_written ||= (csv << headers ; true)
#    csv << row.fetch_values(*@headers)
    values = row.values_at(*@headers)
    csv << values
  end
  
  def close
    @csv.close if @csv
  end
end