const Base = require('./base.js');
const readline = require('readline');
const fs = require('fs');
var linkList = require("pputil").linkList;

module.exports = class extends Base {


  async indexAction() {
    var sqlStr = fs.readFileSync("src/test.sql").toString().split("\n"),
        result = [];
    console.log(linkList,"123123");


    var link_list = new linkList(); // 新建一个链表

    link_list.append(10);
    link_list.append(11);

    console.log(link_list.indexOf(11));

    
    sqlStr.map((item) => {
      if(!item.includes("--") && item !== "") {
        result.push(item);
      }
    });
    const data = await this.model("users").query(result.join())
    
    return this.success(data)
  }
  
  async SelectSimpleAction() {

  }
};
