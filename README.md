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

## Code Style

Run `rubocop` and fix any issues.
    
## Other notes

<ul>
<li>The admin is based around a gem called <a href="https://github.com/thoughtbot/administrate">administrate</a>. When adding
a new resource subject to admin, after adding the rails model and related files, 
for the admin you will need a new file in the `app/dashboards` directory. To customize
any of the layouts, you may need to generate the files for a resource. See the
Administrate documentation for more info.</li>

<li>API versioning is provided by <a href="https://github.com/jwoertink/jko_api">this gem</a>. Currently
we are using a fork due to <a href="https://github.com/jwoertink/jko_api/issues/7">this issue</a>.</li>

<li>After running specs, check the file in the <code>coverage</code> directory to
check code coverage.</li>

<li>Calls to Firebase are handled through <code>app/lib/messaging</code>. Any specs
that result in calls to Firebase should stub all <code>Messaging</code> calls. Calls
to external services should never happen when running specs. The <code>webmock</code>
gem should enforce this.</li>

     
    
    

    