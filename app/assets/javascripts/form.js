$(document).ready(function(){
  $('#text-select').on("click", function(){
    $('#options-form, #display-form').empty();
    buildStage("text")
  });

  var buildStage = function(input){
    switch(input){
      case "text":
        $('#options-form').append(
          "<form>" +
            "<label for='title'>Text Input Title</label><br>" +
            "<input id='title' type='text'>" +
          "</form>"
        );
        $('#display-form').append(
          "<form>" +
            "<label for='display-title' id='title-label'></label><br>" +
            "<input id='display-title' type='text' disabled>" +
          "</form>"
        );
        break;

      case "text-area":

        break;
      default:
    }
  };

  $(document).on("keyup","#title", function(){
    $('#title-label').empty().append($('#title').val())
  });

});