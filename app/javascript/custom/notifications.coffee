class Notifications
  constructor: ->
    @notifications = $("[data-behavior='notifications']")
    @setup() if @notifications.length > 0

  setup: ->
    @validateSessionAndSet()
    $(document).on "turbolinks:load", =>
      @validateSessionAndSet()

    $("[data-behavior='notifications-link']").on("click", @handleClick)

    setInterval  @getNotification, 5000


  getNotification: () =>
    $.ajax(
      url: "/notifications.json"
      dataType: "JSON"
      method: "GET"
      success: @handleDataToSession
    )

  handleClick: (e) =>
    $.ajax(
      url: "/notifications/mark_as_read"
      dataType: "JSON"
      method: "POST"
      success: ->
        $("[data-behavior='notifications-link']").attr('data-count': '0')
    )

  handleDataToSession: (data) =>
    sessionStorage['notifications'] = JSON.stringify(data)
    @setNotifications()

  validateSessionAndSet: () =>
    if sessionStorage['notifications'] != ""
      @setNotifications()

  setNotifications: () =>
    data = JSON.parse(sessionStorage['notifications'])
    unread_count = '
      <li class="head text-light bg-dark">
        <div class="row">
          <div class="col-lg-12 col-sm-12 col-12">
            <span>Notifications (' + data.length + ')</span>
          </div>
        </div>
      </li>
      '
    items = $.map data, (notification) =>
      '
       <li class="notifcation-box">
        <div class="row">
          <div class="col-lg-3 col-sm-3 col-3 text-center">
            <img src="https://s3.eu-central-1.amazonaws.com/bootstrapbaymisc/blog/24_days_bootstrap/fox.jpg" width="80" height="80" class="rounded-circle">
          </div>
          <div class="col-lg-8 col-sm-8 col-8">
            <strong class="text-info">' +
        notification.actor.first_name + " " + notification.actor.last_name +
        '</strong>
          <div>
           ' + notification.action + '
            </div>
            <small class="text-warning">' + Date(notification.notifiable.created_at) + '</small>
          </div>
        </div>
      </li>
      '
    $("[data-behavior='notifications-link']").attr('data-count': items.length)
    $("[data-behavior='notification-items']").html(unread_count + items)

jQuery ->
  new Notifications