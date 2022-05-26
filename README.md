## Contact List
Contact List is a technical challenge to build a simple REST API with specific endpoints.


[![NPM Version][npm-image]][npm-url]
[![Build Status][travis-image]][travis-url]
[![Downloads Stats][npm-downloads]][npm-url]

## Goals:
- Practice building API endpoints to expose limited data.
- Utilize namespacing routing techniques to organize functionality.
- Use serializers to format JSON responses.
- Utilize ActiveRecord and some raw SQL to gather data.


## Schema
- See image below for project database schema:

[ContactsListSchema.pdf](https://github.com/psitosam/contact_list/files/8781870/ContactsListSchema.pdf)

## Requirements and Setup (for Mac):

### Ruby and Rails
- Ruby Version 2.7.2
- Rails Version 5.2.8

## Gems used:

- RSpec
- Pry
- SimpleCov
- Capybara
- Shoulda-Matchers v5.0
- Factory_Bot_Rails
- Faker
- jsonapi-serializer

## Development setup:

1. Clone this repository:
On your local machine open a terminal session and enter the following commands for SSH or HTTPS to clone the repositiory.


- using ssh key <br>
```shell
$ git clone git@github.com:psitosam/contact_list.git
```

- using https <br>
```shell
$ git clone https://github.com/psitosam/contact_list.git
```

Once cloned, you'll have a new local copy in the directory you ran the clone command in.

2. Change to the project directory:<br>
In terminal, use `$cd` to navigate to the Rails Engine Lite project directory.

```shell
$ cd contact_list
```

3. Install required Gems utilizing Bundler: <br>
In terminal, use Bundler to install any missing Gems. If Bundler is not installed, first run the following command.

```shell
$ gem install bundler
```

If Bundler is already installed or after it has been installed, run the following command.

```shell
$ bundle install
```

There should be be verbose text displayed of the installation process...followed by something similar to this line:
```shell
Bundle complete! 16 Gemfile dependencies, 70 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
```
If there are any errors, verify that bundler, Rails, and your ruby environment are correctly setup.

## Database Migration:

4. Database Migration<br>
Before using the web application you will need to setup your databases locally by running the following command:

```shell
$ rails db: {:drop, :create, :migrate, :seed}
```

5. Running Test suite<br>
The test suite is built using rspec. To run the entire test suite:
```shell
$ bundle exec rspec
```
Alternatively, individual tests can be run one at a time by specifying the file path and line of code on which the test starts:
```shell
$ bundle exec rspec spec/requests/api/v1/contacts_requests_spec.rb:198
```



## Meta

### Contributors: See ``CONTRIBUTORS.txt`` for more information.

### Distributed under the MIT license. See ``LICENSE.txt`` for more information.

[https://github.com/psitosam/github-link](https://github.com/psitosam/)



<!-- Markdown link & img dfn's -->
[npm-image]: https://img.shields.io/npm/v/datadog-metrics.svg?style=flat-square
[npm-url]: https://npmjs.org/package/datadog-metrics
[npm-downloads]: https://img.shields.io/npm/dm/datadog-metrics.svg?style=flat-square
[travis-image]: https://img.shields.io/travis/dbader/node-datadog-metrics/master.svg?style=flat-square
[travis-url]: https://travis-ci.org/dbader/node-datadog-metrics
