const Base = require('./base.js');
const readline = require('readline');
const fs = require('fs');

module.exports = class extends Base {


  async indexAction() {
    var sqlStr = fs.readFileSync("src/test.sql").toString().split("\n"),
        result = [];
    
    sqlStr.map((item) => {
      if(!item.includes("--") && item !== "") {
        result.push(item);
      }
    });
    const data = await this.model("users").query(result.join())
    return this.success(data)
  }
  
};
