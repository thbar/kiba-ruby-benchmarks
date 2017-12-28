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
