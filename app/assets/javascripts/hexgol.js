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

function resolve_polar(coordinate){
  // combine the two vectors
  h = coordinate[1];
  s = coordinate[3];
  x = 0; y = 0;
  theta = Math.PI / 6;

  // if s is positive
  if (s >= 0) {
    x = s * Math.cos(theta);
    y = s * Math.sin(theta);
  } else {
  // if s is negative
    x = -1 * (s * Math.cos(theta));
    y = -1 * (s * Math.sin(theta));
  }

  console.log([h, x, y]);
  return [h+x, y];
};

function to_xy(coordinate,factor,origin){
  xorigin = 1 * origin.x;
  yorigin = 1 * origin.y;
  xy = resolve_polar(coordinate);
  xyx = xy[0];
  xyy = xy[1];
  x = xorigin + (factor * xyx );
  y = yorigin + (factor * xyy );
  return [x,y]
};

function drawHexagon(paper,x,y,r){
  var step = r * Math.cos(Math.PI / 6);
  var tick = r/2;
  //console.log("x: " + x);
  //console.log("y: " + y);
  //console.log("r: " + r);
  //console.log("step: " + step);
  //console.log("tick: " + tick);
  var xostep = x*1 + step*1
  var yotick = y*1 + tick*1
  var xistep = x*1 - step*1
  var yitick = y*1 - tick*1
  var yor = y*1 + r*1
  var yir = y*1 - r*1
  //console.log("xostep: " + xostep);
  path = 'M' + (xostep) + ',' + (yotick)
    + 'L' + (x) + ',' + (yor)
    + 'L' + (xistep) + ',' + (yotick)
    + 'L' + (xistep) + ',' + (yitick)
    + 'L' + (x) + ',' + (yir)
    + 'L' + (xostep) + ',' + (yitick)
    + 'L' + (xostep) + ',' + (yotick);
  hex = paper.path(path);
  //console.log(path);
  //hex.attr("fill", "#f00");
  hex.attr("stroke", "#f00");
  return hex;
};


function canvasClick( e ){
  var x = e.offsetX;
  var y = e.offsetY;
  return [x,y]
};

