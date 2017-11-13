# Opinionate
Opinionate gathers different people's opinions on a variety of trending topics. It was created at the MIT Blueprint Hackathon by Harshal Sheth, Michael Colavita, Alok Puranik, and Nihar Sheth, where it won the 2nd place prize.

## Requirements
* Ruby 2.2.2
* Rails 4.2.0
* A MySQL Server
* Foreman Gem
* A Redis Server
* Resque Gem
* Indico.io Gem
* Other gems specified in the Gemfile

## Configuration
When setting up Opinionate, you will have to create the `config/database.yml` and the `config/secrets.yml`.
To create the database and tables, run `rake db:create db:migrate`. Running `reload.sh` will update the database with the newest trends from Google Trends and Twitter Trends. Note that the reload command should be used only if a Resque worker is also running (it will be if the server has been started).

## Deployment
Starting the server is a simple as running `start.sh`. To stop the server, run `stop.sh`. To check if the server is running, run `on.sh`. To restart the server if you have updated the code, run `restart.sh`.
Every few hours, `reload.sh` should be run to update Opinionate with the latest trends. It should be run with the server running in the background, so that Resque can fetch related posts from Twitter and Reddit for each of the new trends.

## Deployment with Docker
To deploy with docker, run `rebuild.sh` with MySQL and Redis already running.

## License
Opinionate is released under the GNU General Public License version 2.
