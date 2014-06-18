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
        if self.class.report_with_single_file?
          write_lcov_to_single_file!(result.files)
        else
          result.files.each { |file| write_lcov!(file) }
        end

        puts "Lcov style coverage report generated for #{result.command_name} to #{SimpleCov::Formatter::LcovFormatter.output_directory}."
      end

      class << self
        attr_writer :report_with_single_file

        def report_with_single_file?
          !!@report_with_single_file
        end

        # Output directory for generated files.
        # ==== Return
        # Path for output directory.
        def output_directory
          File.join(SimpleCov.coverage_path, 'lcov')
        end

        # Output path for single file report.
        # ==== Return
        # Path for output path of single file report.
        def single_report_path
          basename = Pathname.new(SimpleCov.root).basename.to_s
          File.join(output_directory, "#{basename}.lcov")
        end
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

      def write_lcov_to_single_file!(files)
        File.open(self.class.single_report_path, 'w') do |f|
          files.each { |file| f.write format_file(file) }
        end
      end

      def output_filename(filename)
        filename.gsub("#{SimpleCov.root}/", '').gsub('/', '-')
          .tap { |name| name << '.lcov' }
      end

      def format_file(file)
        "SF:#{file.filename}\n#{format_lines(file)}\nend_of_record\n"
      end

      def format_lines(file)
        filtered_lines(file)
          .map { |line| format_line(line) }
          .join("\n")
      end

      def filtered_lines(file)
        file.lines.reject(&:never?).reject(&:skipped?)
      end

      def format_line(line)
        "DA:#{line.number},#{line.coverage}"
      end
    end
  end
end
