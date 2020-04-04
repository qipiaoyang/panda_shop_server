const Base = require('./base.js');
// const BaseRest = require('./rest.js');

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

    return this.success(data)
  }

  /**
   * @api {post} /admin/auth/login 管理后台登陆接口
   * @apiName 用户登陆
   * @apiGroup 用户模块
   *
   * @apiParam {String} mobile 用户手机号
   * @apiParam {String} password 用户密码
   *
   * @apiSuccess {String} token 用户token
   */
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
    const data = await this.model("user").where({ mobile: mobile }).find();
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
    });

    return this.success(result);
  }

  /**
   * @api {post} /admin/auth/logout 管理后台退出接口
   * @apiName 用户登出
   * @apiGroup 用户模块
   *
   * @apiParam {String} token 用户token
   *
   *
   */
  async logoutAction() {
    return this.success();
  }


};
