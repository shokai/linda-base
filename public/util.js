if(typeof console === "undefined" || typeof console.log !== "function" || typeof console.error !== "function"){
  console = {
    log: function(str){
    },
    error: function(str){
    }
  }
}
