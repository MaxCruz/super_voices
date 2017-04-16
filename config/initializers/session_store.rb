# Be sure to restart your server when you modify this file.

#Rails.application.config.session_store :cookie_store, key: '_super_voices_session'
Rails.application.config.session_store :redis_session_store, {
  key: '_super_voices_session',
  redis: {
    expire_after: 90.minutes,
    key_prefix: 'super-voices:session:',
    url: "redis://#{ENV['REDIS_HOST']}:#{ENV['REDIS_PORT']}/0",
  }
} 

