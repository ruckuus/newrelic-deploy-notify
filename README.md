--- 
newrelic-deploy-notify
---

It's just a very simple client for this API

[https://docs.newrelic.com/docs/apm/new-relic-apm/maintenance/setting-deployment-notifications#api](https://docs.newrelic.com/docs/apm/new-relic-apm/maintenance/setting-deployment-notifications#api)

```
curl -H "x-api-key:REPLACE_WITH_YOUR_API_KEY" -d "deployment[app_name]=REPLACE_WITH_YOUR_APP_NAME" -d "deployment[description]=This is an app id deployment" https://api.newrelic.com/deployments.xml
```

Usage
--

Put your [NewRelic API Key](https://docs.newrelic.com/docs/apm/apis/requirements/api-key) in ``newrelic-config.yml``

You can notify deployment to newrelic by doing this:

```
$ ./bin/notify deployment "Application Name" --user="Master Of Disguise" --revision="Only notification test #123" --changelog=""

$ ./bin/notify help deployment
Usage:
  notify deployment APPNAME [CONFIG FILE]

Options:
  [--config=CONFIG]            # Config file to be used, this is the place to put your newrelic key
  [--host=HOST]                # Deployment host.
  [--description=DESCRIPTION]  # Deployment description.
  [--revision=REVISION]        # Deployment revision.
  [--changelog=CHANGELOG]      # Deployment changelog.
  [--user=USER]                # The deployer.

Notify deployment to NewRelic.

```
