FROM ruby:2.2

# see update.sh for why all "apt-get install"s have to stay as one long line
RUN apt-get update -qq && apt-get install -y -qq --no-install-recommends nodejs cron curl supervisor

# see http://guides.rubyonrails.org/command_line.html#rails-dbconsole
RUN apt-get update -qq && apt-get install -y -qq --no-install-recommends mysql-client postgresql-client sqlite3

# add supercronic (https://github.com/aptible/supercronic)
ENV SUPERCRONIC_URL=https://github.com/aptible/supercronic/releases/download/v0.1.5/supercronic-linux-amd64 \
    SUPERCRONIC=supercronic-linux-amd64 \
    SUPERCRONIC_SHA1SUM=9aeb41e00cc7b71d30d33c57a2333f2c2581a201
RUN curl -fsSLO "$SUPERCRONIC_URL" \
 && echo "${SUPERCRONIC_SHA1SUM}  ${SUPERCRONIC}" | sha1sum -c - \
 && chmod +x "$SUPERCRONIC" \
 && mv "$SUPERCRONIC" "/usr/local/bin/${SUPERCRONIC}" \
 && ln -s "/usr/local/bin/${SUPERCRONIC}" /usr/local/bin/supercronic

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v 1.17.3 && bundle install --jobs 20 --retry 5

# Set up supervisor
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY . .

CMD ["/usr/bin/supervisord"]

