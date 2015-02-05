# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
secret = Rails.env.production? ? ENV['SECRET_TOKEN'] : "697e60766465e85a32435ec9e476e83d8e56a37518cdb6dd9df8a89bbc96fcb5abc81f0ec2224f388320fa079fd1f897e3c1dee0f87d37e209a157f597067038"
Monumental::Application.config.secret_key_base = secret
