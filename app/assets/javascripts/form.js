$(document).ready(function(){

  // ** these call buildStage based on input selector clicks

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

  $('#radio-select').on("click", function(){
    $('#options-form, #display-form').empty();
    buildStage("radio")
  });

  $('#date-select').on("click", function(){
    $('#options-form, #display-form').empty();
    buildStage("date")
  });

  // ** buildStage handles the construction of the stage based on clicked input selectors

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
        $('#options-form').append(
            "<form>" +
              "<label for='title'>Checkbox Select Title</label><br>" +
              "<input id='title' type='text' value='Example'>" +
              "<label for='chkbx-count'>Number of checkboxes:</label>" +
              "<select id='chkbx-count'>" + selectCount + "</select>" +
            "</form><div id='multi-options'></div>"
        );
        $('#display-form').append(
            "<label for='display-title' id='title-label'>Example</label><br>" +
            "<div id='checkbox-container'></div>"
        );
        break;

      case "radio":
        var selectCount = "";
        for(i=1;i<=20;i++){
          selectCount = selectCount + "<option value='" + i.toString() + "'>" + i.toString() + "</option>"
        }
        $('#options-form').append(
            "<form>" +
              "<label for='title'>Radio Select Title</label><br>" +
              "<input id='title' type='text' value='Example'>" +
              "<label for='radio-count'>Number of radio buttons:</label>" +
              "<select id='radio-count'>" + selectCount + "</select>" +
            "</form><div id='multi-options'></div>"
        );
        $('#display-form').append(
            "<label for='display-title' id='title-label'>Example</label><br>" +
            "<div id='radio-container'></div>"
        );
        break;

      case "date":
        $('#options-form').append(
          "<form>" +
            "<label for='title'>Date Select Title</label><br>" +
            "<input id='title' type='text'>" +
          "</form>"
        );
        $('#display-form').append(
          "<form>" +
            "<label for='display-title' id='title-label'></label><br>" +
            "<input id='display-title' type='text' value='mm/dd/yyyy' disabled>" +
          "</form>"
        );
        break;

      default:
    }
  };

  // ** These change based on actions taken in the staging area

  // handles title generation
  $(document).on("keyup","#title", function(){
    $('#title-label').empty().append($('#title').val())
  });

  // handles checkbox selector generation
  $(document).on("change","#chkbx-count",function(){
    var boxCount = parseInt($("#chkbx-count").val());
    var chkbxTitles = "<ul>";
    var chkbxContents = "<form>";
    for(i=1;i<=boxCount;i++){
      chkbxTitles = chkbxTitles + "<li><input id='chkbx-text:"+ i.toString() +"' type='text'>";
      chkbxContents = chkbxContents + "<input type='checkbox' value='"+ i.toString() +"' disabled><div id='chkbx-text-result-"+ i.toString() +"'></div><br>"
    }
    chkbxContents += "</form>";
    chkbxTitles += "</ul>";
    $('#checkbox-container').empty().append(chkbxContents);
    $('#multi-options').empty().append(chkbxTitles);
  });

  // handles checkbox text generation
  $(document).on("keyup", "[id^=chkbx-text]", function(){
    inputBox = $(this);
    taggedId = inputBox.attr("id").split(":")[1];
    target = "#chkbx-text-result-" + taggedId;
    console.log(target);
    $(target).empty().append(inputBox.val());
  });

  // handles radio selector generation
  $(document).on("change", "#radio-count",function(){
    var buttonCount = parseInt($("#radio-count").val());
    var radioTitles = "<ul>";
    var radioContents = "<form>";
    for(i=1;i<=buttonCount;i++){
      radioTitles = radioTitles + '<li><input id="radio-text:' + i.toString() +'" type="text"></li>';
      radioContents = radioContents + "<input type='radio' value='"+ i.toString() +"' disabled><div id='radio-text-result-"+ i.toString() +"'></div><br>"
    }
    radioContents = radioContents + "</form>";
    radioTitles = radioTitles + "</ul>";
    $('#radio-container').empty().append(radioContents);
    $('#multi-options').empty().append(radioTitles)
  });

  // handles radio text generation
  $(document).on("keyup", "[id^=radio-text]", function(){
    inputBox = $(this);
    taggedId = inputBox.attr("id").split(":")[1];
    target = "#radio-text-result-" + taggedId;
    console.log(target);
    $(target).empty().append(inputBox.val());
  });

});