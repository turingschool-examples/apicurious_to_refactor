# API'm Curious to Refactor

This Rails project is meant to be used for an in-class code along to demonstrate the use of Ruby presenter objects.

The end goal of this refactor is to have controller actions that only send one instance variable to the view.

## Setup

```bash
git clone git@github.com:turingschool-examples/apicurious_to_refactor.git
cd apicurious_to_refactor
bundle
bundle exec rake db:{create,migrate}
bundle exec figaro install
```

Within `config/application.yml`, paste:

```ruby
GITHUB_KEY: <YOUR GITHUB CLIENT ID>
GITHUB_SECRET: <YOUR GITHUB CLIENT SECRET>
```
