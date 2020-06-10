/*global jQuery*/
/*global $*/

jQuery(document).on('click', '.review_content_button', function() {
  $('.review_content_button').css({'color':'#949faf'});
  $(this).css({'color':'black'});
  switch ($("div:eq(0)",this).text()) {
    // テキストで取得するのは変更に弱すぎるのでやめる
    case "良かった点":
      $('.review_header_bar').animate({'left':'0%'}, {duration: 300});
      $('.comment_container').css({'transform':'translate(0%,0px)'});
      $('.sticky_test a div:eq(0)').css({'background-color':'#2E88FB'});
      $('.sticky_test a div:eq(1)').text('「良かった点」を投稿');
      var query = $('.sticky_test a').attr('href').replace(/opinion_type=.*&/, 'opinion_type=positive&');
      $('.sticky_test a').attr('href', query);
      break;
    case "改善点":
      $('.review_header_bar').animate({'left':'33.3%'}, {duration: 300});
      $('.comment_container').css({'transform':'translate(-100%,0px)'});
      $('.sticky_test a div:eq(0)').css({'background-color':'#EB6566'});
      $('.sticky_test a div:eq(1)').text('「改善点」を投稿');
      var query = $('.sticky_test a').attr('href').replace(/opinion_type=.*&/, 'opinion_type=negative&');
      $('.sticky_test a').attr('href', query);
      break;
    case "質問・その他":
      $('.review_header_bar').animate({'left':'66.6%'}, {duration: 300});
      $('.comment_container').css({'transform':'translate(-200%,0px)'});
      $('.sticky_test a div:eq(0)').css({'background-color':'#F3A533'});
      $('.sticky_test a div:eq(1)').text('「質問・その他」を投稿');
      var query = $('.sticky_test a').attr('href').replace(/opinion_type=.*&/, 'opinion_type=question&');
      $('.sticky_test a').attr('href', query);
      break;
  }
});

//全部comment-idで統一できるならする。div[comment-id]で検索してるので、問題ないかチェック。
//更新時の処理とかもcomment-idでセレクタ検索してる
jQuery(document).on('click', '.comment_edit_button', function() {
  var comment_id = $(this).data('edit-comment-id');
  $('div[data-comment-id=' + comment_id + '] .comment_edit_form').show();
  $('div[data-comment-id=' + comment_id + '] .comment_content').hide();
});

jQuery(document).on('click', '.comment_edit_cancel', function() {
  var comment_id = $(this).data('edit-comment-cancel-id');
  $('div[data-comment-id=' + comment_id + '] .comment_edit_form').hide();
  $('div[data-comment-id=' + comment_id + '] .comment_content').show();
  var comment_content = $('div[data-comment-id=' + comment_id + '] .comment_content p').html();
  comment_content = comment_content.replace(/<br>/g, "\n");
  $('div[data-comment-id=' + comment_id + '] .comment_edit_form textarea').val(comment_content);
});

jQuery(document).on('click', '.reply_button', function() {
  var comment_id = $(this).data('replied-id');
  $('div[data-comment-id=' + comment_id + '] .reply_form').show();
});

jQuery(document).on('click', '.reply_cancel', function() {
    var comment_id = $(this).data('reply-canceled-id');
    $('div[data-comment-id=' + comment_id + '] .reply_form').hide();
    $('div[data-comment-id=' + comment_id + '] .reply_form textarea').val("");
});