json.array! @notifications do |notification|
  json.recipient notification.recipient
  json.actor notification.actor
  json.action notification.action
  json.model notification.model
  json.category notification.category
  json.created_at notification.created_at
  json.updated_at notification.updated_at

  #json.notifiable notification.notifiable
end