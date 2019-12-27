---

**NOTE: guard-annotate is currently looking for new maintainers.  While I am still trying to accept and stay on top of new Pull Requests, I no longer personally actively use this guard plugin.  If you are interested in becoming a maintainer, please contact me via email at cpjolicoeur@gmail.com**

---

# Guard::Annotate

Annotate guard runs the annotate gem when needed

- Compatible with Annotate 2.4.x
- Tested on Ruby 1.9.x, 2.0.x, 2.1.x, 2.2.x

## Install

Install the gem:

    gem install guard-annotate

Add the gem to your Gemfile:
    
    gem 'guard-annotate'

Add guard definitions to your Guardfile by running:

    guard init annotate


## Usage

Please read the [Guard usage docs][1]

## Guardfile

### Standard Ruby on Rails project

    guard 'annotate' do
      watch( 'db/schema.rb' )
      # Uncomment the following line if you also want to run annotate anytime
      # a model file changes
      #watch( 'app/models/**/*.rb' )
    end


## Options

### Desktop notifications

You can disable desktop notifications with (default is notifications are enabled):

    guard 'annotate', :notify => false do
      ...
    end
    
### Placement

You can customize the placement of the annotations with (default is 'before'):

    guard 'annotate', :position => 'before|after' do
      ...
    end

### Routes

You can choose to also annotate your routes file with true, false or 'before'/'after' (default is false):

    guard 'annotate', :routes => 'before|after' do
      ...
    end
    
### Tests Annotation

You can annotate your tests and fixtures files with (default is false):

    guard 'annotate', :tests => true do
      ...
    end
    
### Factory Exclusion

You can exclude annotations in factory files with (default is true):

    guard 'annotate', :factories => false do
      ...
    end

### Serializers

You can exclude annotations in serializers with (default is true):

    guard 'annotate', :serializers => false do
      ...
    end
    
### Run at start

You can disable run at start with (default is true):

    guard 'annotate', :run_at_start => false do
      ...
    end

### Indexes

You can annotate indexes on your models with (default is false):

    guard 'annotate', :show_indexes => true do
      ...
    end

### Simple Indexes

You can add simple indexes to the column information (default is false):

    guard 'annotate', :simple_indexes => true do
      ...
    end


### Foreign Keys

You can show foreign keys (default is false):

    guard 'annotate', :show_foreign_keys => true do
      ...
    end

### Migration version number
You can show migration version number in the annotation (default is false):

    guard 'annotate', :show_migration => true do
      ...
    end

### Annotation Format

You can annotate in three different formats: :bare, :rdoc and :markdown (default is :bare):

    guard 'annotate', :format => :rdoc do
      ...
    end

## Development

- Source hosed at [GitHub][2]
- Issue/Bug/Question/Feature requests via [GitHub Issues][3]

## Authors

[Craig P Jolicoeur][4]

[1]: https://github.com/guard/guard#readme]
[2]: https://github.com/guard/guard-annotate
[3]: http://github.com/guard/guard-annotate/issues
[4]: https://github.com/cpjolicoeur