module RspecSnitch
  class PendingReporter
    def initialize(repo, config, options)
      @service      ||= ExternalServiceAdapter.new(repo, ENV['RSPEC_SNITCH_TOKEN'])
      @examples     ||= config.instance_variable_get(:@reporter)
      @issue_titles ||= @service.list_issue_names

      report_examples if reportable_examples.any? && user_wants_report?
    end

    alias_method :snitch_to, :new

    private

    def reportable_examples
      @reportable_examples ||= @examples.pending_examples.keep_if do |example|
        example.pending? && @issue_titles.exclude?(example.full_description)
      end
    end

    def report_examples
      reportable_examples.each { |e| @service.create_issue(e) }
    end

    def user_wants_report?
      if options[:ask] == true
        thor = Thor::Shell::Basic.new
        question = "#{pluralize(reportable_examples.size, 'issue')} to report. Snitch to GitHub? (y/n):"
        thor.yes?(question)
      else
        true
      end
    end
  end
end
