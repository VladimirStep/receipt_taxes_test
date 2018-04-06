require_relative 'spec_helper'

RSpec.describe 'Run script' do
  input_data = get_data('spec/fixtures/input_data.yml')
  output_data = {
    'output1' => <<-TEXT.gsub("\n", "\r\n"),
1, book, 12.49
1, music cd, 16.49
1, chocolate bar, 0.85
Sales Taxes: 1.50
Total: 29.83
TEXT
    'output2' => <<-TEXT.gsub("\n", "\r\n"),
1, imported box of chocolates, 10.50
1, imported bottle of perfume, 54.65
Sales Taxes: 7.65
Total: 65.15
TEXT
    'output3' => <<-TEXT.gsub("\n", "\r\n")
1, imported bottle of perfume, 32.19
1, bottle of perfume, 20.89
1, packet of headache pills, 9.75
1, imported box of chocolates, 11.85
Sales Taxes: 6.70
Total: 74.68
TEXT
  }

  let(:executable) { File.expand_path('../../calc.rb', __FILE__) }

  input_data.each do |input_name, data|
    context 'with file argument' do
      before(:each) do
        @file_path = create_file(data)
      end

      let(:command) { "#{executable} #{@file_path}" }
      let(:process) { CliProcess.new(command) }

      it 'should process data from file' do
        expect(process).to have_output(output_data[input_name.gsub('input', 'output')])
        sleep 1
      end

      after(:each) do
        process.kill
        process.wait
        delete_file(@file_path)
      end
    end
  end
end