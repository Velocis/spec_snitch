module SpecSnitch
  class PendingReporter
    def initialize(config, options)
      repo, access_token = options[:repository], options[:access_token]
      @service      = ExternalServiceAdapter.new(repo, access_token)
      @examples     = config.instance_variable_get(:@reporter)
      report_examples if user_wants_report?(options[:ask])
    end

    private

    def report_examples
      reportable_examples.each { |e| @service.create_issue(e) }
    end

    def reportable_examples
      @reportable_examples ||= @examples.
        pending_examples.keep_if { |e| create_issue?(e) }
    end

    def issue_titles
      @issue_titles ||= @service.list_issue_names
    end

    def create_issue?(example)
      example.pending? && issue_titles.exclude?(example.full_description)
    end

    def user_wants_report?(ask = true)
      ask_question if ask
    end

    def ask_question
      thor = Thor::Shell::Basic.new
      question = "#{pluralize(reportable_examples.size, 'issue')} to report. Snitch to GitHub? (y/n):"
      thor.yes?(question)
    end
  end
end
