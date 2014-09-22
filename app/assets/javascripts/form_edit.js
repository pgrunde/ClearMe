function pushObj(object){
  ffJson.push(object)
}
(gon.formdata.json).forEach(pushObj);

renderFinalForm(ffJson);

var updateForm = function(){
  var saveName = $("#save").val();
  var theJson = JSON.stringify(ffJson);
  var theUrl = "/forms/" + gon.formdata.id;
  console.log(theUrl);
  $.ajax({
    type: "PATCH",
    url: theUrl,
    data: {id: gon.formdata.id, title: saveName, json: theJson}
  }).done(window.location.replace("/forms"))
};