# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
#ActionController::Base.session = {
#  :key         => '_inspire_me_session',
#  :secret      => '9670afd6f1cd1c980dbf849be3ab83c0573fe719d6621f2e65e8ffbdb2790fc1fb9473cc187d296a98386e263a8e72614e9f60950d2d706b1add407f6894f342'
#}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
 ActionController::Base.session_store = :active_record_store
