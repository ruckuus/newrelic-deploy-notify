require 'thor'
require 'yaml'
require 'rest_client'

class Notify < Thor

  attr_reader :host, :description, :revision, :changelog, :user, :api_key

  desc "deployment APPNAME [CONFIG FILE]", "Notify deployment to NewRelic."
  option :config, :desc => "Config file to be used, this is the place to put your newrelic key"
  option :host, :desc => "Deployment host."
  option :description, :desc => "Deployment description."
  option :revision, :desc => "Deployment revision."
  option :changelog, :desc => "Deployment changelog."
  option :user, :desc => "The deployer."

  def deployment(appname, config='../newrelic-config.yml')
    if options[:config].nil?
      config_file = File.dirname(__FILE__) + '/' + config
    else
      config_file = options[:config]
    end

    configs = YAML.load_file(config_file)
    @appname = appname
    @host = options[:host]
    @description = options[:description]
    @revision = options[:revision]
    @changelog = options[:changelog]
    @user = options[:user]
    @api_key = configs['newrelic_api_key']
    return self.post_request
  end

  no_commands do
    def post_request
      my_body_format = "deployment[app_name]=%s&deployment[host]=%s&deployment[description]=%s&deployment[revision]=%s&deployment[changelog]=%s&deployment[user]=%s"

      my_body = sprintf(my_body_format,
                @appname,
                @host,
                @description,
                @revision,
                @changelog,
                @user)

      resource = 'https://api.newrelic.com/deployments.xml'
      response = RestClient.post(
        resource,
        my_body,
        :'x-api-key' => @api_key
      )

      if response.code == 201
        return 0
      else
        return response.code
      end
    end
  end
end
