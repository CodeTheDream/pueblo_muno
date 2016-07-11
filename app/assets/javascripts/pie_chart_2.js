function pieChart2(target, dataset, group) {
  var dataset = JSON.parse(dataset);
  var chart = '#chart-' + target;

  var width = width();
  var height = 200;
  var radius = Math.min(width, height) / 2;
  var donutWidth = Math.min(width, height)/5;
  var legendRectSize = 18;
  var legendSpacing = 4;

  // functions for dynamic values
  function width() {
    return $(chart).prev().width();
  };

  if (group == "name") {
    var colors = ['#D25F5B', '#777', '#4D90FE', '#0F9D58', '#8B69C8'];
  } else if (group == "reach") {
    var colors = ['#D25F5B', '#8B69C8', '#F4B400', '#0F9D58', '#4D90FE'];
  };

  // var color = d3.scale.category20();
  var color = d3.scale.ordinal()
    .range(colors);

  $(chart).replaceWith("<div id='chart-"+target+"'></div>");

  var svg = d3.select(chart)
    .append('svg')
    .attr('width', width)
    .attr('height', height+32)
    .append('g')
    .attr('transform', 'translate(' + (width/2) +  ',' + ((height+32)/2) + ')');

  var arc = d3.svg.arc()
    .outerRadius(radius)
    // .innerRadius(radius - donutWidth);
    .innerRadius(0);

  var pie = d3.layout.pie()
    .value(function(d) { return d.num; })
    .sort(null);

  // var path = svg.selectAll('path')
  //   .data(pie(dataset))
  //   .enter()
  //   .append('path')
  //   .attr('d', arc)
  //   .attr('fill', function(d, i) {
  //     return color(d.data.str);
  //   });

  // This is the next legend
  var arcs = svg.selectAll(".arc")
    .data(pie(dataset))
    .enter()
    .append("g")
    .attr("class", "arc");

  arcs.append("path")
    .attr("d", arc)
    .attr("fill", function(d, i) {
      return color(d.data.str);
    });

  arcs.append("text")
    .attr("transform", function(d) {
      var c = arc.centroid(d);
      return "translate(" + c[0]*1.5 + "," + c[1]*1.5 + ")";
    })
    .attr("dy", ".35em")
    .text(function(d){
      var total = d3.sum(dataset.map(function(d) {
        return d.num;
      }));
      var percent = Math.round(1000 * d.data.num / total) / 10;
      if (percent != 0){ return percent + "%"; };
    })
}
