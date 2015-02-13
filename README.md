# RSpecSnitch

RSpecSnitch creates a GitHub issue for each pending spec in your suite, making it harder for you to ignore those features you've been putting off.

## Installation

Add this line to your application's Gemfile:

    gem 'rspec_snitch'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rspec_snitch

## Usage

To get started, you'll only need two things:

1. A valid repo name (i.e. "freddyrangel/rspec_snitch")
2. A GitHub API access token for an account authorized to contribute to that repo.

To get your access token, go to your [GitHub Settings > Applications](https://github.com/settings/applications), and under your "Personal Access Tokens" panel, click on "Generate new token". The default settings will work fine, but at the very least you'll need to have the "repo" scope enabled.

Once you've done all that, simply add the following to your RSpec configuration:

<pre>
RSpec.configure do |config|
  config.after(:suite) do
    RSpecSnitch.snitch_to config, repository: [your repo name here],
      access_token: [your access_token], ask: false
  end

  # other stuff...
end
</pre>

Setting `ask: true` will cause RSpecSnitch to ask you after each run of your test suite if you'd like to snitch. This could be annoying, so we've defaulted to `false`.

## Pro-tip: Use with your Continuous Integration server
If you find RSpecSnitch is slowing down your test flow too much, or you'd rather not report on every run, or worse, you'd rather not be asked after every run, you can safely leave your `RSPEC_SNITCH_TOKEN` unset, and it will simply alert you with a message in your suite's output.

But if you set the environment variable (`RSPEC_SNITCH_TOKEN`) in your CI server's config, you can have RSpecSnitch only do its thing when a commit is pushed to GitHub (thus triggering a build on your CI server). This helps reduce snitching to times when you've come to a reasonable break in your work.

## Contributing

1. Fork it ( http://github.com/<my-github-username>/rspec_snitch/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
