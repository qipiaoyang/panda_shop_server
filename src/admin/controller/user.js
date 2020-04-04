const Base = require('./base.js');

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
    const data = {
      "name": "panda"
    };
    return this.success(data)
  }

  async addAction() {
    const data = {
      "name": "panda"
    };
    return this.success(data);
  }

  async updateAction() {
    const password = encryptPassword("123456");
    const result = await this.model("auth_user").where({ id: 1 }).update({ password: password });
    if(result) {
      return this.success("更新成功");
    } else {
      return this.fail("更新失败");
    }
  }

};
