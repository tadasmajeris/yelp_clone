$(document).ready(function(){

  $('.endorsements-link').on('click', function(event){
    event.preventDefault();

    var endorsementCount = $(this).siblings('.endorsements_count');
    var endorsementSpan = $(this).siblings('.endorsements_span');

    $.post(this.href, function(response){
      var text = response.new_endorsement_count === 1 ? 'endorsement' : 'endorsements';
      updateEndorsement(response.new_endorsement_count, text);
    })

    var updateEndorsement = function(count, text) {
      endorsementCount.text(count);
      endorsementSpan.text(text);
    }
  })
})
