const Base = require('./base.js');
const readline = require('readline');
const fs = require('fs');

module.exports = class extends Base {

  /**
  * @api {get} /user/:id Request User information
  * @apiName GetUser
  * @apiGroup User
  *
  * @apiParam {Number} id Users unique ID.
  *
  * @apiSuccess {String} firstname Firstname of the User.
  * @apiSuccess {String} lastname  Lastname of the User.
  */
  async indexAction() {
    var sqlStr = fs.readFileSync("src/test.sql").toString().split("\n"),
      result = [];

    sqlStr.map((item) => {
      if (!item.includes("--") && item !== "") {
        result.push(item);
      }
    });
    const data = await this.model("users").query(result.join())
    return this.success(data)
  }

  arrayToTree(arr, pid) {
    let temp = [];
    let treeArr = arr;
    treeArr.forEach((item, index) => {
      if (item.pid == pid) {
        if (this.arrayToTree(treeArr, treeArr[index].id).length > 0) {
          // 递归调用此函数
          treeArr[index].children = this.arrayToTree(treeArr, treeArr[index].id);
        }
        temp.push(treeArr[index]);
      }
    });
    return temp;
  }

  async getAction() {
    // const data = await  this.model("orders_extend").query("SELECT * FROM orders_extend");

    // console.log(this.arrayToTree(data,0),"daya");
    // console.log(data)

    // return this.success(this.arrayToTree(data,0));
    const data = await this.model("orders_extend").field("catename").where({id: 4}).find();
    return this.success(data,"data=======")
  }


};
