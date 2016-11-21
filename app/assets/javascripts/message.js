$(document).on('turbolinks:load', function(){

  function flashMessage(data) {
    var flash = $("<div class='notice'>" + data.notice + "</div>");
    $('body').prepend(flash);
  };

  function scrollBottom() {
    $(".chat-body").scrollTop($('.chat-messages').height());
  };

  function insertHtml(data){
    var html = $(
                "<li class='chat-message'>" +
                  "<div class='chat-message__header clearfix'>" +
                    "<p class='chat-message__name'>" +
                    data.name + "</p>" +
                    "<p class='chat-message__time'>" +
                    data.date + "</p></div>" +
                  "<p class='chat-message__body'>" +
                  data.content + "</p></li>"
                );
    $('.chat-messages').append(html);
  };

  $('#new_message_submit').on('click', function(e) {

    e.preventDefault();
    $.ajax({
      url: './messages',
      type: 'POST',
      data: { message: { content: $('#message_content').val() }},
      dataType: 'json'
    })
    .done(function(data) {
      flashMessage(data);
      insertHtml(data);
      $('#message_content').val('');
      scrollBottom()
    })
    .fail(function(data) {
      alert('エラーが発生しました')
    });
  });
});
