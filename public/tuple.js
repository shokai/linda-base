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
    if(url() !== location.href) location.href = url();
  });

  $("#tuple").editable("click", function(e){
    try{
      tuple = JSON.parse(e.value);
      if(url() !== location.href) location.href = url();
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

var url = function(){
  var _url = location.protocol+"//"+location.host+"/"+space_name;
  for(var i = 0; i < tuple.length; i++){
    if(tuple[i] && tuple[i].length > 0) _url += "/"+tuple[i];
  };
  return _url;
};
