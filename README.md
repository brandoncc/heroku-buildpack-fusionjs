# Heroku Buildpack for Fusion.js

## Usage (TL;DR)

This buildpack depends on, and should therefore be added _after_
https://github.com/heroku/heroku-buildpack-nodejs.

You can do that using:

```bash
heroku buildpacks:add -i 2 https://github.com/brandoncc/heroku-buildpack-fusionjs
```

### Quickstart

You can get a Fusion.js app up and running quickly with the following commands:

```bash
yarn create fusion-app test-fusion-app
cd test-fusion-app
echo "node_modules" >> .gitignore
echo ".fusion" >> .gitignore
git init
git add .
git commit -m "Create app"
heroku create
git push heroku master
heroku buildpacks:add -i 2 https://github.com/brandoncc/heroku-buildpack-fusionjs
git commit -m "Trigger deploy" --allow-empty
git push heroku master
heroku open
```

You should now see your app running in the browser!

## Description

This buildpack automates the `fusion build` call using `$NODE_ENV`. There is an
extra step required which updates /tmp/build_dir to /app in the Fusion.js server
bundle, which is the main reason to use this buildpack. It also does its best to
make sure your app will start and bind to the correct port. You can learn more
about that process below.

## Binding to the Correct Port


Heroku runs apps on random ports, which means your app needs to bind to $PORT.

If your app:
  - Contains a start script that contains "fusion start"
    - but does not contain a Procfile
      - -> A Procfile will be created for you with `web: YOUR START SCRIPT`
    - and contains a Procfile
      - which has a `web` process
        - -> The buildpack will tell you to make sure your process binds to $PORT, but will not make any changes
      - which does not have a `web` process
        - -> A `web` process for "YOUR START SCRIPT" will be appended to your Procfile

  - Contains a start script that does not contain the text "fusion start"
    - -> The buildpack will tell you that we don't know how to handle your start script and that you should make sure it binds to $PORT properly

  - Does not contain a start script
    - -> The buildpack will tell you that we don't know how to handle your start script and that you should make sure it binds to $PORT properly


NOTE: If your start script does not include `--port`, it will be added to the
new `web` process in your Procfile so that your process binds properly.


## More Information

You can find more information about Fusion.js at [fusionjs.com](https://fusionjs.com).
