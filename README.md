This is now a repository with Devise, Admins, Voting, and Email Functionalities

##Devise Instructions

1. Write a failing acceptance test for registration. Every new feature should start with a failing acceptance test. Write a test that walks through your registration process. Be sure to include all of the fields you want to capture as part of your registration workflow.
2. Add `gem "devise"` to the `Gemfile`.
3. Bundle and install Devise with `bundle && rails generate devise:install && rails generate devise:views`. Like Rails itself, third party gems can supply generators for us to use. Devise supplies many generators. `devise:install` gives us the basics, while `devise:views` provides us with the ERB that we can customize.
4. Generate the `User` model with `rails generate devise <Model Name (usually user)>`. This is where the real magic happens. Here, we're generating the user model with all of Devise's authentication functionality baked in.
5. Write passing unit behaviors that test your user model. We often want to customize what devise provides us as a default. For example, we always like to add `first_name` and `last_name` attributes to our user table. Be sure to start with failing unit behaviors before you implement those custom behaviors. Modify your migration as necessary to support these additional functions.
6. Migrate with `rake db:migrate && rake db:rollback && rake db:migrate` to add the users table.
7. Modify `ApplicatonController` to allow all attributes to be saved from the user registration form. This is only necessary if we include additional fields such as name or biography to our user model. For example, if we added a `first_name` and `last_name` we would have to modify `app/controllers/application_controller.rb` as follows:

  ```ruby
  class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    before_filter :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    end
  end
  ```

  This "white-lists" the `first_name` and `last_name` attributes for the `Devise::RegistrationsController#create` method. [Source](https://github.com/plataformatec/devise#strong-parameters)

8. Get the acceptance test to pass. Fill in the required fields and submit the registration form.

##JS Testing Instructions

1. Add `gem capybara-webkit` and `gem database_cleaner` to your test environment in your Gemfile

2. Run `bundle install`

3. Add the following to your `rails_helper`

```Capybara.javascript_driver = :webkit

Capybara::Webkit.configure do |config|
  config.allow_url("http://www.lol.jpg/")
end
```

Where `http://www.lol.jpg/` should be the url of any images referred to in your javascript tests. Multiple allow_urls will be needed for each image hit within your test.

4. Set `config.use_transactional_fixtures = false` in the `rails_helper`

5. Add the following to your `spec_helper` (preferably in a RSpec configure block that already exists)
```RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.after(:suite) do
  end
end
```

6. Write your test! Set `js: true` like so: `feature 'thing', js: true do`

##Email Instructions

1. Follow along with the lesson: https://learn.launchacademy.com/lessons/rails-sending-emails

- Note: Use `deliver_now` instead of `deliver_later`

2. Follow along for production instructions: https://devcenter.heroku.com/articles/sendgrid

Notes:
- Jump to the ruby section for ruby setup instructions
- You will need to create a sendgrid account (and unfortunately use a credit card, no payments required) in order to run the heroku cli commands for sendgrid
