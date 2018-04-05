require_relative 'spec_helper'

RSpec.describe 'Run script' do
  let(:input_data) { get_data('spec/fixtures/input_data.yml') }
  let(:executable) { File.expand_path('../../calc.rb', __FILE__) }
  let(:output1) {
<<-TEXT
1, book, 12.49
1, music cd, 16.49
1, chocolate bar, 0.85
Sales Taxes: 1.50
Total: 29.83
TEXT
  }

  context 'without file argument' do
    let(:command) { "#{executable}\t" }
    let(:process) { CliProcess.new(command) }
    let(:input) { input_data['input1'] }

    it 'should process data from stdin' do
      input.each do |line|
        process.type(line)
      end
      expect(process).to have_output(output1.gsub("\n", "\r\n"))

      process.kill
      process.wait
    end
  end

  context 'with file argument ' do
    before do
      @file_path = create_file(input_data['input1'])
    end

    let(:command) { "#{executable} #{@file_path}\t" }
    let(:process) { CliProcess.new(command) }

    it 'should process data from file' do
      expect(process).to have_output(output1.gsub("\n", "\r\n"))

      process.kill
      process.wait
    end

    after do
      delete_file(@file_path)
    end
  end
end