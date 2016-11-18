$(document).ready(function(){

  $('.endorsements-link').on('click', function(event){
    event.preventDefault();

    var endorsementCount = $(this).siblings('.endorsements_count');
    var endorsementWord = $(this).siblings('.endorsements_word');

    $.post(this.href, function(response){
      var count = response.new_endorsement_count;
      endorsementCount.text(count);
      endorsementWord.text(count == 1 ? 'endorsement' : 'endorsements');
    });

  });
})
