json.array! @notifications do |notification|
  json.recipient notification.recipient
  json.actor notification.actor
  json.action notification.action
  json.category notification.category
  json.notifiable notification.notifiable
end