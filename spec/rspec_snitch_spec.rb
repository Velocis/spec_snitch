require 'spec_helper'

describe RspecSnitch do
  let(:token)  { '1313kj4l2k34908' }
  let(:repo)   { 'awesome/foobarbaz' }
  let(:config) { double }
  let(:snitch) { RspecSnitch.new(token, repo, config) }

  it 'should not blow up' do
    expect { snitch }.to_not raise_error
  end

  describe 'create pending issues' do
    it 'creates an issue if a spec is pending and not on github' do
    end
  end
end
