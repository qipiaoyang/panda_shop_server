const assert = require('assert');

module.exports = class extends think.Controller {
  static get _REST() {
    return true;
  }

  constructor(ctx) {
    super(ctx);
    this.resource = this.getResource();
    this.id = this.getId();
    assert(think.isFunction(this.model), 'this.model must be a function');
    this.modelInstance = this.model(this.resource);
  }
  async __before() {
    this.ctx.state.token = this.ctx.header['token'] || '';
    const tokenSerivce = this.service('token');
    this.ctx.state.userInfo = await tokenSerivce.getUserInfo(this.ctx.state.token);

    // 获取所有开放方法
    const publicAction = this.config('publicAction');
    if (!publicAction.includes(this.ctx.url)) {
      if (this.ctx.state.userInfo.id <= 0) {
        return this.fail(401, '请先登录');
      }
      let userInfo = await this.getUserInfo();
      if (think.isEmpty(userInfo)) {
        return this.fail(401, '用户不存在，请先登录');
      } else {
        this.ctx.state.userInfo = userInfo;
      }
    }
  }

  async getUserInfo() {
    let userId = this.ctx.state.userInfo.id;
    if (think.isEmpty(userId)) return false;
    let userInfo = await this.model('user').getUser({id: userId});
    if (think.isEmpty(userInfo)) return false;
    return userInfo;
  }




  /**
   * get resource
   * @return {String} [resource name]
   */
  getResource() {
    return this.ctx.controller.split('/').pop();
  }
  getId() {
    const id = this.get('id');
    if (id && (think.isString(id) || think.isNumber(id))) {
      return id;
    }
    const last = this.ctx.path.split('/').slice(-1)[0];
    if (last !== this.resource) {
      return last;
    }
    return '';
  }
  async getAction() {
    let data;
    if (this.id) {
      const pk = this.modelInstance.pk;
      data = await this.modelInstance.where({ [pk]: this.id }).find();
      return this.success(data);
    }
    data = await this.modelInstance.select();
    return this.success(data);
  }
  /**
   * put resource
   * @return {Promise} []
   */
  async postAction() {
    const pk = this.modelInstance.pk;
    const data = this.post();
    delete data[pk];
    if (think.isEmpty(data)) {
      return this.fail('data is empty');
    }
    const insertId = await this.modelInstance.add(data);
    return this.success({ id: insertId });
  }
  /**
   * delete resource
   * @return {Promise} []
   */
  async deleteAction() {
    if (!this.id) {
      return this.fail('params error');
    }
    const pk = this.modelInstance.pk;
    const rows = await this.modelInstance.where({ [pk]: this.id }).delete();
    return this.success({ affectedRows: rows });
  }
  /**
   * update resource
   * @return {Promise} []
   */
  async putAction() {
    if (!this.id) {
      return this.fail('params error');
    }
    const pk = this.modelInstance.pk;
    const data = this.post();
    data[pk] = this.id; // rewrite data[pk] forbidden data[pk] !== this.id
    if (think.isEmpty(data)) {
      return this.fail('data is empty');
    }
    const rows = await this.modelInstance.where({ [pk]: this.id }).update(data);
    return this.success({ affectedRows: rows });
  }
  __call() {}
};
