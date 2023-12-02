FROM ruby:2.7.2
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /code

RUN apt-get update -y && apt-get install apt-utils nodejs npm webpack libpq-dev -y
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
        && apt-get install -y nodejs

# Install Yarn.
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn
RUN gem update bundler
RUN apt install git -y
# RUN mkdir -p /var/www/demo
WORKDIR /var/www
RUN git clone https://github.com/Yokeshwer/yokesh-ror-application.git
WORKDIR /var/www/yokesh-ror-application
RUN bundle install
RUN chmod +x ./entrypoint.sh
ENTRYPOINT [ "./entrypoint.sh" ]
CMD [ "bundle", "exec", "rails", "s" ]
