class Notifications
  constructor: ->
    @notifications = $("[data-behavior='notifications']")
    @setup() if @notifications.length > 0

  setup: ->
    @validateSessionAndSetNotifications()
    $(document).on "turbolinks:load", =>
      @validateSessionAndSetNotifications()

    #    $("[data-behavior='notifications-read']").on("click", @handleReadClick)

    setInterval  @getNotification, 5000


  getNotification: () =>
    $.ajax(
      url: "/notifications.json"
      dataType: "JSON"
      method: "GET"
      success: @handleDataToSession
    )

  handleReadClick: (e) =>
    e.preventDefault()
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

  validateSessionAndSetNotifications: () =>
    if sessionStorage['notifications'] != ""
      @setNotifications()

  setNotifications: () =>
    if sessionStorage['notifications'] == undefined
      return
    else
      data = JSON.parse(sessionStorage['notifications'])

      #      unread_count = '
      #        <li class="head text-light bg-dark">
      #          <div class="row">
      #            <div class="col-lg-12 col-sm-12 col-12">
      #              <span>Notifications (' + data.length + ')</span>
      #              <a href="" data-behavior="notifications-read" class="float-right text-light">Mark all as read</a>
      #
      #            </div>
      #          </div>
      #        </li>
      #        '
      items = $.map data, (notification) =>
        returnStmt = '
        <li class="notifcation-box">
        <div class="row">
        <div class="col-lg-3 col-sm-3 col-3 text-center">
        <img src="https://s3.eu-central-1.amazonaws.com/bootstrapbaymisc/blog/24_days_bootstrap/fox.jpg" width="80" height="80" class="rounded-circle">
        </div>
        <div class="col-lg-8 col-sm-8 col-8">
        <strong class="text-info">' +
          notification.actor.first_name + " " + notification.actor.last_name +
          '</strong><div>
         ' + notification.action + '</div><div><a href="'

        returnStmt += notification.model
        returnStmt += "/"
        returnStmt += notification.actor.id
        returnStmt += "/accept"
        returnStmt += '">
          <button type="button" className="btn btn-success btn-sm">Accept</button>
          </a>
          <a href="'
        returnStmt += notification.model
        returnStmt += "/"
        returnStmt += notification.actor.id
        returnStmt += "/decline"
        returnStmt += '">
          <button type="button" className="btn btn-danger btn-sm">Deny</button>
          </a>
          </div>'
        returnStmt += '
          <small class="text-warning">' + Date(notification.created_at) + '</small>
          </div>
          </div>
          </li>
          '
        return returnStmt
      $("[data-behavior='notifications-count']").text("Notifications (" + items.length + ")")
      #      $("[data-behavior='notifications-read']").on("click", @handleReadClick)
      $("#notifications-read").on("click", @handleReadClick)
      $("[data-behavior='notifications-link']").attr('data-count': items.length)
      $("[data-behavior='notification-items']").html(items)

jQuery ->
  new Notifications