require 'spec_helper'

describe RspecSnitch do
  include_context "aruba support"

  let(:token)  { ENV['GITHUB_TOKEN'] }
  let(:repo)   { 'freddyrangel/snitch-example' }
  let(:config) { RSpec::Core::Configuration.new }
  let(:snitch) { RspecSnitch.new(config, repository: repo, access_token: token) }

  describe 'create pending issues', :vcr do
    context 'with one new pending example' do
      context 'and user wants report' do
        it 'then should create one GH issue' do
          write_file 'spec/simple_spec.rb', """
            require 'rspec_snitch'
            RSpec.describe 'simple spec' do
              it 'should be a pending issue', pending: true do
                expect(false).to be(true)
              end
              it 'should not be pending' do
              end
            end
            RSpec.configure do |config|
              config.after(:suite) do
                RspecSnitch.new(config, repository: 'freddyrangel/snitch-example', access_token: #{token})
              end
            end
          """

          set_env('GITHUB_TOKEN', ENV['GITHUB_TOKEN'].to_s)
          run_simple 'rspec'
        end

        it 'should tell user one report was created' do

        end

        it 'should not make multiple issues of same spec' do
        end
      end

      context 'user declines report' do
        it 'should not create a GH issue if user declines report' do

        end

        it 'should tell user no reports were created' do

        end
      end
    end

    context 'with pending example now fixed' do
      it 'should close github issue' do

      end
    end
  end
end
