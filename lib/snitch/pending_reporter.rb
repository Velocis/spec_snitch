module Snitch
  class PendingReporter

    def initialize(config, options)
      repo, access_token = options[:repository], options[:access_token]
      @service      = ExternalServiceAdapter.new(repo, access_token)
      @examples     = config.instance_variable_get(:@reporter)
      @issue_titles = @service.list_issue_names

      report_examples if reportable_examples.any? && user_wants_report?(options[:ask])
    end

    private

    def reportable_examples
      @reportable_examples ||= @examples.pending_examples.keep_if do |example|
        example.pending? && @issue_titles.exclude?(example.full_description)
      end
    end

    def report_examples
      reportable_examples.each { |e| @service.create_issue(e) }
    end

    def user_wants_report?(ask)
      ask = true unless (ask == false)
      ask_question if ask == true
    end

    def ask_question
      thor = Thor::Shell::Basic.new
      question = "#{pluralize(reportable_examples.size, 'issue')} to report. Snitch to GitHub? (y/n):"
      thor.yes?(question)
    end
  end
end
