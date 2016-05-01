import {Socket} from "phoenix";
import Graph from "./graph";

let socket = new Socket("/socket", {params: {token: window.userToken}});
socket.connect();

let channel = socket.channel("urls:test_url", {});

let graph = new Graph();

channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp); })
  .receive("error", resp => { console.log("Unable to join", resp); });

channel.on("update", (payload) => {
  graph.draw(payload);
});

export default socket;
