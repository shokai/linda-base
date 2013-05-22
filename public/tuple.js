var linda = new Linda();
var ts = new linda.TupleSpace(space_name);

var log = function(msg){
  console.log(msg);
  if(typeof msg !== "string") msg = JSON.stringify(msg);
  var watch_msg = $("<p>").text(msg).append(" - "+ new Date().toString());
  watch_msg.fadeIn(600);
  $("#watch").prepend(watch_msg);
};

linda.io.on("connect", function(){
  ts.watch(tuple, function(tuple){
    log(tuple);
  });

  $("#btn_write").click(function(e){
    ts.write(tuple);
  });
});
