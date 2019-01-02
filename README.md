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

To create the database and tables, run `rake db:create db:schema:load`. The `refresh-trends.sh` command will update the database with the newest trends from Google Trends and Twitter Trends. Note that this command should be used only if a Resque worker is also running (it will be if the server has been started).

## Deployment
Create a file called `env.sh` which defines the variable `SECRET_KEY_BASE`.
The server can be started using docker-compose. On first run, initialize the database by running `docker-compose exec web rake db:create db:schema:load`.

## License
Opinionate is released under the GNU General Public License version 2.
