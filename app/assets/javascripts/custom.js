jQuery(document).ready(function() {
  $('.review_content_button').click(function() {
    switch ($("div:eq(0)",this).text()) {
      // テキストで取得するのは変更に弱すぎるのでやめる
      case "良かった点":
        $('.review_header_bar').animate({'left':'0%'});
        $('.comment_container').css({'transform':'translate(0%,0px)'});
        $('.sticky_test a div:eq(0)').css({'background-color':'#2E88FB'});
        $('.sticky_test a div:eq(1)').text('「良かった点」を投稿');
        var query = $('.sticky_test a').attr('href').replace(/opinion_type=.*&/, 'opinion_type=positive&');
        $('.sticky_test a').attr('href', query);
        break;
      case "改善点":
        $('.review_header_bar').animate({'left':'33.3%'});
        $('.comment_container').css({'transform':'translate(-100%,0px)'});
        $('.sticky_test a div:eq(0)').css({'background-color':'#EB6566'});
        $('.sticky_test a div:eq(1)').text('「改善点」を投稿');
        var query = $('.sticky_test a').attr('href').replace(/opinion_type=.*&/, 'opinion_type=negative&');
        $('.sticky_test a').attr('href', query);
        break;
      case "質問・その他":
        $('.review_header_bar').animate({'left':'66.6%'});
        $('.comment_container').css({'transform':'translate(-200%,0px)'});
        $('.sticky_test a div:eq(0)').css({'background-color':'#F3A533'});
        $('.sticky_test a div:eq(1)').text('「質問・その他」を投稿');
        var query = $('.sticky_test a').attr('href').replace(/opinion_type=.*&/, 'opinion_type=question&');
        $('.sticky_test a').attr('href', query);
        break;
    }
  });
});