const BaseRest = require('./rest.js');

module.exports = class extends BaseRest {

  async getAction() {
    let data;
    if (this.id) {
      const pk = this.modelInstance.pk;
      data = await this.modelInstance.where({ [pk]: this.id }).find();
      return this.success(data);
    }
    // 所有对象
    let order = this.get('order') || 'id ASC';
    let page = this.get('page');
    let name = this.get('name') || "";
    if(!page){
      // 不传分页默认返回所有
      data = await this.modelInstance.where({
        username: ['like', `%${name}%`]
      }).order(order).select();
      return this.success(data);
    }else {
      // 传了分页返回分页数据
      let pageSize = this.get('size') || 10;
      data = await this.modelInstance.where({
        username: ['like', `%${name}%`]
      }).page(page, pageSize).order(order).countSelect();
      return this.success(data);
    }
  }

  async postAction() {
    let data = this.post();
    if (think.isEmpty(data)) {
      return this.fail('data is empty');
    }
    if(think.isEmpty(data.mobile)) {
      return this.fail("请传入手机号");
    }
    if(data.password) {
      data.password = encryptPassword(data.password);
      const hasUser = await this.modelInstance.where({ mobile: data.mobile }).find();
      if(!think.isEmpty(hasUser)) {
        return this.fail("该用户已存在～")
      }
    }
    data.reg_time = getTime();
    // data.update_time = getTime();
    const insertId = await this.modelInstance.add(data);
    return this.success({ id: insertId });
  }

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
    if(!think.isEmpty(data.mobile)) {
      const hasUser = await this.modelInstance.where({ mobile: data.mobile }).find();
      if(!think.isEmpty(hasUser)) {
        return this.fail("该手机号已存在～")
      }
    }

    data.password = encryptPassword(data.password);
    data.update_time = getTime();
    const rows = await this.modelInstance.where({ [pk]: this.id }).update(data);
    return this.success({ affectedRows: rows });
  }



};
