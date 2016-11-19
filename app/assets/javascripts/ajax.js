$(document).on('turbolinks:load', function(){
  function flashMessage(data) {
    var flash = $("<div class='notice'>" + data.notice + "</div>");
    $('body').prepend(flash);
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

  $('#new_message').on('submit', function(e) {

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
      console.log(data);
      $('#message_content').val('');
      $('#new_message_form')[0].reset();
    })
    .fail(function(data) {
      console.log('失敗');
      alert('エラーが発生しました')
    });
  });
});
