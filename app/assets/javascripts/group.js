$(document).on('turbolinks:load', function(){

  function insertUsersList(user) {
    var list = $(
                "<div id='user-search-result'>" +
                  "<div class='chat-group-user users_list clearfix'>" +
                    "<p class='chat-group-users__name'>" +
                      user.name +
                    "</p>" +
                  "</div>" +
                "</div>"
                );
    $('.chat-group-form__search').append(list);
  };


  var preFunc = null;
  var preInput = '';
  var input = '';


  function ajaxSearch(input) {
    $.ajax({
      url:      'search',
      type:     'GET',
      dataType: 'json',
      data:     ( "keyword=" + input )
    })
    .done(function(data) {
      $('.users_list').remove();
      $.each(data, function(i, user) {
        insertUsersList(user);
      });
    })
    .fail(function(data) {
      alert("エラーが発生しました")
    });
  };


  $('#user-search-field').on("keyup", function(e) {
    var input = $.trim($(this).val());
    if(preInput !== input) {
      clearTimeout(preFunc);
      preFunc = setTimeout(ajaxSearch(input), 1000);
    }
    preinput = input;
  });
});
