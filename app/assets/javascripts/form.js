$(document).ready(function(){
  $('#text-select').on("click", function(){
    $('#options-form, #display-form').empty();
    buildStage("text")
  });

  $('#text-area').on("click", function(){
    $('#options-form, #display-form').empty();
    buildStage("text-area")
  });

  $('#checkbox-select').on("click", function(){
    $('#options-form, #display-form').empty();
    buildStage("checkbox")
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
        $('#options-form').append(
            "<form>" +
            "<label for='title'>Text Area Input Title</label><br>" +
            "<input id='title' type='text'>" +
            "</form>"
        );
        $('#display-form').append(
            "<label for='display-title' id='title-label'></label><br>" +
            "<textarea id='display-title' disabled>"
        );
        break;

      case "checkbox":
        var selectCount = "";
        for(i=1;i<=20;i++){
          selectCount = selectCount + "<option value='" + i.toString() + "'>" + i.toString() + "</option>"
        }
        console.log(selectCount);
        $('#options-form').append(
            "<form>" +
            "<label for='title'>Checkbox Title</label><br>" +
            "<input id='title' type='text'>" +
            "<label for='chkbx-count'>Number of checkboxes:</label>" +
            "<select id='chkbx-count'>" + selectCount + "</select>" +
            "</form>"
        );
        $('#display-form').append(
            "<label for='display-title' id='title-label'></label><br>" +
            "<div id='checkbox-container'></div>"
        );
        break;

      default:
    }
  };

  $(document).on("keyup","#title", function(){
    $('#title-label').empty().append($('#title').val())
  });

  $(document).on("change","#chkbx-count",function(){
    var boxCount = parseInt($("#chkbx-count").val());
    console.log(boxCount);
    $('#checkbox-container').empty().append()
  });

});