<script src="raphael.js"></script>
  var paper = Raphael(10,50,320,200);

  function drawCircle(paper,a,b,c){
    circle = paper.circle(a,b,c);
    circle.attr("fill", "#f00");
    circle.attr("stroke", "#fff");
  };

  function drawWhiteCircle(paper,a,b,c){
    circle = paper.circle(a,b,c);
    circle.attr("fill", "#fff");
    circle.attr("stroke", "#fff");
  };

  function drawCircle2(paper, a,b,c){
    setTimeout(function(){
        drawCircle(paper, a,b,c);
    }, 2000);

    setTimeout(function(){
        drawWhiteCircle(paper, a,b,c);
    }, 2000);

  };

  drawCircle2(paper, 10,10,15);
</script>

