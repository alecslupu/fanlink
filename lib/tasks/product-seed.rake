namespace :product do
  desc "load a bunch of users for load testing"
  namespace :seed do
    task export: :environment do
    end
    task import: :environment do
    end
  end
end

def get_asscociations
end
# FileUtils.mkdir_p("docs/specs/schema/v1/") unless Dir.exists?("docs/specs/schema/v1/")
