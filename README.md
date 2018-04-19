# README

## Introduction

Make sure you have Xcode command line tools:

    xcode-select --Install

## Repo

Clone the repo from a directory above where you want it to love:

    git clone <get url from bitbucket>
    
All commands from this point are run in the directory where the repo was cloned. You
should not need `sudo` unless otherwise specified.
    
## Postgres:

    brew install postgresql@9.6

Follow instructions at end of install for start at boot as desired (do `brew info postgresql@9.6` if you need to see again)

We will install the project database as a later step.

## Ruby 

### rbenv (Ruby version management) 

    brew install rbenv

Now check the `Gemfile` in the cloned repo to get the desired Ruby version. Assumed
for the rest of this document to be `2.4.2`  

    rbenv install 2.4.2
    
CD to repo directory.

    rbenv local 2.4.2
    
This should create a `.ruby-version` file so that all actions performed in this directory
will use version `2.4.2`                

Put this in your `~/.bash_profile`:

    eval "$(rbenv init -)"
    
and restart your terminal, returning to the repo directory.

Verify that you have the right Ruby version:

    ruby -v

### Rails and other gems
        
Install bunder gem:

    gem install bundler
    
If you get a permission error, check again that you are using the right Ruby version.

Now install Rails and all other gem requirements:

    bundle install

If you have an issue with postgres missing header files, check
[this link](https://stackoverflow.com/questions/6040583/cant-find-the-libpq-fe-h-header-when-trying-to-install-pg-gem)


## Environment

Create a file `.env` in the root directory (will be ignored by git). Place these 
entries in the file:

    FIREBASE_URL=https://fanlink-development.firebaseio.com
    FIREBASE_KEY=$(cat <full path to private key json file which you should download from Firebase>)

    
## Database setup

Make sure postgres is running.

Create and seed the database:

    rails db:setup
    
## Server

Start the server

    rails s

In browser go to `localhost:3000/admin` to see the admin.

    Username: admin
    Password: flink_admin
    
        
## Tests

To run tests:

    rails spec

First you might need to run `rails db:test:prepare`

## Code Style

Run `rubocop` and fix any issues.
  
## Deployment

You will need to have the Heroku CLI installed and be a member of the app. Do

    `heroku apps`

and make sure `fanlink-staging` is among your apps

A `deploy.rb` script (see Flink project) will be needed in the future. For now, you will need to have a git remote
for `staging` to `https://git.heroku.com/fanlink-staging.git`. To deploy, merge your working branch into
the `staging` branch, and do:
 
    `git push staging staging:master`
    
If your deploy involves database changes, after the deploy, do:

    `heroku run rails db:migrate -r staging`
        
## Multitenancy

This is a multi-tenant app based around the product model. Multi-tenancy is implemented via the [acts_as_tenant]
(https://github.com/ErwinM/acts_as_tenant) gem. Database schemas were not used mainly due to performance concerns expressed
by others using them in the past.

Generally for controller methods the tenant is set based around the logged in `current_user`. For non-logged in 
methods (such as `session#create`), an API param is required.

## Other notes

* The admin is based around a gem called [administrate](https://github.com/thoughtbot/administrate). When adding
a new resource subject to admin, after adding the rails model and related files, 
for the admin you will need a new file in the `app/dashboards` directory. To generate it:

       rails generate administrate:dashboard <model class name>

To customize any of the layouts, you may need to generate the files for a resource. See the
Administrate documentation for more info.

* API versioning is provided by [this gem](https://github.com/jwoertink/jko_api). Currently
we are using a fork due to [this issue](https://github.com/jwoertink/jko_api/issues/7).

* After running specs, check the file in the `coverage` directory to
check code coverage.

* Calls to Firebase are handled through `app/lib/messaging`. Any specs
that result in calls to Firebase should stub all `Messaging` calls. Calls
to external services should never happen when running specs. The webmock
gem should enforce this.

* When creating a new heroku instance, setting up the config variables is complicated by the very long
API key necessary for Firebase. After downloading the ".json" key file from Firebase, you will need
to get its contents into the config variable on Heroku. This command has worked:

    `heroku config:set FIREBASE_KEY="$(< /Local/Path/tokeyfile/file.json)" -r remotename`
    
## Technical Todo's

* When appropriate use master git branches for gems not currently using them (acts_as_tenant, firebase, jko_api).

    