#! /bin/bash

echo 'start script for loading mysql tables '

read -p 'Whats the table name that you want to load in the selected databases in the file serevr/datasources.json   ' TABLE


JSFILEPATH="$TABLE.js"
cat <<EOT >> $JSFILEPATH
'use strict';
const loopback = require('loopback');
const promisify = require('util').promisify;
const fs = require('fs');
const writeFile = promisify(fs.writeFile);
const readFile = promisify(fs.readFile);
const mkdirp = promisify(require('mkdirp'));
const DATASOURCE_NAME = 'db';
const dataSourceConfig = require('./server/datasources.json');
const db = new loopback.DataSource(dataSourceConfig[DATASOURCE_NAME]);
discover().then(
success => process.exit(),
error => { console.error('UNHANDLED ERROR:\n', error); process.exit(1); },
);
async function discover() {
const options = {relations: true};
const $TABLE = await db.discoverSchemas('$TABLE', options);
await mkdirp('common/models');
$TABLE['lbvue.$TABLE']['name'] = '$TABLE';
await writeFile(
'common/models/$TABLE.json',
JSON.stringify($TABLE['lbvue.$TABLE'], null, 2)
);
const configJson = await readFile('server/model-config.json', 'utf-8');
console.log('MODEL CONFIG', configJson);
const config = JSON.parse(configJson);
config.$TABLE = {dataSource: DATASOURCE_NAME, public: true};
await writeFile(
'server/model-config.json',
JSON.stringify(config, null, 2)
);
}
EOT


node $JSFILEPATH

mv $JSFILEPATH  load-mysql/
