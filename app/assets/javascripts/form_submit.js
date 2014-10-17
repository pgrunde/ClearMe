var renderSubmitForm = function (json) {
  var finalForm = "";
  var idCount = 0;
  json.forEach(function (formInput) {
    switch (formInput.type) {

      case "text":
        finalForm = finalForm + "<label for='ff-title-" + idCount.toString() + "'>" + formInput.title + "</label><br>" +
          "<input id='ff-title-" + idCount.toString() + "' type='text'><br/>";
        finalForm = finalForm + "<br/>";
        break;

      case "text-area":
        finalForm = finalForm + "<label for='ff-title-" + idCount.toString() + "'>" + formInput.title + "</label><br>" +
          "<textarea id='ff-title-" + idCount.toString() + "'></textarea><br/>";
        finalForm = finalForm + "<br/>";
        break;

      case "checkbox":
        finalForm = finalForm + "<label for='ff-title-" + idCount.toString() + "'>" + formInput.title + "</label><br>";
        formInput.options.forEach(function (name) {
          finalForm = finalForm + "<input type='checkbox' id='ff-chkbx-" + name + "' value='" + name + "'>" + name + "<br/>"
        });
        finalForm = finalForm + "<br/>";
        break;

      case "radio":
        finalForm = finalForm + "<form><label for='ff-radio-" + idCount.toString() + "'>" + formInput.title + "</label><br>";
        formInput.options.forEach(function (name) {
          finalForm = finalForm + "<input type='radio' id='ff-radio-" + idCount.toString()  + "' name='ff-radio-" + idCount.toString() + "' value='"+ name + "'>" + name + "<br/>"
        });
        finalForm = finalForm + "</form><br/>";
        break;

      case "date":
        finalForm = finalForm + "<label for='ff-title-" + idCount.toString() + "'>" + formInput.title + "</label><br>" +
          "<input id='ff-title-" + idCount.toString() + "' type='text' value='dd/mm/yyyy'><br/>";
        finalForm = finalForm + "<br/>";
        break;

      case "dropdown":
        finalForm = finalForm + "<label for='ff-title-" + idCount.toString() + "'>" + formInput.title + "</label><br><select id='" + formInput.titleText + "'>";
        formInput.options.forEach(function (name) {
          finalForm = finalForm + "<option value='" + name + "'>" + name + "</option>"
        });
        finalForm = finalForm + "</select><br/>";
        break;

      case "url":
        finalForm = finalForm + "<label for='ff-title-" + idCount.toString() + "'>" + formInput.title + "</label><br>" +
          "<input id='ff-title-" + idCount.toString() + "' type='text' value='http://'><br/>";
        finalForm = finalForm + "<br/>";
        break;

      default:
    }
    idCount += 1;
  });
  $("#candidate-submit-form").empty().append(finalForm);
};
var ffJson = [];

function pushObj(object){
  ffJson.push(object)
}

gon.formdata.json.forEach(pushObj);
renderSubmitForm(ffJson);

// $("input:radio[name=ff-radio-1]:checked")