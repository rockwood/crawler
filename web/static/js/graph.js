const d3 = window.d3;
const $ = window.jQuery;

const COLOR = d3.scale.category20();

export default class Graph {
  constructor() {
    const WIDTH = $("body").width();
    const HEIGHT = 1000;

    this.layout = d3.layout.force()
      .charge(-120)
      .linkDistance(30)
      .size([WIDTH, HEIGHT]);

    this.svg = d3.select("body")
      .append("svg")
      .attr("width", WIDTH)
      .attr("height", HEIGHT);
  }

  draw(payload) {
    this.layout
      .nodes(payload.nodes)
      .links(payload.links)
      .start();

    let link = this.svg.selectAll(".link")
      .data(payload.links)
      .enter().append("line")
      .attr("class", "link")
      .style("stroke-width", function(d) { return Math.sqrt(d.value); });

    let node = this.svg
      .selectAll(".node")
      .data(payload.nodes)
      .enter().append("circle")
      .attr("class", "node")
      .attr("r", 5)
      .style("fill", function(d) { return COLOR(d.group); })
      .call(this.layout.drag);

    node
      .append("title")
      .text(function(d) { return d.name; });

    this.layout.on("tick", function() {
      link.attr("x1", function(d) { return d.source.x; })
        .attr("y1", function(d) { return d.source.y; })
        .attr("x2", function(d) { return d.target.x; })
        .attr("y2", function(d) { return d.target.y; });

      node
        .attr("cx", function(d) { return d.x; })
        .attr("cy", function(d) { return d.y; });
    });
  }
}
