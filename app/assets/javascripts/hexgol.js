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

function hexagon(x,y,w,h){
  return paper.path(
    'M' + (x+12) + ',' + y
    + 'L' + (x+12+w) + ',' + y
    + 'L' + (x+24+w) + ',' + (y+(h/2))
    + 'L' + (x+12+w) + ',' + (y+h)
    + 'L' + (x+12) + ',' + (y+h)
    + 'L' + x + ',' + (y+(h/2))
    + 'L' + (x+12) + ',' + y
  )
};

function drawCircle(paper,a,b,c){
  circle = paper.circle(a,b,c);
  circle.attr("fill", "#f00");
  circle.attr("stroke", "#fff");
};

function drawHexagon(paper,x,y,r){
  step = r * Math.cos(Math.PI / 6);
  tick = r/2;
  hex = paper.path(
    'M' + (x+step) + ',' + (y+tick)
    + 'L' + (x) + ',' + (y+r)
    + 'L' + (x-step) + ',' + (y+tick)
    + 'L' + (x-step) + ',' + (y-tick)
    + 'L' + (x) + ',' + (y-r)
    + 'L' + (x+step) + ',' + (y-tick)
    + 'L' + (x+step) + ',' + (y+tick)
  );
  //hex.attr("fill", "#f00");
  hex.attr("stroke", "#f00");
};
