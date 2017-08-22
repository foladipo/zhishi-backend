[![Coverage Status](https://coveralls.io/repos/github/andela-iamadi/zhishi-backend/badge.svg?branch=master)](https://coveralls.io/github/andela-iamadi/zhishi-backend?branch=master) [![Circle CI](https://circleci.com/gh/zhishi-engine/zhishi-backend.svg?style=svg)](https://circleci.com/gh/zhishi-engine/zhishi-backend) [![Issue Count](https://codeclimate.com/github/zhishi-engine/zhishi-backend/badges/issue_count.svg)](https://codeclimate.com/github/zhishi-engine/zhishi-backend) [![Code Climate](https://codeclimate.com/github/zhishi-engine/zhishi-backend/badges/gpa.svg)](https://codeclimate.com/github/zhishi-engine/zhishi-backend)

# Zhishi
You've definitely being in this situation before:
  > Someone asks you a question;
  > Shortly after another person comes with the same question and the cycle
  > continues like that, till you tell the next person to go ask from the last/previous
  > person you answered.

If only there were such applications that helps you aggregate all your answers in one place, so that fellows don't keep coming to you for answers to commnon questions.
  > You don't need to wish anymore, because Zhishi is here.
  
## Requirements
In order to run this project, make sure you have the following software installed:
- Ruby: You may find further instructions at [this link](www.ruby-lang.org).
- The Bundler Ruby gem: Checkout [this link](http://bundler.io/v1.1/) for further instructions.
- Figaro: This is a Ruby gem. You may find installation instructions at [this link](https://github.com/laserlemon/figaro#getting-started).


## Installation and Setup
  
  - Clone the project:

  ```shell
    git clone git@github.com:andela-iamadi/zhishi-backend.git
  ```

  - Install the libraries
  ```shell
    bundle install
  ```


  Install figaro for application secret tokens
  ```shell
    figaro install
  ```

  Copy your secret keys to the `config/application.yml`
  ```yml
    SLACK_CLIENT_ID: your slack client id
    SLACK_CLIENT_SECRET: your slack secret key
    GOOGLE_CLIENT_ID: your google client id
    GOOGLE_CLIENT_SECRET: your google secret key
  ```

## To contribute:

  Simply fork the project, and clone your forked version to your development environment

  ```shell
    git clone git@github.com:{my user name here}/zhishi-backend.git
  ```

  Install the libraries
  ```shell
    bundle install
  ```


  Install figaro for application secret tokens
  ```shell
    figaro install
  ```

  Copy your secret keys to the `config/application.yml`
  ```yml
    SLACK_CLIENT_ID: your slack client id
    SLACK_CLIENT_SECRET: your slack secret key
    GOOGLE_CLIENT_ID: your google client id
    GOOGLE_CLIENT_SECRET: your google secret key
  ```
