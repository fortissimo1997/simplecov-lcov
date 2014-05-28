require 'fileutils'

fail 'simplecov-lcov requires simplecov' unless defined?(SimpleCov)

module SimpleCov
  module Formatter
    # Custom Formatter to generate lcov style coverage for simplecov
    class LcovFormatter
      # generate lcov style coverage.
      # ==== Args
      # _result_ :: [SimpleCov::Result] abcoverage result instance.
      def format(result)
        create_output_directory!
        result.files.each { |file| write_lcov!(file) }
      end

      # Output directory for generated files.
      # ==== Return
      # Path for output directory.
      def self.output_directory
        File.join(SimpleCov.coverage_path, 'lcov')
      end

      private

      def create_output_directory!
        return if Dir.exist?(self.class.output_directory)
        FileUtils.mkdir_p(self.class.output_directory)
      end

      def write_lcov!(file)
        File.open(File.join(self.class.output_directory, output_filename(file.filename)), 'w') do |f|
          f.write format_file(file)
        end
      end

      def base_directory
        File.expand_path(File.join(File.dirname(__FILE__), '..'))
      end

      def output_filename(filename)
        filename.gsub("#{base_directory}/", '').gsub('/', '-')
          .tap { |name| name << '.lcov' }
      end

      def format_file(file)
        "SF:#{file.filename}\n".tap do |content|
          file.lines.reject(&:never?).reject(&:skipped?)
            .each do |line|
            content << "DA:#{line.number},#{line.coverage}\n"
          end
          content << "end_of_record\n"
        end
      end
    end
  end
end
