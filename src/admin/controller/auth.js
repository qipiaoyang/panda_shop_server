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
      "name": "panda111"
    };
    return this.success(data)
  }


  async loginAction() {
    const mobile = this.post("mobile");
    const password = this.post("password");
    if(think.isEmpty(mobile)) {
      return this.fail("请输入手机号");
    }
    if(think.isEmpty(password)) {
      return this.fail("请输入密码");
    }
    // 加密密码与数据库密码进行对比
    const encrypt_password = encryptPassword(password);
    const data = await this.model("auth_user").where({ mobile: mobile }).find();
    if(encrypt_password !== data.password) {
      return this.fail("请输入正确的密码");
    }

    const TokenService = this.service("token");
    const token = await TokenService.create({ id: data.id, mobile: data.mobile });
    if(think.isEmpty(token)) {
      return this.fail("登陆失败，token下发错误");
    }
    delete data.password;
    const result = Object.assign({},{
      token: token,
      userinfo: data
    });

    return this.success(result);
  }


};