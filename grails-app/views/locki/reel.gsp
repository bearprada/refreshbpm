<!DOCTYPE html>
<html>
  <head>
    <script type="text/javascript" src="${resource(dir: 'js/d3', file: 'd3.v2.js')}"></script>

    <style type="text/css">

svg {
  border: solid 1px #000;
  display: block;
  margin: auto;
  font-family: "Helvetica Neue";
}

.line {
  fill: none;
  stroke: #000;
  stroke-width: 2px;
}

    </style>
  </head>
  <body>
    <script type="text/javascript">

var margin = {top: 120, right: 60, bottom: 60, left: 60},
    width = 1280 - margin.right - margin.left,
    height = 720 - margin.top - margin.bottom;

var x = d3.time.scale()
    .range([0, width - 60]);

var y = d3.scale.linear()
    .range([height / 4 - 20, 0]);

var duration = 1500,
    delay = 500;

var color = d3.scale.category10();

var svg = d3.select("body").append("svg")
    .attr("width", width + margin.right + margin.left)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

var stocks,
    symbols;

// A line generator, for the dark stroke.
var line = d3.svg.line()
    .interpolate("basis")
    .x(function(d) { return x(d.date); })
    .y(function(d) { return y(d.price); });

// A line generator, for the dark stroke.
var axis = d3.svg.line()
    .interpolate("basis")
    .x(function(d) { return x(d.date); })
    .y(height);

// A area generator, for the dark stroke.
var area = d3.svg.area()
    .interpolate("basis")
    .x(function(d) { return x(d.date); })
    .y0(height / 4 - 20)
    .y1(function(d) { return y(d.price); });

d3.csv("emotioncsv", function(data) {
  var parse = d3.time.format("%b %Y").parse;
  //var filter = {AAPL: 1, AMZN: 1, MSFT: 1, IBM: 1 , PRADA: 1};
  var filter = {happy:1 , sad:1 , angry:1 , nervois:1, love:1,hate:1,disappoint:1}

  stocks = data.filter(function(d) { return d.symbol in filter; });

  // Nest stock values by symbol.
  symbols = d3.nest()
      .key(function(d) { return d.symbol; })
      .entries(stocks);

  // Parse dates and numbers. We assume values are sorted by date.
  // Also compute the maximum price per symbol, needed for the y-domain.
  symbols.forEach(function(s) {
    s.values.forEach(function(d) { 
      //d.date = parse(d.date); 
      d.date = d.date; 
      d.price = +d.price; 
    });
    s.maxPrice = d3.max(s.values, function(d) { return d.price; });
    s.sumPrice = d3.sum(s.values, function(d) { return d.price; });
  });

  // Sort by maximum price, descending.
  symbols.sort(function(a, b) { return b.maxPrice - a.maxPrice; });

  // Compute the minimum and maximum date across symbols.
  x.domain([
    d3.min(symbols, function(d) { return d.values[0].date; }),
    d3.max(symbols, function(d) { return d.values[d.values.length - 1].date; })
  ]);

  var g = svg.selectAll("g")
      .data(symbols)
    .enter().append("g")
      .attr("class", "symbol");

  setTimeout(lines, duration);
});

function lines() {

  var g = svg.selectAll(".symbol")
      .attr("transform", function(d, i) { return "translate(0," + i * height / 4 + ")"; });

  g.each(function(d) {
    var e = d3.select(this);

    e.append("path")
        .attr("class", "line");

    e.append("circle")
        .attr("r", 5)
        .style("fill", function(d) { return color(d.key); })
        .style("stroke", "#000")
        .style("stroke-width", "2px");

    e.append("text")
        .attr("x", 12)
        .attr("dy", ".31em")
        .text(d.key);
  });

  function draw(k) {
    g.each(function(d) {
      var e = d3.select(this);
      y.domain([0, d.maxPrice]);

      e.select("path")
          .attr("d", function(d) { return line(d.values.slice(0, k + 1)); });

      e.selectAll("circle, text")
          .data(function(d) { return [d.values[k], d.values[k]]; })
          .attr("transform", function(d) { return "translate(" + x(d.date) + "," + y(d.price) + ")"; });
    });
  }

  var k = 1, n = symbols[0].values.length;
  d3.timer(function() {
    draw(k);
    if ((k += 2) >= n - 1) {
      draw(n - 1);
      setTimeout(horizons, 500);
      return true;
    }
  });
}

function horizons() {
  svg.insert("defs", ".symbol")
    .append("clipPath")
      .attr("id", "clip")
    .append("rect")
      .attr("width", width)
      .attr("height", height / 4 - 20);

  var color = d3.scale.ordinal()
      .range(["#c6dbef", "#9ecae1", "#6baed6"]);

  var g = svg.selectAll(".symbol")
      .attr("clip-path", "url(#clip)");

  g.select("circle").transition()
      .duration(duration)
      .attr("transform", function(d) { return "translate(" + (width - 60) + "," + (-height / 4) + ")"; })
      .remove();

  g.select("text").transition()
      .duration(duration)
      .attr("transform", function(d) { return "translate(" + (width - 60) + "," + (height / 4 - 20) + ")"; })
      .attr("dy", "0em");

  g.each(function(d) {
    y.domain([0, d.maxPrice]);

    d3.select(this).selectAll(".area")
        .data(d3.range(3))
      .enter().insert("path", ".line")
        .attr("class", "area")
        .attr("transform", function(d) { return "translate(0," + (d * (height / 4 - 20)) + ")"; })
        .attr("d", area(d.values))
        .style("fill", function(d, i) { return color(i); })
        .style("fill-opacity", 1e-6);

    y.domain([0, d.maxPrice / 3]);

    d3.select(this).selectAll(".line").transition()
        .duration(duration)
        .attr("d", line(d.values))
        .style("stroke-opacity", 1e-6);

    d3.select(this).selectAll(".area").transition()
        .duration(duration)
        .style("fill-opacity", 1)
        .attr("d", area(d.values))
        .each("end", function() { d3.select(this).style("fill-opacity", null); });
  });

  setTimeout(areas, duration + delay);
}

function areas() {
  var g = svg.selectAll(".symbol");

  axis
      .y(height / 4 - 21);

  g.select(".line")
      .attr("d", function(d) { return axis(d.values); });

  g.each(function(d) {
    y.domain([0, d.maxPrice]);

    d3.select(this).select(".line").transition()
        .duration(duration)
        .style("stroke-opacity", 1)
        .each("end", function() { d3.select(this).style("stroke-opacity", null); });

    d3.select(this).selectAll(".area")
        .filter(function(d, i) { return i; })
      .transition()
        .duration(duration)
        .style("fill-opacity", 1e-6)
        .attr("d", area(d.values))
        .remove();

    d3.select(this).selectAll(".area")
        .filter(function(d, i) { return !i; })
      .transition()
        .duration(duration)
        .style("fill", color(d.key))
        .attr("d", area(d.values));
  });

  svg.select("defs").transition()
      .duration(duration)
      .remove();

  g.transition()
      .duration(duration)
      .each("end", function() { d3.select(this).attr("clip-path", null); });

  setTimeout(stackedArea, duration + delay);
}

function stackedArea() {
  var stack = d3.layout.stack()
      .values(function(d) { return d.values; })
      .x(function(d) { return d.date; })
      .y(function(d) { return d.price; })
      .out(function(d, y0, y) { d.price0 = y0; })
      .order("reverse");

  stack(symbols);

  y
      .domain([0, d3.max(symbols[0].values.map(function(d) { return d.price + d.price0; }))])
      .range([height, 0]);

  line
      .y(function(d) { return y(d.price0); });

  area
      .y0(function(d) { return y(d.price0); })
      .y1(function(d) { return y(d.price0 + d.price); });

  var t = svg.selectAll(".symbol").transition()
      .duration(duration)
      .attr("transform", "translate(0,0)")
      .each("end", function() { d3.select(this).attr("transform", null); });

  t.select("path.area")
      .attr("d", function(d) { return area(d.values); });

  t.select("path.line")
      .style("stroke-opacity", function(d, i) { return i < 3 ? 1e-6 : 1; })
      .attr("d", function(d) { return line(d.values); });

  t.select("text")
      .attr("transform", function(d) { d = d.values[d.values.length - 1]; return "translate(" + (width - 60) + "," + y(d.price / 2 + d.price0) + ")"; });

  setTimeout(streamgraph, duration + delay);
}

function streamgraph() {
  var stack = d3.layout.stack()
      .values(function(d) { return d.values; })
      .x(function(d) { return d.date; })
      .y(function(d) { return d.price; })
      .out(function(d, y0, y) { d.price0 = y0; })
      .order("reverse")
      .offset("wiggle");

  stack(symbols);

  line
      .y(function(d) { return y(d.price0); });

  var t = svg.selectAll(".symbol").transition()
      .duration(duration);

  t.select("path.area")
      .attr("d", function(d) { return area(d.values); });

  t.select("path.line")
      .style("stroke-opacity", 1e-6)
      .attr("d", function(d) { return line(d.values); });

  t.select("text")
      .attr("transform", function(d) { d = d.values[d.values.length - 1]; return "translate(" + (width - 60) + "," + y(d.price / 2 + d.price0) + ")"; });

  setTimeout(overlappingArea, duration + delay);
}

function overlappingArea() {
  var g = svg.selectAll(".symbol");

  line
      .y(function(d) { return y(d.price0 + d.price); });

  g.select(".line")
      .attr("d", function(d) { return line(d.values); });

  y
      .domain([0, d3.max(symbols.map(function(d) { return d.maxPrice; }))])
      .range([height, 0]);

  area
      .y0(height)
      .y1(function(d) { return y(d.price); });

  line
      .y(function(d) { return y(d.price); });

  var t = g.transition()
      .duration(duration);

  t.select(".line")
      .style("stroke-opacity", 1)
      .attr("d", function(d) { return line(d.values); });

  t.select(".area")
      .style("fill-opacity", .5)
      .attr("d", function(d) { return area(d.values); });

  t.select("text")
      .attr("dy", ".31em")
      .attr("transform", function(d) { d = d.values[d.values.length - 1]; return "translate(" + (width - 60) + "," + y(d.price) + ")"; });

  svg.append("line")
      .attr("class", "line")
      .attr("x1", 0)
      .attr("x2", width - 60)
      .attr("y1", height)
      .attr("y2", height)
      .style("stroke-opacity", 1e-6)
    .transition()
      .duration(duration)
      .style("stroke-opacity", 1);

  setTimeout(groupedBar, duration + delay);
}

function groupedBar() {
  x = d3.scale.ordinal()
      .domain(symbols[0].values.map(function(d) { return d.date; }))
      .rangeBands([0, width - 60], .1);

  var x1 = d3.scale.ordinal()
      .domain(symbols.map(function(d) { return d.key; }))
      .rangeBands([0, x.rangeBand()]);

  var g = svg.selectAll(".symbol");

  var t = g.transition()
      .duration(duration);

  t.select(".line")
      .style("stroke-opacity", 1e-6)
      .remove();

  t.select(".area")
      .style("fill-opacity", 1e-6)
      .remove();

  g.each(function(p, j) {
    d3.select(this).selectAll("rect")
        .data(function(d) { return d.values; })
      .enter().append("rect")
        .attr("x", function(d) { return x(d.date) + x1(p.key); })
        .attr("y", function(d) { return y(d.price); })
        .attr("width", x1.rangeBand())
        .attr("height", function(d) { return height - y(d.price); })
        .style("fill", color(p.key))
        .style("fill-opacity", 1e-6)
      .transition()
        .duration(duration)
        .style("fill-opacity", 1);
  });

  setTimeout(stackedBar, duration + delay);
}

function stackedBar() {
  x.rangeRoundBands([0, width - 60], .1);

  var stack = d3.layout.stack()
      .values(function(d) { return d.values; })
      .x(function(d) { return d.date; })
      .y(function(d) { return d.price; })
      .out(function(d, y0, y) { d.price0 = y0; })
      .order("reverse");

  var g = svg.selectAll(".symbol");

  stack(symbols);

  y
      .domain([0, d3.max(symbols[0].values.map(function(d) { return d.price + d.price0; }))])
      .range([height, 0]);

  var t = g.transition()
      .duration(duration / 2);

  t.select("text")
      .delay(symbols[0].values.length * 10)
      .attr("transform", function(d) { d = d.values[d.values.length - 1]; return "translate(" + (width - 60) + "," + y(d.price / 2 + d.price0) + ")"; });

  t.selectAll("rect")
      .delay(function(d, i) { return i * 10; })
      .attr("y", function(d) { return y(d.price0 + d.price); })
      .attr("height", function(d) { return height - y(d.price); })
      .each("end", function() {
        d3.select(this)
            .style("stroke", "#fff")
            .style("stroke-opacity", 1e-6)
          .transition()
            .duration(duration / 2)
            .attr("x", function(d) { return x(d.date); })
            .attr("width", x.rangeBand())
            .style("stroke-opacity", 1);
      });

  setTimeout(transposeBar, duration + symbols[0].values.length * 10 + delay);
}

function transposeBar() {
  x
      .domain(symbols.map(function(d) { return d.key; }))
      .rangeRoundBands([0, width], .2);

  y
      .domain([0, d3.max(symbols.map(function(d) { return d3.sum(d.values.map(function(d) { return d.price; })); }))]);

  var stack = d3.layout.stack()
      .x(function(d, i) { return i; })
      .y(function(d) { return d.price; })
      .out(function(d, y0, y) { d.price0 = y0; });

  stack(d3.zip.apply(null, symbols.map(function(d) { return d.values; }))); // transpose!

  var g = svg.selectAll(".symbol");

  var t = g.transition()
      .duration(duration / 2);

  t.selectAll("rect")
      .delay(function(d, i) { return i * 10; })
      .attr("y", function(d) { return y(d.price0 + d.price) - 1; })
      .attr("height", function(d) { return height - y(d.price) + 1; })
      .attr("x", function(d) { return x(d.symbol); })
      .attr("width", x.rangeBand())
      .style("stroke-opacity", 1e-6);

  t.select("text")
      .attr("x", 0)
      .attr("transform", function(d) { return "translate(" + (x(d.key) + x.rangeBand() / 2) + "," + height + ")"; })
      .attr("dy", "1.31em")
      .each("end", function() { d3.select(this).attr("x", null).attr("text-anchor", "middle"); });

  svg.select("line").transition()
      .duration(duration)
      .attr("x2", width);

  setTimeout(donut,  duration / 2 + symbols[0].values.length * 10 + delay);
}

function donut() {
  var g = svg.selectAll(".symbol");

  g.selectAll("rect").remove();

  var pie = d3.layout.pie()
      .value(function(d) { return d.sumPrice; });

  var arc = d3.svg.arc();

  g.append("path")
      .style("fill", function(d) { return color(d.key); })
      .data(function() { return pie(symbols); })
    .transition()
      .duration(duration)
      .tween("arc", arcTween);

  g.select("text").transition()
      .duration(duration)
      .attr("dy", ".31em");

  svg.select("line").transition()
      .duration(duration)
      .attr("y1", 2 * height)
      .attr("y2", 2 * height)
      .remove();

  function arcTween(d) {
    var path = d3.select(this),
        text = d3.select(this.parentNode.appendChild(this.previousSibling)),
        x0 = x(d.data.key),
        y0 = height - y(d.data.sumPrice);

    return function(t) {
      var r = height / 2 / Math.min(1, t + 1e-3),
          a = Math.cos(t * Math.PI / 2),
          xx = (-r + (a) * (x0 + x.rangeBand()) + (1 - a) * (width + height) / 2),
          yy = ((a) * height + (1 - a) * height / 2),
          f = {
            innerRadius: r - x.rangeBand() / (2 - a),
            outerRadius: r,
            startAngle: a * (Math.PI / 2 - y0 / r) + (1 - a) * d.startAngle,
            endAngle: a * (Math.PI / 2) + (1 - a) * d.endAngle
          };

      path.attr("transform", "translate(" + xx + "," + yy + ")");
      path.attr("d", arc(f));
      text.attr("transform", "translate(" + arc.centroid(f) + ")translate(" + xx + "," + yy + ")rotate(" + ((f.startAngle + f.endAngle) / 2 + 3 * Math.PI / 2) * 180 / Math.PI + ")");
    };
  }

  setTimeout(donutExplode, duration + delay);
}

/*
function donutTransition() {
  var r0 = height / 2 - x.rangeBand() / 2,
      r1 = height / 2,
      pie1 = d3.layout.pie().value(function(d) { return d.sumPrice; })(symbols),
      pie2 = d3.layout.pie().value(function(d) { return d.maxPrice; })(symbols),
      arc = d3.svg.arc();

  svg.selectAll(".symbol path")
      .datum(function(d, i) {
        d = pie1[i];
        d.innerRadius = r0;
        d.outerRadius = r1;
        d.next = pie2[i];
        return d;
      })
      .each(transitionSplit);

  function transitionSplit(d, i) {
    d3.select(this).transition()
        .duration(duration / 2)
        .tween("arc", tweenArc({
          innerRadius: i & 1 ? r0 : (r0 + r1) / 2,
          outerRadius: i & 1 ? (r0 + r1) / 2 : r1
        }))
        .each("end", transitionRotate);
  }

  function transitionRotate(d, i) {
    var a0 = d.next.startAngle + d.next.endAngle,
        a1 = d.startAngle - d.endAngle;
    d3.select(this).transition()
        .duration(duration / 2)
        .tween("arc", tweenArc({
          startAngle: (a0 + a1) / 2,
          endAngle: (a0 - a1) / 2
        }))
        .each("end", transitionResize);
  }

  function transitionResize(d, i) {
    d3.select(this).transition()
        .duration(duration / 2)
        .tween("arc", tweenArc({
          startAngle: d.next.startAngle,
          endAngle: d.next.endAngle
        }))
        .each("end", transitionUnite);
  }

  function transitionUnite(d, i) {
    d3.select(this).transition()
        .duration(duration / 2)
        .tween("arc", tweenArc({
          innerRadius: r0,
          outerRadius: r1
        }));
  }

  function tweenArc(b) {
    return function(a) {
      var path = d3.select(this),
          text = d3.select(this.nextSibling),
          i = d3.interpolate(a, b);
      for (var key in b) a[key] = b[key]; // update data
      return function(t) {
        var a = i(t);
        path.attr("d", arc(a));
        text.attr("transform", "translate(" + arc.centroid(a) + ")translate(" + width / 2 + "," + height / 2 +")rotate(" + ((a.startAngle + a.endAngle) / 2 + 3 * Math.PI / 2) * 180 / Math.PI + ")");
      };
    }
  }

  setTimeout(donutExplode, 2 * duration + delay);
}
*/

function donutExplode() {
  var r0a = height / 2 - x.rangeBand() / 2,
      r1a = height / 2,
      r0b = 2 * height - x.rangeBand() / 2,
      r1b = 2 * height,
      arc = d3.svg.arc();

  svg.selectAll(".symbol path")
      .each(transitionExplode);

  function transitionExplode(d, i) {
    d.innerRadius = r0a;
    d.outerRadius = r1a;
    d3.select(this).transition()
        .duration(duration / 2)
        .tween("arc", tweenArc({
          innerRadius: r0b,
          outerRadius: r1b
        }));
  }

  function tweenArc(b) {
    return function(a) {
      var path = d3.select(this),
          text = d3.select(this.nextSibling),
          i = d3.interpolate(a, b);
      for (var key in b) a[key] = b[key]; // update data
      return function(t) {
        var a = i(t);
        path.attr("d", arc(a));
        text.attr("transform", "translate(" + arc.centroid(a) + ")translate(" + width / 2 + "," + height / 2 +")rotate(" + ((a.startAngle + a.endAngle) / 2 + 3 * Math.PI / 2) * 180 / Math.PI + ")");
      };
    }
  }
}

    </script>
  </body>
</html>