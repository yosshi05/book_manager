# 安定して動作するRubyのバージョンを指定
FROM ruby:3.2.2

# 必要なパッケージのインストール
RUN apt-get update -qq && apt-get install -y build-essential libvips nodejs

# アプリケーションの配置場所
WORKDIR /rails

# 本番環境としての設定
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development test"

# Gemのインストール
COPY Gemfile Gemfile.lock ./
RUN bundle install

# アプリケーションコードのコピー
COPY . .

# デザイン（アセット）の事前コンパイル
RUN SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile

# 起動時に必ずデータベースのマイグレーションを実行し、その後にサーバーを起動する命令
CMD ["sh", "-c", "bundle exec rails db:migrate && bundle exec rails server -b 0.0.0.0 -p 10000"]