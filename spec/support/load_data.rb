require 'yaml'
require 'fileutils'

module LoadData
  def get_data(fixture_file)
    YAML::load_file(fixture_file)
  rescue => e
    raise "Error reading #{fixture_file}: #{e}"
  end

  def create_file(data_array)
    FileUtils.mkdir_p('./spec/tmp/')
    file_path = './spec/tmp/tmp_input_file.txt'
    File.open(file_path, 'w') do |f|
      data_array.each { |line| f.puts(line) }
    end
    file_path
  end

  def delete_file(file_path)
    FileUtils.rm(file_path)
  end
end