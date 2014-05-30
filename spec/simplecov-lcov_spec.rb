require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'active_support/core_ext/kernel/reporting'

describe SimpleCov::Formatter::LcovFormatter do
  describe '#format' do
    let(:expand_path) {
      lambda do |filename|
        File.expand_path(File.join(File.dirname(__FILE__), 'fixtures', filename))
      end
    }

    let(:simplecov_result_hash) {
      {
       expand_path.call('hoge.rb') => [nil, nil, nil, 1, 2, 2, 1, nil, 0, 0, 0, 1],
       expand_path.call('app/models/user.rb') => [nil, nil, nil, 2, 2, 2, 2, nil, 0, 0, 0, nil, 1, 0, 0, 1]
      }
    }

    let(:simplecov_result) {
      SimpleCov::Result.new(simplecov_result_hash)
    }

    before {
      @output = capture(:stdout) do
        SimpleCov::Formatter::LcovFormatter.new.format(simplecov_result)
      end
    }

    describe File do
      it { expect(File).to exist(File.join(SimpleCov::Formatter::LcovFormatter.output_directory, 'spec-fixtures-hoge.rb.lcov')) }
      it { expect(File).to exist(File.join(SimpleCov::Formatter::LcovFormatter.output_directory, 'spec-fixtures-app-models-user.rb.lcov')) }
    end

    describe 'spec-fixtures-hoge.rb.lcov' do
      let(:output_path) {
        File.join(SimpleCov::Formatter::LcovFormatter.output_directory, 'spec-fixtures-hoge.rb.lcov')
      }
      let(:fixture) {
        File.read("#{File.dirname(__FILE__)}/fixtures/lcov/spec-fixtures-hoge.rb.lcov")
          .gsub('/path/to/repository/spec', File.dirname(__FILE__))
      }
      it { expect(File.read(output_path)).to eq(fixture) }
    end

    describe STDOUT do
      it { expect(@output).to include('Lcov style coverage report') }
    end
  end

  describe '.output_directory' do
    subject { SimpleCov::Formatter::LcovFormatter.output_directory }
    it { expect(subject).to eq(File.join(SimpleCov.coverage_path, 'lcov')) }
  end
end
