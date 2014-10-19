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
  }, 5000);

};
