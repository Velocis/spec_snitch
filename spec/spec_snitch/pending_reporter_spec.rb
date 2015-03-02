require 'spec_helper'

describe SpecSnitch::PendingReporter do
  describe 'pending examples' do
    let(:config)   { instance_double "RSpec::Core::Configuration" }
    let(:reporter) { instance_double "RSpec::Core::Reporter",
                     pending_examples: examples }
    let(:service)  { instance_double "Octokit::Client",
                     list_issues: [], create_issue: true }
    let(:snitch)   { SpecSnitch::PendingReporter.new config,
                     repository: 'example/repo', access_token: 'exampletoken' }

    before(:each) do
      config.instance_variable_set(:@reporter, reporter)
      allow_any_instance_of(SpecSnitch::ExternalServiceAdapter).
        to receive(:new_service).and_return(service)
    end

    context 'user wants report' do
      before(:each) { allow_any_instance_of(SpecSnitch::PendingReporter).
                      to receive(:user_wants_report?).and_return(true) }

      context '2 pending examples ' do
        let(:examples) { [double(pending?: true, full_description: 'first title',
                          location: 'my location'),
                          double(pending?: true, full_description: 'second title',
                          location: 'my location')] }

        before(:each) { expect(service).to receive(:create_issue).twice }

        it 'should create two issues if two pending example' do
          snitch
        end

        it 'should not create multiple issues of same spec' do
          2.times { snitch }
        end
      end

      context 'no pending examples' do
        let(:examples) { [double(pending?: false, full_description: 'first title',
                          location: 'my location')] }

        it 'should not create issue' do
          expect(service).to_not receive(:create_issue)
          snitch
        end
      end
    end

    context 'user does not want report' do
      before(:each) { allow_any_instance_of(SpecSnitch::PendingReporter).
                      to receive(:user_wants_report?).and_return(false) }
      let(:snitch)   { SpecSnitch::PendingReporter.new config,
                      repository: 'example repo', ask: false,
                      access_token: 'exampletoken' }
      let(:examples) { [double(pending?: true, full_description: 'first title',
                        location: 'my location')] }

      it 'should not create issue' do
        expect(service).to_not receive(:create_issue)
        snitch
      end
    end
  end
end
