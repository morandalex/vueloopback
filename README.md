# mysql-loopback-vue-boilerplate

The goal of this project:

I am going to develop an app that

-   it autoloads tables in mysql and serve them through REST api
-   it allows me to access data through frontend interface

* * *

## Server side

Technology used: LOOPBACK v4

#### install the dependencies of the project

    npm install -g @loopback/cli

#### install the dependencies of the project

    npm install

#### Install the mysql connector

    npm install loopback-connector-mysql

#### Create a **datasources.json** file

    {
      "db": {
        "host": "localhost",
        "port": 3306,
        "url": "",
        "database": "hostname",
        "password": "password",
        "name": "db",
        "user": "username",
        "connector": "mysql"
      }
    }

#### Install the tables for user authentication

In "server/" folder  install the tables for user authentication

    node create-lb-tables.js

#### Automigrate mysql tables

run the following script , inserting the name of the table that you want to load

    ./run.sh

#### Start the loopback REST api server

Going in the root  directory:

    node .

#### In order to setup a user

With the script **create-admin.js**  in boot folder you should automatically load the creation of an admin user.

If you want to create a new one :

In the browser go in the swagger ui of loopback

    http://localhost:3000/explorer


Click on "POST User" . Insert the json parameters in order to initialize the first user, as following

{
"email": "a@a.a",
"password": "admin"
}

You should get a Response Class (Status 200)


#### in the root project folder setup the user grants using

    lb acl

Setup tables for the admin ( $owner variable in loopback ).

Then check the json table file in *common/models/* , if you have something like:

    "acls": [
      {
        "accessType": "*",
        "principalType": "ROLE",
        "principalId": "$owner",
        "permission": "ALLOW"
      }
    ],

Then setup grants for users , in example as following:

Setup tables for the user ( $authenticated variable in loopback ).

Then check the json table file in *common/models/* , if you have something like:

    "acls": [
      {
        "accessType": "READ",
        "principalType": "ROLE",
        "principalId": "$authenticated",
        "permission": "ALLOW"
      }
    ],



* * *

## Client side

Technology used VUE

#### install the dependencies of the project

    npm install -g @vue/cli

#### Project setup into client folder

    npm install

#### Compiles and hot-reloads for development

    npm run serve

#### Compiles and minifies for production

    npm run build

#### Run your tests

    npm run test

#### Lints and fixes files

    npm run lint
