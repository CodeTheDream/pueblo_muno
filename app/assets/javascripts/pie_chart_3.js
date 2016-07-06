function pieChart3(target, dataset) {
  var dataset = JSON.parse(dataset);
  var chart = '#chart-' + target;

  var width = width();
  // var height = 360;
  var height = height();
  var radius = Math.min(width, height) / 2;
  var donutWidth = Math.min(width, height)/5;
  // var legendRectSize = 18;
  // var legendSpacing = 4;

  // functions for dynamic values
  function width() {
    return $(chart).prev().width();
  };
  function height() {
    return $(window).width() > 768 ? 360 : 200;
  };

  // var color = d3.scale.category20b();
  var color = d3.scale.ordinal()
    .range(['#D25F5B', '#777', '#4D90FE', '#0F9D58', '#8B69C8']);

  $(chart).replaceWith("<div id='chart-"+target+"'></div>");

  var svg = d3.select(chart)
    .append('svg')
    .attr('width', width)
    .attr('height', height)
    .append('g')
    .attr('transform', 'translate(' + (width/2) +  ',' + (height/2) + ')');

  var arc = d3.svg.arc()
    .innerRadius(radius - donutWidth)
    .outerRadius(radius);

  var pie = d3.layout.pie()
    .value(function(d) { return d.num; })
    .sort(null);

  var path = svg.selectAll('path')
    .data(pie(dataset))
    .enter()
    .append('path')
    .attr('d', arc)
    .attr('fill', function(d, i) {
      return color(d.data.str);
    });

  path.on('mouseover', function(d) {
    var total = d3.sum(dataset.map(function(d) {
      return d.num;
    }));
    var percent = Math.round(1000 * d.data.num / total) / 10;
    tooltip.select('.label').html(d.data.str);
    // tooltip.select('.count').html(d.data.num);
    tooltip.select('.percent').html(percent + '%');
    tooltip.style('display', 'block');
  });

  path.on('mouseout', function(d) {
    tooltip.style('display', 'none');
  });

  // var legend = svg.selectAll('.legend')
  //   .data(color.domain())
  //   .enter()
  //   .append('g')
  //   .attr('class', 'legend')
  //   .attr('transform', function(d, i) {
  //     var height = legendRectSize + legendSpacing;
  //     var offset = height * color.domain().length / 2;
  //     var horz = -3 * legendRectSize;
  //     var vert = i * height - offset;
  //     return 'translate(' + horz + ',' + vert + ')';
  //   });
  //
  // legend.append('rect')
  //   .attr('width', legendRectSize)
  //   .attr('height', legendRectSize)
  //   .style('fill', color)
  //   .style('stroke', color);
  //
  // legend.append('text')
  //   .attr('x', legendRectSize + legendSpacing)
  //   .attr('y', legendRectSize - legendSpacing)
  //   .text(function(d) { return d; });

  var tooltip = d3.select(chart)
    .append('div')
    .attr('class', 'tooltip');

  tooltip.append('div')
    .attr('class', 'label');

  // tooltip.append('div')
  //   .attr('class', 'count');

  tooltip.append('div')
    .attr('class', 'percent');
}
