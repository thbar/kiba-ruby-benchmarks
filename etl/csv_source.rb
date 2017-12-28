require 'csv'

class CSVSource
  def initialize(filename:, csv_options:, limit: nil)
    @filename = filename
    @csv_options = csv_options
    @limit = limit
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
