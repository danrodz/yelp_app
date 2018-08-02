# Restaurants @Yelp - A CLI App

## Sample Usage

![Display Results](sample_use_images/display_results.png 'Displaying Query Results -Sample')

Welcome to your new app! In this directory, you'll find the instructions you need to be able to run this app in your terminal.

First run `bundle install` to download all necessary gems for this project.

You will also need to obtain an API Key from [Yelp](https://www.yelp.com/developers/v3/manage_app) and insert it into your code in the file `info.rb` file.

To experiment with that code, simply run `ruby tools/run.rb` to launch the interactive interface that allows you start browsing through the Yelp API.

---

## Installation

cd into your project's location within your terminal and run:

```ruby
bundle install
```

And then execute:

    ```ruby
    rake db:migrate
    ```

to create your personal database with the information retrieved.

---

## Usage

The Restaurants @Yelp CLI App allows users to quickly interact and request information from the Yelp API. Users are able to request a list of restaurants by providing a required location and an optional parameter search for the type of restaurant in consideration.
This additional search term can be anything, such as a cuisine, type of establishment, open availability, or even menu items.

---

## ![Menu](sample_use_images/display_menu.png 'Displaying Menu -Sample')

![Reviews](sample_use_images/display_reviews.png 'Displaying Review Results -Sample')

## Development

After checking out the repo, run `rake db:migrate` to create your database.

A standard database schema is provided but you may instantiate a new database with your models desired.

To check for specific data provided or try a to run the tests you can use the 'Pry' gem installed from the gem file and insert a `binding.pry` into the desired location to obtain access to the variables and methods within the scope in which it is enclosed.
After inserting your `binding.pry` run `ruby tools/runner.rb` from your terminal for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at [repo_link](https://github.com/danrodz/yelp_app). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Authors

[Erika Barrero](https://github.com/e-barr)
[Daniel Rodriguez](https://github.com/danrodz)
