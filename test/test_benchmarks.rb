require_relative 'helper'
require 'csv'

class TestParser < Minitest::Test
  def measure(msg)
    t = Time.now
    return yield
  ensure
    puts "Measure #{msg} - #{(Time.now - t).round(2)} seconds"
  end
  
  def filepath
    'data/sample.csv'
  end

  def setup
    return if File.exist?(filepath)
    File.open(filepath, 'w') do |f|
      f << ['index', 'some_string'].to_csv
      500_000.times do |i|
        f << [i, "SomeString-#{i}"].to_csv
      end
    end
  end
  
  def test_works
    count = 0
    measure("csv-foreach") do
      CSV.foreach(filepath, headers: true) do |row|
        count += 1
      end
    end
    assert_equal 500_000, count
  end
end