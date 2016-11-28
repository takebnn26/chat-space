$(document).on('turbolinks:load', function(){

//フラッシュメッセージ表示
  function flashMessage(data) {
    $('.notice').remove();
    var flash = $("<div class='notice'>メッセージ送信成功messe-jisousinnseikou</div>");
    $('body').prepend(flash);
  };

//メッセージ投稿時、最下部へスクロール
  function scrollBottom() {
    var pos = $(".chat-messages").height();
    $(".chat-body").animate({
      scrollTop: pos
    }, "slow", "swing");
  };

//メッセージのHTML挿入
  function insertHtml(data){
    if (data.image){
      var insertImage = "<br><img src='" + data.image + "' class='message_img'>"
    } else {
      var insertImage = "";
    };
    var html = "<li class='chat-message'>" +
                  "<div class='chat-message__header clearfix'>" +
                    "<p class='chat-message__name'>" +
                    data.name + "</p>" +
                    "<p class='chat-message__time'>" +
                    data.date + "</p></div>" +
                  "<p class='chat-message__body'>" +
                  data.content +
                  "</p>" + insertImage + "</li>"
    return html
  };

//image選択時、自動投稿
  $('#new_image').on('change', function(){
    $('#new_message_submit').click();
  });

//メッセージ投稿時、ajax通信
  $('#new_message_submit').on('click', function(e) {

    e.preventDefault();

    var $form = $('form#new_message_form').get(0);
    var fd = new FormData($form);

    $.ajax({
      url: './messages',
      type: 'POST',
      data: fd,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data) {
      flashMessage(data);
      $('.chat-messages').append(insertHtml(data));
      $('#message_content').val('');
      $('#new_image').val('');
      scrollBottom();
    })
    .fail(function(data) {
      alert('エラーが発生しました')
    });
  });

//setintervalをメッセージ機能につける
  setInterval(reloadMessages, 10000);

  function reloadMessages() {
    $.ajax({
      url: './messages',
      type: 'GET',
      dataType: 'json'
    })
    .done(function(data) {
      console.log(data);
      var reloadHtml = '';
      data.forEach(function (data) {
        reloadHtml += insertHtml(data);
      });

      $('.chat-messages').append(reloadHtml);
      scrollBottom();
    })
  };

});
