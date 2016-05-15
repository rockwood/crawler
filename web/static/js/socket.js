import {Socket} from "phoenix";
import Graph from "./graph";

let socket = new Socket("/socket", {params: {token: window.userToken}});
socket.connect();

let channel = socket.channel("crawler:main", {});

let graph = new Graph();

channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp); })
  .receive("error", resp => { console.log("Unable to join", resp); });

channel.on("new_page", (page) => {
  graph.drawPage(page);
});

channel.on("new_link", (link) => {
  graph.drawLink(link);
});

$("form").submit((evt) => {
  evt.preventDefault();
  channel.push("crawl", {url: $("input").val()});
});

export default socket;
