json.partial! "users/user", user: @current_user
json.partial! 'tags/tag', tags: @current_user.tags

# json.user { json.partial! 'users/user', user: @current_user }
# json.api_key @token
