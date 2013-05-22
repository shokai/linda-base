var linda = new Linda();
var ts = new linda.TupleSpace(space_name);

var log = function(msg){
  console.log(msg);
  if(typeof msg !== "string") msg = JSON.stringify(msg);
  var now = new Date();
  $("#watch").prepend( $("<p>").text(msg).append(" - "+now.toString()) );
};

linda.io.on("connect", function(){
  ts.watch(tuple, function(tuple){
    log(tuple);
  });

  $("#btn_write").click(function(e){
    ts.write(tuple);
  });
});
