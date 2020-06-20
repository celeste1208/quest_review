FROM ruby:2.6.3

RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs

RUN mkdir /quest_review

ENV QUEST_REVIEW_ROOT /quest_review
WORKDIR $QUEST_REVIEW_ROOT

ADD ./Gemfile $QUEST_REVIEW_ROOT/Gemfile
ADD ./Gemfile.lock $QUEST_REVIEW_ROOT/Gemfile.lock

RUN bundle install
ADD . $QUEST_REVIEW_ROOT
