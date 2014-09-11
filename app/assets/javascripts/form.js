$(document).ready(function(){

  var stagedInput = "";
  var ffJson = [];

  // ** these call buildStage based on input selector clicks

  $('#text-select').on("click", function(){
    buildStage("text")
  });

  $('#text-area').on("click", function(){
    buildStage("text-area")
  });

  $('#checkbox-select').on("click", function(){
    buildStage("checkbox")
  });

  $('#radio-select').on("click", function(){
    buildStage("radio")
  });

  $('#date-select').on("click", function(){
    buildStage("date")
  });

  $('#dropdown-select').on("click", function(){
    buildStage("dropdown")
  });

  $('#url-select').on("click", function(){
    buildStage("url")
  });

  // ** buildStage handles the construction of the stage based on clicked input selectors

  var buildStage = function(input){
    $('#options-form, #display-form, #add-to-ff h2').empty();
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
        $('#add-to-ff h2').append("Add Text Input");
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
        $('#add-to-ff h2').append("Add Text-Area Input");
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
        $('#add-to-ff h2').append("Add Checkbox Inputs");
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
        $('#add-to-ff h2').append("Add Radio Button Inputs");
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
        $('#add-to-ff h2').append("Add Date Picker");
        break;

      case "dropdown":
        var selectCount = "";
        for(i=1;i<=20;i++){
          selectCount = selectCount + "<option value='" + i.toString() + "'>" + i.toString() + "</option>"
        }
        $('#options-form').append(
          "<form>" +
            "<label for='title'>Dropdown Select Title</label><br>" +
            "<input id='title' type='text'>" +
            "<label for='dropdown-count'>Number of Select options:</label>" +
            "<select id='dropdown-count'>" + selectCount + "</select>" +
          "</form><div id='multi-options'></div>"
        );
        $('#display-form').append(
            "<form>" +
              "<label for='display-title' id='title-label'></label><br>" +
              "<select id='dropdown-stage'></select>" +
            "</form>"
        );
        $('#add-to-ff h2').append("Add Drop Down Selector");
        break;

      case "url":
        $('#options-form').append(
            "<form>" +
            "<label for='title'>Website Title</label><br>" +
            "<input id='title' type='text'>" +
            "</form>"
        );
        $('#display-form').append(
            "<form>" +
            "<label for='display-title' id='title-label'></label><br>" +
            "<input id='display-title' type='text' value='http://' disabled>" +
            "</form>"
        );
        $('#add-to-ff h2').append("Add Website Input");
        break;
      default:
    }
    stagedInput = input;
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
      chkbxTitles = chkbxTitles + "<li><input id='chkbx-text-input:"+ i.toString() +"' type='text'>";
      chkbxContents = chkbxContents + "<input type='checkbox' value='"+ i.toString() +"' disabled><div id='chkbx-text-result-"+ i.toString() +"'></div><br>"
    }
    chkbxContents += "</form>";
    chkbxTitles += "</ul>";
    $('#checkbox-container').empty().append(chkbxContents);
    $('#multi-options').empty().append(chkbxTitles);
  });

  // handles checkbox text generation
  $(document).on("keyup", "[id^=chkbx-text-input]", function(){
    inputBox = $(this);
    taggedId = inputBox.attr("id").split(":")[1];
    target = "#chkbx-text-result-" + taggedId;
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
    $(target).empty().append(inputBox.val());
  });

  // handles dropdown option generation
  $(document).on("change", "#dropdown-count", function(){
    var dropdownCount = parseInt($("#dropdown-count").val());
    var dropdownTitles = "<ul>";
    var dropdownContents = "";
    for(i=1;i<=dropdownCount;i++){
      dropdownTitles = dropdownTitles + '<li><input id="dropdown-text:' + i.toString() +'" type="text"></li>';
      dropdownContents = dropdownContents + '<option id="dropdown-option-' + i.toString() + '"></option>';
    }
    dropdownTitles += '</ul>';
    $('#dropdown-stage').empty().append(dropdownContents);
    $('#multi-options').empty().append(dropdownTitles)
  });

  // handles dropdown text generation
  $(document).on("keyup", "[id^=dropdown-text]", function(){
    inputBox = $(this);
    taggedId = inputBox.attr("id").split(":")[1];
    target = "#dropdown-option-" + taggedId;
    $(target).empty().append(inputBox.val());
  });

  // ** addToFinalForm takes the staged input type abd the options-form details to write to the ffJson and db

  $(document).on("click", "#add-to-ff",function(){
    addToFinalForm(stagedInput)
  });

  var addToFinalForm = function(stagedInput){
    switch(stagedInput){
      case "text":
        titleText = $("#title").val();
        ffJson.push( {type: "text", titleText: titleText} );
        $('#options-form').empty();
        $('#display-form').empty();
        $('#add-to-ff h2').empty().append("Add Form Input");
        break;

      case "text-area":
        titleText = $("#title").val();
        ffJson.push( {type: "text-area", title: titleText} );
        $('#options-form').empty();
        $('#display-form').empty();
        $('#add-to-ff h2').empty().append("Add Form Input");
        break;

      case "checkbox":
        titleText = $("#title").val();
        boxCount = parseInt($("#chkbx-count").val());
        optionTitles = [];
        for(i=1;i<=boxCount;i++){
          labelValue = $('#chkbx-text-result-'+ i.toString()).text();
          optionTitles.push(labelValue)
        }
        ffJson.push( {type: "checkbox", title: titleText, options: optionTitles} );
        $('#options-form').empty();
        $('#display-form').empty();
        $('#add-to-ff h2').empty().append("Add Form Input");
        break;

      case "radio":
        titleText = $("#title").val();
        boxCount = parseInt($("#radio-count").val());
        optionTitles = [];
        for(i=1;i<=boxCount;i++){
          labelValue = $('#radio-text-result-'+ i.toString()).text();
          optionTitles.push(labelValue)
        }
        ffJson.push( {type: "radio", title: titleText, options: optionTitles} );
        $('#options-form').empty();
        $('#display-form').empty();
        $('#add-to-ff h2').empty().append("Add Form Input");
        break;

      case "date":
        titleText = $("#title").val();
        ffJson.push( {type: "date", title: titleText} );
        $('#options-form').empty();
        $('#display-form').empty();
        $('#add-to-ff h2').empty().append("Add Form Input");
        break;

      case "dropdown":
        titleText = $("#title").val();
        selectCount = parseInt($("#dropdown-count").val());
        optionTitles = [];
        for(i=1;i<=selectCount;i++){
          labelValue = $('#dropdown-option-'+ i.toString()).text();
          optionTitles.push(labelValue);
        }
        ffJson.push( {type: "dropdown", title: titleText, options: optionTitles} );
        $('#options-form').empty();
        $('#display-form').empty();
        $('#add-to-ff h2').empty().append("Add Form Input");
        break;
      case "url":
        titleText = $("#title").val();
        ffJson.push( {type: "url", title: titleText} );
        $('#options-form').empty();
        $('#display-form').empty();
        $('#add-to-ff h2').empty().append("Add Form Input");
        break;

      default:
    }
    renderFinalForm(ffJson)
  };

  var renderFinalForm = function(json){
    var finalForm = "";
    var idCount = 0;
    json.forEach(function(formInput){
      switch(formInput.type){

        case "text":
          finalForm = finalForm + "<label for='title'>"+ formInput.titleText +"</label><br>" +
                                  "<input id='title-" + idCount.toString() + "' type='text'>";
          break;

        case "text-area":
          break;

        case "checkbox":
          break;

        case "radio":
          break;

        case "date":
          break;

        case "dropdown":
          break;

        case "url":
          break;

        default:
      }
    });
    $("#final-form").empty().append(finalForm)
  }

});