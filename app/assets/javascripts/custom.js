jQuery(document).ready(function() {
  $('.review_content_button').click(function() {
    //$('.comment_container').children().css({'visibility':'hidden'});
    switch ($(this).text()) {
      // テキストで取得するのは変更に弱すぎるのでやめる
      case "良かった点":
        $('.review_header_bar').animate({'left':'0%'});
        $('.comment_container').css({'transform':'translate(0%,0px)'});
        //$('.comment_container').animate({'left':'500px'});
        //$('.comment1').css({'visibility':'visible'});
        break;
      case "改善点":
        $('.review_header_bar').animate({'left':'33.3%'});
        $('.comment_container').css({'transform':'translate(-100%,0px)'});
        //$('.comment_container').animate({'left':'0px'});
        //$('.comment2').css({'visibility':'visible'});
        break;
      case "質問・その他":
        $('.review_header_bar').animate({'left':'66.6%'});
        $('.comment_container').css({'transform':'translate(-200%,0px)'});
        //$('.comment_container').animate({'left':'-500px'});
        //$('.comment3').css({'visibility':'visible'});
        break;
    }
  });
});