FROM ruby:2.2

# see update.sh for why all "apt-get install"s have to stay as one long line
RUN apt-get update && apt-get install -y nodejs cron curl --no-install-recommends && rm -rf /var/lib/apt/lists/*

# see http://guides.rubyonrails.org/command_line.html#rails-dbconsole
RUN apt-get update && apt-get install -y mysql-client postgresql-client sqlite3 --no-install-recommends && rm -rf /var/lib/apt/lists/*

# connect volume (`pwd`) using -v `pwd`:/app

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN pwd && ls
RUN gem install bundler && bundle install --jobs 20 --retry 5

COPY env.sh .
RUN . ./env.sh

COPY crontab .
RUN crontab crontab

CMD cron && . ./env.sh && (rm tmp/pids/server.pid || true) && bundle exec foreman start -c resque=4,web=1

