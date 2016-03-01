namespace :osm do
  namespace :apps do
    desc "Creates a client application"
    task :create do
      require File.dirname(__FILE__) + "/../../config/environment"

      unless ENV["name"] && ENV["url"]
        puts "Usage: rake osm:apps:create name='Local iD' url='http://localhost:3000'"
        exit 1
      end

      app = ClientApplication.find_or_create_by! \
        name: ENV["name"],
        url: ENV["url"],
        allow_write_api: true

      puts app.to_json
    end
  end

  namespace :users do
    desc "Creates a user account"
    task :create do
      require File.dirname(__FILE__) + "/../../config/environment"

      unless ENV["display_name"]
        puts "Usage: rake osm:users:create display_name='POSM' [description='Portable OpenStreetMap']"
        exit 1
      end

      user = User.find_or_create_by! \
        display_name: ENV["display_name"],
        description: ENV["description"] || "Generated user",
        email: "#{OSM.make_token(8)}@#{OSM.make_token(8)}.#{OSM.make_token(3)}",
        terms_seen: true,
        terms_agreed: Time.now,
        data_public: true,
        status: "active",
        email_valid: false,
        # testing1234
        pass_crypt: "aWJugNpTKNMU7K7tVTaWzPxe5iUCwCIY3CgnQXPa7FM=",
        pass_salt: "sha512!1000!4v2n8BkluuIcYW+FNM9JOvGW3BiVp4QFh0P7N/YmDu8="

      puts user.to_json
    end
  end
end
