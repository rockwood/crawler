const d3 = window.d3;
const $ = window.jQuery;

const color = d3.scale.category20();

export default class Graph {
  constructor() {
    const WIDTH = $("body").width();
    const HEIGHT = $("body").height();

    this.svg = d3.select("body")
      .append("svg")
      .attr("width", WIDTH)
      .attr("height", HEIGHT);

    this.nodes = [];
    this.links = [];

    this.layout = d3.layout.force()
      .nodes(this.nodes)
      .links(this.links)
      .charge(-120)
      .linkDistance(60)
      .size([WIDTH, HEIGHT]);

    this.layout.on("tick", this.tick.bind(this));
  }

  drawPage(page) {
    console.log(page);
    this.nodes.push({ id: page.id, index: page.id, uri: page.uri });
    this.render();
  }

  drawLink(link) {
    console.log(link);
    this.links.push(link);
    this.render();
  }

  render() {
    let link = this.svg.selectAll(".link")
      .data(this.layout.links());

    link
      .enter()
      .insert("line", ".node")
      .attr("class", "link");

    link.exit().remove();

    let node = this.svg.selectAll(".node")
      .data(this.layout.nodes(), function(d) { return d.id; });

    node.enter()
      .append("circle")
      .attr("class", "circle")
      .attr("class", "node")
      .attr("r", 10)
      .style("fill", function(d) { return color(d.uri.host); });

    node.exit().remove();

    this.layout.start();
  };

  tick() {
    this.svg.selectAll(".link")
      .attr("x1", function(d) { return d.source.x; })
      .attr("y1", function(d) { return d.source.y; })
      .attr("x2", function(d) { return d.target.x; })
      .attr("y2", function(d) { return d.target.y; });

    this.svg.selectAll(".node")
      .attr("cx", function(d) { return d.x; })
      .attr("cy", function(d) { return d.y; });
  };
}
