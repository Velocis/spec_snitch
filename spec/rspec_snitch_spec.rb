require 'spec_helper'

describe RspecSnitch do
  let(:token)  { ENV['GITHUB_TOKEN'] }
  let(:repo)   { 'freddyrangel/snitch-example' }
  let(:config) { double }
  let(:snitch) { RspecSnitch.new(token, repo, config) }

  it 'should not blow up' do
    expect { snitch }.to_not raise_error
  end

  describe 'create pending issues' do
    it 'creates an issue if a spec is pending and not on github', focus: true do
      expect_any_instance_of(Octokit::Client).to receive(:create_issue).once
    end
  end
end
