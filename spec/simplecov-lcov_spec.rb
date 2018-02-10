require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'active_support/core_ext/kernel/reporting'

module SimpleCov::Formatter
  describe LcovFormatter do
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

      context 'generating report per file' do
        before {
          LcovFormatter.new.format(simplecov_result)
        }

        describe File do
          it { expect(File).to exist(File.join(LcovFormatter.config.output_directory, 'spec-fixtures-hoge.rb.lcov')) }
          it { expect(File).to exist(File.join(LcovFormatter.config.output_directory, 'spec-fixtures-app-models-user.rb.lcov')) }
        end

        describe 'spec-fixtures-hoge.rb.lcov' do
          let(:output_path) {
            File.join(LcovFormatter.config.output_directory, 'spec-fixtures-hoge.rb.lcov')
          }
          let(:fixture) {
            File.read("#{File.dirname(__FILE__)}/fixtures/lcov/spec-fixtures-hoge.rb.lcov")
          }
          it { expect(File.read(output_path)).to eq(fixture) }
        end

        describe 'spec-fixtures-app-models-user.rb.lcov' do
          let(:output_path) {
            File.join(LcovFormatter.config.output_directory, 'spec-fixtures-app-models-user.rb.lcov')
          }
          let(:fixture) {
            File.read("#{File.dirname(__FILE__)}/fixtures/lcov/spec-fixtures-app-models-user.rb.lcov")
          }
          it { expect(File.read(output_path)).to eq(fixture) }
        end
      end

      context 'generating single file report' do
        before {
          LcovFormatter.config.report_with_single_file = true
          LcovFormatter.new.format(simplecov_result)
        }

        describe File do
          it { expect(File).to exist(LcovFormatter.config.single_report_path) }
        end

        describe 'single_report_path' do
          let(:output_path) {
            LcovFormatter.config.single_report_path
          }
          let(:fixture_of_hoge) {
            File.read("#{File.dirname(__FILE__)}/fixtures/lcov/spec-fixtures-hoge.rb.lcov")
          }
          let(:fixture_of_user) {
            File.read("#{File.dirname(__FILE__)}/fixtures/lcov/spec-fixtures-app-models-user.rb.lcov")
          }
          it { expect(File.read(output_path)).to match(fixture_of_hoge) }
          it { expect(File.read(output_path)).to match(fixture_of_user) }
        end
      end
    end
  end

  describe '.report_with_single_file=' do
    before do
      allow(LcovFormatter).to receive(:warn)
      allow(LcovFormatter.config).to receive(:report_with_single_file=)
    end

    it 'sets configuration options correctly' do
      LcovFormatter.report_with_single_file = true
      expect(LcovFormatter.config).to have_received(:report_with_single_file=).with(true)
    end

    it 'shows deprecation warning' do
      LcovFormatter.report_with_single_file = true
      expect(LcovFormatter).to have_received(:warn).with(/LcovFormatter\.report_with_single_file=` is deprecated/)
    end
  end
end
