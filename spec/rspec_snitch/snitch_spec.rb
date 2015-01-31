require 'spec_helper'

describe RspecSnitch::PendingSpecReporter do
  describe 'report examples', :vcr do
    let(:token)  { ENV['GITHUB_TOKEN'] }
    let(:repo)   { 'freddyrangel/snitch-example' }
    let(:config) { double }
    let(:report) { RspecSnitch::PendingSpecReporter.new(token, repo, config) }

    context 'reportable examples present and user wants report' do
      it 'should send one issue to github' do
        expect_any_instance_of(Octokit::Client).to receive(:create_issue).
          with(repo, 'message', 'body')
        report
      end
    end

    context 'reportable examples and user does not want report' do

    end

    context 'no reportable examples' do

    end
  end
end
