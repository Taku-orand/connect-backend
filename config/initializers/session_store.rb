if Rails.env === 'production'
  Rails.application.config.session_store :cookie_store, key: '_connect-backend', domain: 'https://aizu-connect.herokuapp.com'
else
  Rails.application.config.session_store :cookie_store, key: '_connect-backend'
end
