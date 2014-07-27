FROM ubuntu
 
RUN apt-get update
RUN apt-get -y install wget
RUN apt-get -y install git
 
# install Ruby 1.9.3-p484
RUN apt-get -y install build-essential zlib1g-dev libreadline-dev libssl-dev libcurl4-openssl-dev
RUN git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
RUN echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
ENV PATH /.rbenv/bin:/.rbenv/shims:$PATH
RUN echo PATH=$PATH
RUN rbenv init -
RUN rbenv install 1.9.3-p484 && rbenv global 1.9.3-p484

# never install a ruby gem docs
RUN echo "gem: --no-rdoc --no-ri" >> ~/.gemrc
 
# Install bundler and the "bundle" shim
RUN gem install bundler && rbenv rehash
