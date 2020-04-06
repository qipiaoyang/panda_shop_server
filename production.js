const Application = require('thinkjs');
const watcher = require('think-watcher');
const instance = new Application({
  ROOT_PATH: __dirname,
  watcher: watcher,
  env: 'production'
});

instance.run();
