var linda = new Linda();
var ts = new linda.TupleSpace(space_name);

linda.io.on("connect", function(){
  ts.watch(tuple, function(tuple){
    log(tuple);
  });
});

$(function(){
  $("#space").editable("click", function(e){
    space_name = e.value;
  });

  $("#tuple").editable("click", function(e){
    try{
      tuple = JSON.parse(e.value);
    }
    catch(ex){
      alert(e.value + " is not valid Tuple");
      e.target.html(e.old_value);
    }
  });

  $("#btn_write").click(function(e){
    ts.write(tuple);
  });
});

var log = function(msg){
  console.log(msg);
  if(typeof msg !== "string") msg = JSON.stringify(msg);
  var watch_msg = $("<p>").text(msg).append(" - "+ new Date().toString());
  watch_msg.fadeIn(600);
  $("#watch").prepend(watch_msg);
};
